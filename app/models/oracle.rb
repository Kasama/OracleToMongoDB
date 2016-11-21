class Oracle
  def self.execute(sql)
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.transaction(sql)
    result_set = Oracle.execute(sql)
    yield result_set
    result_set.close
  end

  def self.each_row(table)
    sql = "select * from #{table}"
    Oracle.each_row_sql(sql) do |entry|
      yield entry
    end
  end

  def self.each_row_sql(sql)
    Oracle.transaction(sql) do |result_set|
      result_set.fetch_hash do |entry|
        yield entry
      end
    end
  end

  def self.get_constraint(table, type)
    sql = "SELECT column_name FROM all_cons_columns WHERE constraint_name = (
            SELECT constraint_name FROM user_constraints
            WHERE UPPER(table_name) = UPPER('#{table}') AND CONSTRAINT_TYPE = '#{type}')"
    constraints = []
    Oracle.each_row_sql(sql) do |entry|
      constraints.append entry['COLUMN_NAME'].upcase
    end

    constraints
  end

  def self.get_pks(table)
    self.get_constraint table, 'P'
  end

  def self.get_uniques(table)
    self.get_constraint table, 'U'
  end
end