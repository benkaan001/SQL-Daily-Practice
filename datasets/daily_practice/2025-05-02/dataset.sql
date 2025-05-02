CREATE DATABASE IF NOT EXISTS daily_practice_20250502_schema;
USE daily_practice_20250502_schema;

CREATE TABLE users (
    user_id INT,
    user_name VARCHAR(20)
);

CREATE TABLE friendships (
    user_id INT,
    friend_id INT
);

INSERT INTO users VALUES
(1, 'Karl'),
(2, 'Hans'),
(3, 'Emma'),
(4, 'Emma'),
(5, 'Mike'),
(6, 'Lucas'),
(7, 'Sarah'),
(8, 'Lucas'),
(9, 'Anna'),
(10, 'John');

INSERT INTO friendships VALUES
(1, 3),
(1, 5),
(2, 3),
(2, 4),
(3, 1),
(3, 2),
(3, 6),
(4, 7),
(5, 8),
(6, 9),
(7, 10),
(8, 6),
(9, 10),
(10, 7),
(10, 9);