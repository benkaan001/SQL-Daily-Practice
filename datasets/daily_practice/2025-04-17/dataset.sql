CREATE DATABASE IF NOT EXISTS daily_practice_20250417_schema;
USE daily_practice_20250417_schema;

CREATE TABLE employees (
    empl_id VARCHAR(10) PRIMARY KEY,
    manager_empl_id VARCHAR(10)
);

CREATE TABLE employee_details (
    empl_id VARCHAR(10) PRIMARY KEY,
    empl_name VARCHAR(50),
    empl_city VARCHAR(50),
    empl_dob DATE,
    empl_pin INT,
    salary INT
);

INSERT INTO employees VALUES
('E849', NULL),
('E850', 'E849'),
('E851', 'E849'),
('E852', 'E850'),
('E853', 'E850'),
('E854', 'E851'),
('E855', 'E851'),
('E856', 'E851'),
('E857', 'E854');

INSERT INTO employee_details VALUES
('E849', 'Steven M. Jones', 'Hicksville', '1988-03-29', 1490, 80000),
('E850', 'Marilynn M. Walters', 'New York', '1978-12-26', 9624, 30000),
('E851', 'Kyle M. Massey', 'Lake Katrine', '1977-09-22', 1563, 40000),
('E852', 'Cody A. Mosby', 'Anaheim', '1965-03-18', 4883, 22000),
('E853', 'David J. Mintz', 'Houston', '1977-01-04', 8001, 18000),
('E854', 'Patricia J. Kyser', 'Atlanta', '1986-02-20', 1750, 18000),
('E855', 'Mark M. Daniels', 'Atlanta', '1979-07-13', 2424, 20000),
('E856', 'Gene M. Vanscoy', 'Chicago', '1977-03-11', 1107, 16000),
('E857', 'Mitchell A. Grimm', 'Houston', '1979-11-23', 8597, 16000);