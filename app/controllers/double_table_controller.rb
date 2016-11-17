class DoubleTableController < ApplicationController
  # POST /double_table
  def double_table
    attr1 = params[:attr1]
    attr2 = params[:attr2]

    # TODO essa parte
  end

  # GET /double_table
  def double_menu
    @optionsTable = []
    i = 0
    # fill the options array with all tables
    Oracle.each_row('user_tables') do |row|
      @optionsTable[i] = [row['TABLE_NAME'], row['TABLE_NAME']]
      i = i + 1
    end
    # fill the options array with all views
    Oracle.each_row('user_views') do |row|
      @optionsTable[i] = [row['VIEW_NAME'], row['VIEW_NAME']]
      i = i + 1
    end

  end
end