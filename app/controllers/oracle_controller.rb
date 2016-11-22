class OracleController < ApplicationController
  def dump_script
  end

  def get_attrs
    table = params[:table].upcase # normalize table name to upper case
    pks = []
    no_pk = false
    no_pk ||= params[:no_pk]
    sql = "SELECT * FROM #{table}"
    attrs = []
    Oracle.transaction(sql) do |result|
      result.column_metadata.each do |info|
        attrs.append info.name
      end
    end
    if no_pk
      pks = Oracle.get_pks(table)
    end

   render json:{ :response => attrs-pks }
  end

  def index
  end
end
