class Mongo
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
        v.nil? || ( v.kind_of?(Hash) && v.empty? )
      end
      tup_arr.append tup
    end
    tup_arr
  end
end
