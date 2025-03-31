-- Create the database and table for an employee directory
CREATE DATABASE IF NOT EXISTS daily_practice_20250331_schema;
USE daily_practice_20250331_schema;

-- Employees table: stores employee details along with department and position info.
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    department_name VARCHAR(50),
    position VARCHAR(50)
);

-- Insert sample data
-- Departments: Marketing (1001), Human Resources (1002), Operations (1003), Finance (1004), Sales (1005), Engineering (1006)
INSERT INTO employees (id, first_name, last_name, department_id, department_name, position) VALUES
(1, 'Todd',     'Wilson',         1006, 'Engineering', 'Manager'),           -- Changed to Manager
(2, 'Justin',   'Simon',          1005, 'Sales',       'Senior specialist'),
(3, 'Kelly',    'Rosario',        1002, 'Human Resources', 'Senior specialist'),
(4, 'Patricia', 'Powell',         1004, 'Finance',     'Senior specialist'),
(5, 'Michael',  'Ramsey',         1003, 'Operations',  'Senior specialist'),
(6, 'Kristen',  'Miller',         1001, 'Marketing',   'Manager'),
(7, 'Allison',  'Johnson',        1001, 'Marketing',   'Senior specialist'),
(8, 'Jennifer', 'Mcneil',         1003, 'Operations',  'Manager'),
(9, 'Robert',   'Lynch',          1004, 'Finance',     'Manager'),
(10, 'Kimberly','Hawkins',         1005, 'Sales',       'Intern'),
(11, 'Aaron',   'Miller',         1002, 'Human Resources', 'Intern'),
(12, 'John',    'Coleman',        1001, 'Marketing',   'Senior specialist'),
(13, 'Stephen', 'Smith',          1006, 'Engineering', 'Manager'),
(14, 'Sara',    'Davis',          1002, 'Human Resources', 'Manager'),        -- Changed to Manager in HR
(15, 'Kevin',   'Duncan',         1003, 'Operations',  'Intern');