class BenchmarkController < ApplicationController
  def index
  end

  # POST
  def insert_into
    n = params[:number].to_i
    inserts = []

    (0..n).each do |i|
      inserts.append({
          _id: i,
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
      })
    end

    MongoModel.drop 'insert_test_index'
    collection = MongoModel.collection 'insert_test_index'
    collection.create_index({name1: 'text'})
    time_index = Benchmark.realtime do
      MongoModel.insert_many 'insert_test_index', inserts
    end

    MongoModel.drop 'insert_test'
    collection = MongoModel.collection 'insert_test'
    time = Benchmark.realtime do
      MongoModel.insert_many 'insert_test', inserts
    end

    redirect_to root_url, notice: "it took mongo #{time}s (no index)/#{time_index}s (index) to insert #{n} tuples"

    # render json: {time: time, number: n}
  end

  def select_from
    n = params[:number].to_i
    r = params[:rand].to_i
    nums = []
    names = []

    collection = MongoModel.collection('insert_test')
    (0..100).each do nums.append rand(r) end
    nums.each do |i|
      collection.find({'_id': {:$eq => i}}).each { |j| names.append j['name1'] }
    end

    time = Benchmark.realtime do
      (0..n).each do |i|
        collection.find({name1: {:$eq => names[i % names.length]}})
      end
    end

    names = []
    collection = MongoModel.collection('insert_test_index')
    (0..100).each do nums.append rand(r) end
    nums.each do |i|
      collection.find({'_id': {:$eq => i}}).each { |j| names.append j['name1'] }
    end

    time_index = Benchmark.realtime do
      (0..n).each do |i|
        collection.find({name1: {:$eq => names[i % names.length]}})
      end
    end

    redirect_to root_url, notice: "#{names.length} it took mongo #{time}s (no index)/#{time_index}s (index) to select #{n} tuples"

  end

  private
  def random_string(length)
    (36**(length-1) + rand(36**length)).to_s(36)
  end
end
