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
    query = []
    @table_name = params['table'].upcase
    mux = params[:mux] == '0' ? 'and' : 'or'

    args = params.select do |k, _v|
      /table_(attr|operator|operand)_\d+/ =~ k
    end

    (0..args.length/3 - 1).each do |i|
      attr = args["table_attr_#{i}"]
      operator = args["table_operator_#{i}"]
      operand = args["table_operand_#{i}"]
      type = Oracle.get_types(@table_name, attr)[0]


      if operator == '$exists'
        if ['FALSE', '0', ''].include? operand.upcase
          operand = false
        else
          operand = true
        end
        hash = {attr.to_sym=> {operator => operand}}
        find_string.append(hash)

      elsif operator == '$in' || operator == '$nin'
        operand = operand.split(',').map {|el| el.strip}
        if /CHAR/i =~ type
          hash = {attr.to_sym=> {operator.to_sym => operand}}
          find_string.append(hash)
        elsif type == 'NUMBER'
          new_operand = operand.map do |item| item.to_i end
          hash = {attr.to_sym=> {operator.to_sym => new_operand}}
          find_string.append(hash)
          end
      else
          if /CHAR/i =~ type
            hash = {attr.to_sym=> {operator.to_sym => operand}}
            find_string.append(hash)
          elsif type == 'NUMBER'
            hash = {attr.to_sym=> {operator.to_sym => operand.to_i}}
            find_string.append(hash)
          end
      end

      end
    puts 'find_string: '
    puts find_string

    if find_string.length == 1
      @query_hash = find_string[0]
    else
      @query_hash = {"$#{mux}": find_string}
    end

    puts @query_hash
    collection = MongoModel.collection @table_name
    cursor = collection.find(@query_hash)
    puts cursor.inspect
    cursor.each do |k|
      tuple = k
      puts tuple
      query.append(tuple)
    end
    @query = query
    puts 'result'
    puts query.inspect
  end
end
