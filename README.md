# DataBanks

## Summary

DataBanks is a lightweight library that facilitates the creation and use of objects that represent data with persistent storage.

This functionality exhibits Object Relational Mapping (ORM) and allows for an object-oriented approach to performing database operations. When extended into a new class, DataBanks sets up a relational mapping between the new model and an existing table in the database.

## API

```ruby
class Books < DataBanks
end
```

DataBanks provides similar core ActiveRecord methods:

- `::all` generates an array of objects, one for each item in the table

```ruby
Book.all
=> [id: 1, title: "The Hobbit", author_id: 1,
    id: 2, title: "Metamorphosis", author_id: 2,
    id: 3, title: "Candide", author_id: 3,
    id: 4, title: "Don Quixote", author_id: 4,
    id: 5, title: "Unclaimed Book", author_id: nil
   ]
```
- `::find(id)` finds the datum in a table by an id and returns a new object with all of the associated data
```ruby
book = Book.find(5)
=> 
```
which you can then update using the update method:
```ruby
book.update(author_id: 1)
book.author_id
=> 1
```
- `::where(params)` returns an array of objects for the data matching the given params
```ruby
Book.where(author_id: 2)
=> [
    <Book:#{object_id} id: 2, title: "Metamorphosis", author_id: 2>
    ]
```
DataBanks provides similar core ActiveRecord associations:

- `has_many`
  ```ruby
  class Book < DataBanks
    belongs_to :author
  end
  
  class Author < DataBanks
    has_many :books
  end
 
  author = Author.find(1)
  author.books = [ 
    <Book:#{object_id} id: 1, title: "The Hobbit", author_id: 1>
    ]
  ```
- `belongs_to`
  ```ruby
  class Author < DataBanks
    belongs_to :primary_language
  end
  
  class PrimaryLanguage <DataBanks
    has_many :authors
  end
  
  author = Author.find(3)
  author.primary_language
  => <PrimaryLanguage:#{object_id} id: 3, name: "French">
  ```
- `has_one_through`
  ```ruby
  class Book < DataBanks
    belongs_to :author
  end
  
  class Author < DataBanks
    has_many :books
    belongs_to :primary_language
  end
  
  class PrimaryLanguage < DataBanks
    has_many :authors
  end
  
  book = Book.find(4)
  book.primary_language
  => <PrimaryLanguage:#{object_id} id: 4, name: "Spanish">
  ```

 **Note: While DataBanks allows users to provide their own names for associations, it is recommended to use the default one in most cases**

## Libraries

- SQLite3 (gem)
- ActiveSupport::Inflector
