CREATE DATABASE IF NOT EXISTS daily_practice_20250420_schema;
USE daily_practice_20250420_schema;

CREATE TABLE company_users (
    user_id INT,
    created_at DATETIME,
    company_id INT,
    language VARCHAR(20),
    activated_at DATETIME,
    state VARCHAR(20)
);

INSERT INTO company_users VALUES
(1, '2023-01-01 09:00:00', 100, 'english', '2023-01-01', 'active'),
(2, '2023-01-02 10:00:00', 100, 'french', '2023-01-02', 'active'),
(3, '2023-01-03 11:00:00', 101, 'german', '2023-01-03', 'active'),
(4, '2023-01-04 12:00:00', 102, 'spanish', '2023-01-04', 'active'),
(5, '2023-01-05 13:00:00', 100, 'english', '2023-01-05', 'active'),
(6, '2023-01-06 14:00:00', 101, 'english', '2023-01-06', 'active'),
(7, '2023-01-07 15:00:00', 102, 'french', '2023-01-07', 'active'),
(8, '2023-01-08 16:00:00', 100, 'german', '2023-01-08', 'active'),
(9, '2023-01-09 17:00:00', 101, 'spanish', '2023-01-09', 'active'),
(10, '2023-01-10 18:00:00', 102, 'english', '2023-01-10', 'active'),
(11, '2023-01-11 19:00:00', 100, 'spanish', '2023-01-11', 'active'),
(12, '2023-01-12 20:00:00', 101, 'french', '2023-01-12', 'active'),
(13, '2023-01-13 21:00:00', 102, 'german', '2023-01-13', 'active'),
(14, '2023-01-14 22:00:00', 100, 'italian', '2023-01-14', 'active'),
(15, '2023-01-15 23:00:00', 101, 'english', '2023-01-15', 'pending'),
(16, '2023-01-16 09:00:00', 102, 'english', '2023-01-16', 'active'),
(17, '2023-01-17 10:00:00', 100, 'french', '2023-01-17', 'active'),
(18, '2023-01-18 11:00:00', 101, 'german', '2023-01-18', 'active'),
(19, '2023-01-19 12:00:00', 102, 'spanish', '2023-01-19', 'active'),
(20, '2023-01-20 13:00:00', 100, 'english', '2023-01-20', 'active');