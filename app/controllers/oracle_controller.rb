class OracleController < ApplicationController
  def generate_mongo_doc
    table = params[:table]
    sql = 'SELECT * from ' + table
    tuples = Oracle.execute(sql)
    tup_arr = []
    tuples.fetch_hash do |entry|
      tup_arr.append entry
    end

    render :json => {'DATABASE': tup_arr}
  end

  def dump_script
  end
end
