require_relative 'lib/sql_object'

DEMO_DB_FILE = 'books.db'
DEMO_SQL_FILE = 'books.sql'

# SCHEMA
# books
# column names: 'id', 'title', 'author_id'
#
# authors
# column names: 'id', 'name', 'primary_language_id'
#
# primary_languages
# column names: 'id', 'name'

DBConnection.open(DEMO_DB_FILE)

# can pass in explicit options in associations
class Book < SQLObject
  belongs_to :author, foreign_key: :author_id
  has_one_through :primary_language, :author, :primary_language

  finalize!
end

# can omit options in associations, SQLObject provides conventional defaults
class Author < SQLObject
  belongs_to :primary_language
  has_many :books

  finalize!
end

class PrimaryLanguage < SQLObject
  has_many :authors, class_name: "Author", foreign_key: :primary_language_id

  finalize!
end
