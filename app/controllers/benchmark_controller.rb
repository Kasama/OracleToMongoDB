class BenchmarkController < ApplicationController
  def index
  end

  # POST
  def insert_into
    n = params[:number].to_i

    inserts = (0..n).map do |i|
      {
        _id: i,
        name1: random_string(2000), name2: random_string(2000),
        name3: random_string(2000), name4: random_string(2000),
        name5: random_string(2000), name6: random_string(2000),
        name7: random_string(2000), name8: random_string(2000),
        name9: random_string(2000), name10: random_string(2000)
      }
    end

    puts 'starting benchmark with index'
    time = MongoModel.benchmark_insert(inserts, false)

    puts 'starting benchmark without index'
    time_index = MongoModel.benchmark_insert(inserts, true)

    redirect_to root_url, notice: "O MongoDB levou #{time}s (sem index) e #{time_index}s (com index) para inserir #{n} tuplas"

    # render json: {time: time, number: n}
  end

  def select_from
    n = params[:number].to_i
    r = params[:rand].to_i
    nums = []
    names = []

    collection = MongoModel.collection('insert_test')
    (0..100).each { nums.append rand(r) }
    nums.each do |i|
      collection.find(_id: { :$eq => i }).each { |j| names.append j['name1'] }
    end

    puts 'starting benchmark without index'
    time = Benchmark.realtime do
      (0..n).each do |i|
        collection.find(name1: { :$eq => names[i % names.length] })
      end
    end

    names = []
    collection = MongoModel.collection('insert_test_index')
    (0..100).each { nums.append rand(r) }
    nums.each do |i|
      collection.find(_id: { :$eq => i }).each { |j| names.append j['name1'] }
    end

    puts 'starting benchmark with index'
    time_index = Benchmark.realtime do
      (0..n).each do |i|
        collection.find(name1: { :$eq => names[i % names.length] })
      end
    end

    msg = "O MongoDB levou #{time}s (sem index) e #{time_index}s (com index) para inserir #{n} tuplas"
    redirect_to root_url, notice: msg
  end

  private

  def random_string(length)
    (36**(length - 1) + rand(36**length)).to_s(36)
  end
end
