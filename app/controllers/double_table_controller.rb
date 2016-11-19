class DoubleTableController < ApplicationController
  # POST /double_table
  def double_table
    table1 = params[:table1].upcase
    attr1 = params[:attr1].upcase
    table2 = params[:table2].upcase
    attr2 = params[:attr2].upcase

    tup_arr_t1 = MongoModel.represent_table(table1)
    tup_arr_t2 = MongoModel.represent_table(table2, false)

    tup_arr_t1.each do |tup|

      look_for = tup[attr1].nil? ? tup['_id'][attr1] : tup[attr1]

      i = tup_arr_t2.find_index do |item|
        item[attr2] == look_for
      end
      if tup[attr1].nil?
        tup['_id'][attr1] = tup_arr_t2[i]
      else
        tup[attr1] = tup_arr_t2[i]
      end
    end

    @oracle = {table_name: table1, tuples: tup_arr_t1}

  end

  # GET /double_table
  def double_menu
    @options_table = []
    i = 0
    # fill the options array with all tables
    Oracle.each_row('user_tables') do |row|
      @options_table[i] = [row['TABLE_NAME'], row['TABLE_NAME']]
      i = i + 1
    end
    # fill the options array with all views
    Oracle.each_row('user_views') do |row|
      @options_table[i] = [row['VIEW_NAME'], row['VIEW_NAME']]
      i = i + 1
    end

  end
end