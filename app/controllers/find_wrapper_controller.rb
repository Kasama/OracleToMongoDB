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
    @operators = %w($eq $gt $gte $lt $lte $ne $in $nin $not $nor $exists $type)
  end

  # post
  def submit
    find_string = []
    separator = ', '
    query = []
    table_name = params['table'].upcase
    mux = params[:mux] == '1' ? 'and' : 'or'

    args = params.select do |k, _v|
      /table_(attr|operator|operand)_\d+/ =~ k
    end

    (0..args.length/3).each do |i|
      attr = args["table_attr_#{i}"]
      operator = args["table_operator_#{i}"]
      operand = args["table_operand_#{i}"]
      str = "{#{attr}: {#{operator}: #{operand}}}"
      find_string.append(str)
    end
    @query_string = "db.#{table_name}.find($#{mux}:#{find_string.to_s})"
    collection = MongoModel.collection table_name
    cursor = collection.find(query_string)
    cursor.each do |k,v|
      tuple = "#{k} => #{v}"
      puts tuple
      query.append(tuple)
    end
    @query = query
  end
end
