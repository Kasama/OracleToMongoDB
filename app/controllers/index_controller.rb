class IndexController < ApplicationController
  # GET /index
  def table_selection
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

  # POST /index
  def create
    return redirect_to root_url, alert: 'failed to understand table' unless params[:table]

    table = params[:table].upcase

    uniques = Oracle.get_uniques table

    uniques = uniques.map { |u| '"' + u + '": 1' }

    uniques = uniques.join(',')

    @oracle = {table: table, uniques: uniques, back_path: index_table_path}

  end
end
