class Oracle
  def self.execute(sql)
    puts "executing sql:\n#{sql}"
    ActiveRecord::Base.connection.execute(sql)
  end
end