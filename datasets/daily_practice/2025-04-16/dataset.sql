-- Create the database and table for client calls at Redfin
CREATE DATABASE IF NOT EXISTS daily_practice_20250416_schema;
USE daily_practice_20250416_schema;

CREATE TABLE employment_history (
    user_id INT,
    employer VARCHAR(50),
    position VARCHAR(50),
    start_date DATE,
    end_date DATE
);

INSERT INTO employment_history VALUES
(1, 'Microsoft', 'developer', '2020-04-13', '2021-11-01'),
(1, 'Google', 'developer', '2021-11-01', NULL),
(2, 'Google', 'manager', '2021-01-01', '2021-01-11'),
(2, 'Microsoft', 'manager', '2021-01-11', NULL),
(3, 'Microsoft', 'analyst', '2019-03-15', '2020-07-24'),
(3, 'Amazon', 'analyst', '2020-08-01', '2020-11-01'),
(3, 'Google', 'senior analyst', '2020-11-01', '2021-03-04'),
(4, 'Google', 'junior developer', '2018-06-01', '2021-11-01'),
(4, 'Google', 'senior developer', '2021-11-01', NULL),
(5, 'Microsoft', 'manager', '2017-09-26', NULL),
(6, 'Google', 'CEO', '2015-10-02', NULL);