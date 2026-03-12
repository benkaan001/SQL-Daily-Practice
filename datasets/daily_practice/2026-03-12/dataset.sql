CREATE DATABASE IF NOT EXISTS daily_practice_20260312_schema;
USE daily_practice_20260312_schema;

-- This table stores employee hierarchy and compensation details.
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_name VARCHAR(50),
    salary DECIMAL(10, 2),
    manager_id INT -- Foreign key pointing back to employee_id
);

INSERT INTO employees (employee_id, employee_name, department_name, salary, manager_id) VALUES
-- Executive
(1, 'Alice CEO', 'Executive', 250000.00, NULL),

-- Sales Department (Average Salary: 122,500.00)
(2, 'Bob VP', 'Sales', 150000.00, 1),
(4, 'David', 'Sales', 80000.00, 2),
(5, 'Eve', 'Sales', 160000.00, 2),    -- Earns more than Bob (Manager), more than Sales Avg.
(6, 'Frank', 'Sales', 100000.00, 2),

-- Engineering Department (Average Salary: 142,500.00)
(3, 'Charlie VP', 'Engineering', 160000.00, 1),
(7, 'Grace', 'Engineering', 140000.00, 3),   -- Earns less than Manager, less than Eng Avg.
(8, 'Heidi', 'Engineering', 170000.00, 3),   -- Earns more than Charlie (Manager), more than Eng Avg.
(9, 'Ivan', 'Engineering', 100000.00, 3),

-- Marketing Department (Average Salary: 128,333.33)
(10, 'Judy Dir', 'Marketing', 90000.00, 1),
(11, 'Kevin', 'Marketing', 95000.00, 10),    -- Earns more than Judy (Manager), but LESS than Mktg Avg.
(12, 'Liam', 'Marketing', 200000.00, 10);    -- Earns more than Judy (Manager), more than Mktg Avg.