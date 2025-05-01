CREATE DATABASE IF NOT EXISTS daily_practice_20250501_schema;
USE daily_practice_20250501_schema;

CREATE TABLE interactions (
    interaction_id INT,
    customer_id INT,
    interaction_type VARCHAR(20),
    interaction_date DATE
);

CREATE TABLE contents (
    content_id INT,
    customer_id INT,
    content_type VARCHAR(20),
    content_text VARCHAR(255)
);

INSERT INTO interactions VALUES
(1, 7, 'click', '2024-02-13'),
(2, 4, 'view', '2024-01-25'),
(3, 8, 'like', '2024-02-18'),
(4, 5, 'like', '2024-01-27'),
(5, 7, 'view', '2024-02-28'),
(6, 10, 'view', '2024-02-11'),
(7, 3, 'view', '2024-01-28'),
(8, 7, 'like', '2024-02-29'),
(9, 8, 'like', '2024-01-16'),
(10, 5, 'click', '2024-01-15'),
(11, 4, 'click', '2024-02-16'),
(12, 8, 'like', '2024-02-20'),
(13, 8, 'view', '2024-02-13'),
(14, 3, 'view', '2024-02-24'),
(15, 6, 'click', '2024-02-21');

INSERT INTO contents VALUES
(1, 2, 'comment', 'hello world! this is a TEST.'),
(2, 8, 'comment', 'what a great day'),
(3, 4, 'comment', 'WELCOME to the event.'),
(4, 2, 'comment', 'e-commerce is booming.'),
(5, 6, 'comment', 'Python is fun!!'),
(6, 6, 'review', '123 numbers in text.'),
(7, 10, 'review', 'special chars: @#$$%^&*()'),
(8, 4, 'comment', 'multiple CAPITALS here.'),
(9, 6, 'review', 'sentence. and ANOTHER sentence!'),
(10, 2, 'post', 'goodBYE!');