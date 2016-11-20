class DoubleTableController < ApplicationController
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

  # POST /double_table
  def function_selector

    embedding = params[:embed] == '1'

    table1 = params[:table1].upcase
    attr1 = params[:attr1].upcase
    table2 = params[:table2].upcase
    attr2 = params[:attr2].upcase

    tup_arr_t1 = MongoModel.represent_table(table1)
    tup_arr_t2 = MongoModel.represent_table(table2, !embedding)

    tup_arr_t1.each do |tup|

      look_for = tup[attr1].nil? ? tup['_id'][attr1] : tup[attr1]

      i = tup_arr_t2.find_index do |item|
        puts "looking for '#{look_for}' in '#{item.inspect}'"
        item[attr2] == look_for || (!item['_id'].nil? && item['_id'][attr2] == look_for )
      end

      unless i.nil?
        to_set = tup_arr_t2[i]
        to_set = to_set['_id'] unless embedding

        if tup[attr1].nil?
          # tup['_id'][attr1] = to_set
          tup['_id'][table2] = to_set
          tup['_id'].delete attr1
        else
          # tup[attr1] = to_set
          tup[table2] = to_set
          tup.delete attr1
        end
      end
    end
    @oracle = {table_name: table1, tuples: tup_arr_t1, back_path: double_table_path}

    render 'oracle/mongo_script'
  end
end