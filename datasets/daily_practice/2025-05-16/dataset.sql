CREATE DATABASE IF NOT EXISTS daily_practice_20250516_schema;
USE daily_practice_20250516_schema;

DROP TABLE IF EXISTS email_logs;
CREATE TABLE email_logs (
    id INT,
    from_user VARCHAR(255),
    to_user VARCHAR(255),
    day INT
);

INSERT INTO email_logs (id, from_user, to_user, day) VALUES
(0, 'userA', 'userB', 5),
(1, 'userA', 'userC', 2),
(2, 'userB', 'userA', 7),
(3, 'userB', 'userC', 7),
(4, 'userC', 'userA', 3),
(5, 'userD', 'userB', 9),
(6, 'userD', 'userC', 9),
(7, 'userE', 'userD', 1),
(8, 'userE', 'userC', 5),
(9, 'userB', 'userE', 3);