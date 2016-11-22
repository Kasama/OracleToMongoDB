class MongoModel
  def self.represent_table(table, fill_id = true)
    pks = Oracle.get_pks(table)

    tup_arr = []
    Oracle.each_row(table) do |row|
      # start by adding everything in the oracle database to the BSON dictionary
      tup = row
      if fill_id
        # create a empty '_id' field
        tup['_id'] = {}
        # for each existing primary key in the oracle database
        pks.each do |pk|
          # delete the pk from the dictionary
          el = tup.delete(pk)
          # and add it to the '_id' field
          tup['_id'][pk] = el
        end
      end
      # remove every 'null' field
      tup.delete_if do |_, v|
        v.nil? || (v.is_a?(Hash) && v.empty?)
      end
      tup_arr.append tup
    end
    tup_arr
  end

  def self.database
    MongoMapper.connection['dblabbd_fred_roberto']
  end

  def self.collection(name)
    db = database
    db.collection(name)
  end

  def self.benchmark_insert(inserts, index = false)
    table = 'insert_test'
    table + '_index' if index

    drop table
    collection = self.collection table
    collection.create_index(name1: 'text') if index

    bulk = collection.initialize_unordered_bulk_op
    inserts.each do |i|
      bulk.insert i
    end

    time = Benchmark.realtime do
      bulk.execute
    end
    time
  end

  def self.insert_many(collection, arr)
    col = self.collection collection

    col.bulk_write arr
  end

  def self.drop(collection)
    col = self.collection collection
    col.drop
  end
end
