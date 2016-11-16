class SimpleTableController < ApplicationController
  # POST /simple_table
  def simple_table
    return redirect_to root_url, alert: 'failed to understand table' unless params[:table]

    table = params[:table].upcase # normalize table name to upper case
    # get all pks of current table
    pks = Oracle.get_pks(table)

    tup_arr = []
    Oracle.each_row(table) do |row|
      # start by adding everything in the oracle database to the BSON dictionary
      tup = row
      # create a empty '_id' field
      tup['_id'] = {}
      # for each existing primary key in the oracle database
      pks.each do |pk|
        # delete the pk from the dictionary
        el = tup.delete(pk)
        # and add it to the '_id' field
        tup['_id'][pk] = el
      end
      # remove every 'null' field
      tup.delete_if do |_, v|
        v.nil? || ( v.kind_of?(Hash) && v.empty? )
      end

      tup_arr.append tup
    end

    @oracle = {table_name: table, tuples: tup_arr}

  end

  # GET simple_table
  def simple_menu
    i = 0
    @options = []
    # fill the options array with all tables
    Oracle.each_row('user_tables') do |row|
      @options[i] = [row['TABLE_NAME'], row['TABLE_NAME']]
      i = i + 1
    end
    # fill the options array with all views
    Oracle.each_row('user_views') do |row|
      @options[i] = [row['VIEW_NAME'], row['VIEW_NAME']]
      i = i + 1
    end
  end
end