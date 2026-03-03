CREATE DATABASE IF NOT EXISTS daily_practice_20260303_schema;
USE daily_practice_20260303_schema;

-- This table acts as an event log (or Slowly Changing Dimension Type 2) for employees.
-- Instead of overwriting data when an employee gets a raise or changes departments, a new record is inserted.
CREATE TABLE employee_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    employment_status ENUM('HIRED', 'PROMOTED', 'TRANSFERRED', 'TERMINATED'),
    effective_date DATE
);

INSERT INTO employee_history (employee_id, department, salary, employment_status, effective_date) VALUES
-- Employee 101: Hired in Sales, gets a promotion, and eventually leaves in early 2026.
(101, 'Sales', 60000.00, 'HIRED', '2024-01-15'),
(101, 'Sales', 75000.00, 'PROMOTED', '2025-06-01'),
(101, 'Sales', 75000.00, 'TERMINATED', '2026-02-01'),

-- Employee 102: Hired in Engineering, later transfers to Product.
(102, 'Engineering', 90000.00, 'HIRED', '2024-03-01'),
(102, 'Product', 95000.00, 'TRANSFERRED', '2025-10-15'),

-- Employee 103: Hired late in 2025, still active.
(103, 'Engineering', 85000.00, 'HIRED', '2025-11-01'),

-- Employee 104: Hired in 2026 (Should not exist in a 2025 snapshot).
(104, 'Marketing', 70000.00, 'HIRED', '2026-01-10'),

-- Employee 105: Hired and terminated before the end of 2025.
(105, 'Sales', 55000.00, 'HIRED', '2024-05-01'),
(105, 'Sales', 55000.00, 'TERMINATED', '2025-11-30');