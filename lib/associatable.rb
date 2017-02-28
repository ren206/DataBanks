require_relative 'searchable'
require 'active_support/inflector'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    class_name == "Human" ? "humans" : class_name.underscore.tableize
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    self.foreign_key = options[:foreign_key] || (name.to_s + "_id").to_sym
    self.class_name = options[:class_name] || name.to_s.camelcase
    self.primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    self.foreign_key = options[:foreign_key] || (self_class_name.underscore + "_id").to_sym
    self.class_name = options[:class_name] || name.to_s.camelcase.singularize
    self.primary_key = options[:primary_key] || :id
  end
end

module Associatable
  def belongs_to(name, options = {})
    self.assoc_options[name] = BelongsToOptions.new(name, options)
    define_method(name) do
      options = self.class.assoc_options[name]
      foreign_key_val = self.send(options.foreign_key)
      options.model_class.where(options.primary_key => foreign_key_val).first
    end
  end

  def has_many(name, options = {})
    self.assoc_options[name] = HasManyOptions.new(name, self.to_s, options)
    define_method(name) do
      options = self.assoc_options[name]
      primary_key_val = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => primary_key_val)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      through_table_name = through_options.table_name
      through_pk_value = through_options.primary_key
      through_fk_value = through_options.foreign_key

      source_table_name = source_options.table_name
      source_pk_value = source_options.primary_key
      source_fk_value = source_options.foreign_key

      through_key_value = self.send(through_fk_value)
      results = DBConnection.execute(<<-SQL, through_key_value)
       SELECT
         #{source_table_name}.*
       FROM
         #{through_table_name}
       JOIN
         #{source_table_name}
       ON
         #{through_table_name}.#{source_fk_value} = #{source_table_name}.#{source_pk_value}
       WHERE
         #{through_table_name}.#{through_pk_value} = ?
     SQL

      source_options.model_class.parse_all(results).first
    end
  end
end

class SQLObject
  extend Associatable
end