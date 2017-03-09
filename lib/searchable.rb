require_relative 'db_connection'
require_relative 'data_banks'

module Searchable
  def where(params)
    where_line = params.map { |key, _| "#{key} = ?" }.join(" AND ")

    result = DBConnection.execute(<<-SQL, params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL
    self.parse_all(result)
  end
end

class DataBanks
  extend Searchable
end
