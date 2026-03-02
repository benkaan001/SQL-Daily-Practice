CREATE DATABASE IF NOT EXISTS daily_practice_20260302_schema;
USE daily_practice_20260302_schema;

-- This table stores the organizational hierarchy of a company.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    job_title VARCHAR(100),
    manager_id INT -- Foreign key pointing back to employee_id
);

INSERT INTO employees (employee_id, employee_name, job_title, manager_id) VALUES
-- The top of the hierarchy (CEO has no manager)
(1, 'Alice CEO', 'Chief Executive Officer', NULL),

-- Level 2 (VPs reporting to CEO)
(2, 'Bob VP', 'VP of Engineering', 1),
(3, 'Charlie VP', 'VP of Sales', 1),

-- Level 3 (Directors reporting to VPs)
(4, 'David Dir', 'Engineering Director', 2),
(8, 'Heidi Dir', 'Sales Director', 3),

-- Level 4 (Managers reporting to Directors)
(5, 'Eve Mgr', 'Engineering Manager', 4),

-- Level 5 (Individual Contributors)
(6, 'Frank Eng', 'Software Engineer', 5),
(7, 'Grace Eng', 'Software Engineer', 5),
(9, 'Ivan Rep', 'Sales Representative', 8),
(10, 'Judy Rep', 'Sales Representative', 8);