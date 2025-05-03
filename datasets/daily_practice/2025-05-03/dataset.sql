CREATE DATABASE IF NOT EXISTS daily_practice_20250503_schema;
USE daily_practice_20250503_schema;

CREATE TABLE assignments (
    id INT,
    student VARCHAR(50),
    assignment1 INT,
    assignment2 INT,
    assignment3 INT
);

INSERT INTO assignments VALUES
(1, 'Karen Austin', 90, 98, 80),
(2, 'Matthew Ward', 85, 90, 70),
(3, 'John Miranda', 87, 75, 90),
(4, 'Scott Taylor', 60, 55, 70),
(5, 'Tom Saunders', 80, 88, 90),
(6, 'Natalie Palmer', 55, 70, 65),
(7, 'James Burgess', 72, 70, 75),
(8, 'Tracie Lopez', 89, 85, 70),
(9, 'Donna Jimenez', 91, 90, 98),
(10, 'Rachael Smith', 76, 66, 80);