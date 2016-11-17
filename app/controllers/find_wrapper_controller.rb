class FindWrapperController < ApplicationController
  # get
  def show
    # list all tables
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

    # list all operators
    @operators = %w($eq $gt $gte $lt $lte $ne $in $nin $or $and $not $nor $exists $type)
  end

  # post
  def submit
    find_string = []
    separator = ', '
    args = params[:argv]
    args.each do |arg|
      attr = arg[:attr]
      operator = arg[:operator]
      value = arg[:value]
      str = "{#{attr}: {#{operator}: #{value}}}"
      find_string.append(str)
    end
    @query = find_string.join(separator)
  end
end
