
CREATE DATABASE IF NOT EXISTS daily_practice_20250608_schema;
USE daily_practice_20250608_schema;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    signup_date DATE,
    country VARCHAR(50)
);

DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(200),
    genre VARCHAR(50),
    release_year INT,
    duration_min INT
);

DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT,
    start_date DATE,
    end_date DATE,
    plan VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

DROP TABLE IF EXISTS viewing_history;
CREATE TABLE viewing_history (
    view_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    view_date DATE,
    watch_time_min INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

INSERT INTO users VALUES
(1, 'Alice', '2025-01-10', 'USA'),
(2, 'Bob', '2025-02-15', 'Canada'),
(3, 'Charlie', '2025-03-20', 'USA'),
(4, 'Diana', '2025-04-05', 'UK'),
(5, 'Eve', '2025-05-01', 'USA');

INSERT INTO movies VALUES
(101, 'The Great Adventure', 'Action', 2023, 120),
(102, 'Romantic Escape', 'Romance', 2024, 95),
(103, 'Laugh Out Loud', 'Comedy', 2022, 110),
(104, 'Space Odyssey', 'Sci-Fi', 2023, 140),
(105, 'Mystery Manor', 'Mystery', 2024, 100),
(106, 'Documentary Now', 'Documentary', 2025, 80);

INSERT INTO subscriptions VALUES
(1001, 1, '2025-01-10', '2025-06-10', 'Premium'),
(1002, 2, '2025-02-15', '2025-05-15', 'Standard'),
(1003, 3, '2025-03-20', '2025-09-20', 'Premium'),
(1004, 4, '2025-04-05', '2025-07-05', 'Basic'),
(1005, 5, '2025-05-01', '2025-08-01', 'Standard');

INSERT INTO viewing_history VALUES
(2001, 1, 101, '2025-06-01', 120),
(2002, 1, 102, '2025-06-02', 95),
(2003, 2, 103, '2025-05-20', 110),
(2004, 2, 104, '2025-05-21', 140),
(2005, 3, 105, '2025-06-03', 100),
(2006, 3, 101, '2025-06-04', 120),
(2007, 4, 106, '2025-06-05', 80),
(2008, 4, 102, '2025-06-06', 95),
(2009, 5, 104, '2025-06-07', 140),
(2010, 5, 105, '2025-06-08', 100),
(2011, 1, 103, '2025-06-08', 110),
(2012, 2, 106, '2025-05-22', 80),
(2013, 3, 104, '2025-06-08', 140),
(2014, 5, 106, '2025-06-08', 80);
