CREATE DATABASE IF NOT EXISTS daily_practice_20260317_schema;
USE daily_practice_20260317_schema;

-- This table stores current salary information for employees across different departments.
CREATE TABLE department_salaries (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO department_salaries (department, salary) VALUES
-- Sales: 5 employees (Odd count). The median should be the exact middle value (60,000).
-- Notice the massive 200k outlier that would skew a standard AVG() calculation!
('Sales', 40000.00), 
('Sales', 50000.00), 
('Sales', 60000.00), 
('Sales', 70000.00), 
('Sales', 200000.00),

-- Engineering: 6 employees (Even count). The median should be the average of the two middle values (100k and 110k).
('Engineering', 80000.00), 
('Engineering', 90000.00), 
('Engineering', 100000.00), 
('Engineering', 110000.00), 
('Engineering', 120000.00), 
('Engineering', 130000.00),

-- HR: 2 employees (Even count).
('HR', 50000.00), 
('HR', 60000.00),

-- Marketing: 1 employee.
('Marketing', 75000.00);