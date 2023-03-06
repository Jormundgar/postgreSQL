CREATE TABLE author
(
    id SERIAL PRIMARY KEY ,
    name VARCHAR(128) NOT NULL ,
    surname VARCHAR(128) NOT NULL
);

CREATE TABLE book
(
    id BIGSERIAL PRIMARY KEY ,
    book_name VARCHAR(128) NOT NULL ,
    year SMALLINT NOT NULL ,
    pages SMALLINT NOT NULL ,
    author_id INT REFERENCES author(id)

);

INSERT INTO author (name, surname)
VALUES ('Jane','Austen'),
       ('Charlotte','Bronte'),
       ('George','Orwell'),
       ('Jack','London'),
       ('Alexandre','Dumas'),
       ('Ernest','Heminqway');

INSERT INTO book (book_name, year, pages, author_id)
VALUES ('Pride and Prejudice', 1813, 432, (SELECT id FROM author WHERE surname = 'Austen')),
       ('Lady Susan', 1871 , 158, (SELECT id FROM author WHERE surname = 'Austen')),
       ('Jane Eyre', 1847 , 536, (SELECT id FROM author WHERE surname = 'Bronte')),
       ('Animal Farm', 1945, 86, (SELECT id FROM author WHERE surname = 'Orwell')),
       ('The Call of the Wild', 1903, 232,(SELECT id FROM author WHERE surname = 'London')),
       ('Twenty Years After', 1845, 880,(SELECT id FROM author WHERE surname = 'Dumas')),
       ('The Count of Monte Cristo', 1845, 544,(SELECT id FROM author WHERE surname = 'Dumas')),
       ('Northanger Abbey', 1818, 288, (SELECT id FROM author WHERE surname = 'Austen')),
       ('The Old Man and the Sea', 1952, 127,(SELECT id FROM author WHERE surname = 'Heminqway')),
       ('The Sun Also Rises', 1926, 251,(SELECT id FROM author WHERE surname = 'Heminqway'));

-- A query that selects: book title, year and author's name, sorted by year of publication of the book in ascending order
SELECT
    b.book_name,
    b.year,
    (SELECT a.name FROM author a WHERE a.id = b.author_id)
FROM book b
ORDER BY b.year;

-- A query that selects: book title, year and author's name, sorted by year of publication of the book in descending order
SELECT
    b.book_name,
    b.year,
    (SELECT a.name FROM author a WHERE a.id = b.author_id)
FROM book b
ORDER BY b.year DESC;

-- A query that selects the number of books by a given author
SELECT
    count(*)
FROM book
WHERE author_id IN (SELECT id FROM author WHERE surname = 'Dumas');

-- A query that selects books whose number of pages is greater than the average number of pages for all books
SELECT id,
       book_name,
    year,
    pages,
    author_id
FROM book
WHERE pages > (SELECT avg(pages)
    FROM book);

-- A query selecting the 5 oldest books
SELECT id,
       book_name,
    year,
    pages,
    author_id
FROM book
ORDER BY year
    LIMIT 5;

-- Complete the query and calculate the total number of pages among these books
SELECT sum(p.pages)
FROM (SELECT pages
      FROM book
      ORDER BY year
          LIMIT 5) p;

-- A request that changes the number of pages in one of the books
UPDATE book
SET pages = pages + 100
WHERE id = 4
    RETURNING book_name,
    year,
    pages;

-- Request deleting the author who wrote the biggest book
DELETE
FROM author
WHERE id = (SELECT author_id
            FROM book
            WHERE pages = (SELECT max(pages)
                           FROM book));