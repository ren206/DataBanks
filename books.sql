CREATE TABLE books (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author_id INTEGER,

  FOREIGN KEY(author_id) REFERENCES author(id)
);

CREATE TABLE authors (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  primary_language_id INTEGER,

  FOREIGN KEY(primary_language_id) REFERENCES primary_language(id)
);

CREATE TABLE primary_languages (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  primary_languages (id, name)
VALUES
  (1, "English"),
  (2, "German"),
  (3, "French"),
  (4, "Spanish");

INSERT INTO
  authors (id, name, primary_language_id)
VALUES
  (1, "J.R.R. Tolkien", 1),
  (2, "Franz Kafka", 2),
  (3, "Voltaire", 3),
  (4, "Miguel de Cervantes", 4),
  (5, "Unpublished Author", NULL);

INSERT INTO
  books (id, title, author_id)
VALUES
  (1, "The Hobbit", 1),
  (2, "Metamorphosis", 2),
  (3, "Candide", 3),
  (4, "Don Quixote", 4),
  (5, "Unclaimed Book", NULL);
