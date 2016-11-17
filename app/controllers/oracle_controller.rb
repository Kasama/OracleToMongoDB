class OracleController < ApplicationController
  def dump_script
  end

  def get_attrs
    table = params[:table].upcase # normalize table name to upper case
    sql = "SELECT * FROM #{table}"
    attrs = []
    Oracle.transaction(sql) do |result|
      result.column_metadata.each do |info|
        attrs.append info.name
      end
    end
   render json:{ :response => attrs }
  end
end
