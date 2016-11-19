class BenchmarkController < ApplicationController
  def index

  end

  def insert_into
    table_name = params[:table]
    n = params[:number]
    id = 0

    hash = {
        _id: id,
        name1: random_string(2000),
        name2: random_string(2000),
        name3: random_string(2000),
        name4: random_string(2000),
        name5: random_string(2000),
        name6: random_string(2000),
        name7: random_string(2000),
        name8: random_string(2000),
        name9: random_string(2000),
        name10: random_string(2000),
    }.to_json

  end
end
