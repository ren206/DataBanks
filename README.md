# DataBanks

## Summary

DataBanks is a lightweight library that facilitates the creation and use of objects that represent data with persistent storage.

This functionality exhibits Object Relational Mapping (ORM) and allows for an object-oriented approach to performing database operations. When extended into a new class, DataBanks sets up a relational mapping between the new model and an existing table in the database.

## API

DataBanks provides similar core ActiveRecord methods:

- `all`
- `find`
- `save`

DataBanks provides similar core ActiveRecord associations:

- `has_many`
- `belongs_to`
- `has_one_through`

 **Note: While DataBanks allows users to provide their own names for associations, it is recommended to use the default one in most cases**

## Libraries

- SQLite3 (gem)
- ActiveSupport::Inflector
