class SimpleTableController < ApplicationController
  # POST /simple_table
  def simple_table
    return redirect_to root_url, alert: 'failed to understand table' unless params[:table]

    table = params[:table].upcase # normalize table name to upper case
    # get all pks of current table

    tup_arr = MongoModel.represent_table(table)

    @oracle = {table_name: table, tuples: tup_arr}

    render 'oracle/mongo_script'

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