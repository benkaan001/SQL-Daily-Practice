CREATE SCHEMA IF NOT EXISTS library_schema;
USE library_schema;


-- Authors table
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100),
    birth_date DATE
);

INSERT INTO authors (author_id, author_name, birth_date) VALUES
(1, 'J.K. Rowling', '1965-07-31'),
(2, 'George R.R. Martin', '1948-09-20'),
(3, 'J.R.R. Tolkien', '1892-01-03'),
(4, 'Agatha Christie', '1890-09-15'),
(5, 'Stephen King', '1947-09-21');

-- Books table
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT,
    genre VARCHAR(50),
    published_date DATE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

INSERT INTO books (book_id, title, author_id, genre, published_date) VALUES
(1, 'Harry Potter and the Philosopher\'s Stone', 1, 'Fantasy', '1997-06-26'),
(2, 'A Game of Thrones', 2, 'Fantasy', '1996-08-06'),
(3, 'The Hobbit', 3, 'Fantasy', '1937-09-21'),
(4, 'Murder on the Orient Express', 4, 'Mystery', '1934-01-01'),
(5, 'The Shining', 5, 'Horror', '1977-01-28');

-- Members table
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100),
    join_date DATE
);

INSERT INTO members (member_id, member_name, join_date) VALUES
(1, 'Alice Smith', '2021-01-15'),
(2, 'Bob Jones', '2021-02-20'),
(3, 'Charlie Brown', '2021-03-05'),
(4, 'Diana Prince', '2021-01-30'),
(5, 'Edward Williams', '2021-02-25');

-- Loans table
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,  -- if null, book is not yet returned
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO loans (loan_id, book_id, member_id, loan_date, return_date) VALUES
(1, 1, 1, '2021-02-01', '2021-02-15'),  -- Alice
(2, 2, 1, '2021-03-10', '2021-03-20'),  -- Alice
(3, 3, 2, '2021-02-15', NULL),          -- Bob
(4, 4, 2, '2021-03-05', '2021-03-15'),  -- Bob
(5, 5, 3, '2021-03-10', NULL),          -- Charlie
(6, 1, 4, '2021-02-20', '2021-03-01'),  -- Diana
(7, 2, 4, '2021-03-15', NULL),          -- Diana
(8, 3, 5, '2021-03-01', '2021-03-10'),  -- Edward
(9, 4, 5, '2021-03-20', NULL);          -- Edward

-- Reviews table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    rating INT,  -- Rating out of 5
    review_date DATE,
    review_text TEXT,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO reviews (review_id, book_id, member_id, rating, review_date, review_text) VALUES
(1, 1, 1, 5, '2021-02-16', 'Amazing book!'),
(2, 2, 1, 4, '2021-03-21', 'Great read.'),
(3, 3, 2, 3, '2021-02-20', 'Good, but not great.'),
(4, 4, 2, 5, '2021-03-16', 'Loved it!'),
(5, 5, 3, 4, '2021-03-11', 'Very scary.'),
(6, 1, 4, 5, '2021-03-02', 'Loved it!'),
(7, 2, 4, 4, '2021-03-25', 'Very engaging.'),
(8, 3, 5, 3, '2021-03-11', 'Interesting.'),
(9, 4, 5, 5, '2021-03-21', 'Fantastic mystery.');