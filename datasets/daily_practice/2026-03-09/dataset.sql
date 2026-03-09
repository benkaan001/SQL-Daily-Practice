CREATE DATABASE IF NOT EXISTS daily_practice_20260309_schema;
USE daily_practice_20260309_schema;

-- This table stores the employment lifecycle dates for the company's staff.
CREATE TABLE employee_lifecycle (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50),
    hire_date DATE,
    termination_date DATE -- NULL if the employee is still active
);

INSERT INTO employee_lifecycle (emp_name, hire_date, termination_date) VALUES
-- Alice has been here since 2025 and is still active.
('Alice', '2025-01-15', NULL),

-- Bob was hired in late 2025 but leaves early in March.
('Bob', '2025-11-01', '2026-03-05'),

-- Charlie was hired in Feb and is still active.
('Charlie', '2026-02-20', NULL),

-- Diana is hired mid-March.
('Diana', '2026-03-12', NULL),

-- Evan is a short-term contractor who starts and ends within March.
('Evan', '2026-03-25', '2026-03-28');