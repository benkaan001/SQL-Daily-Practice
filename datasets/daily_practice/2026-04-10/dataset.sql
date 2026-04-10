
CREATE DATABASE IF NOT EXISTS daily_practice_20260410_schema;
USE daily_practice_20260410_schema;

-- This table lists all employees in the company.
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50)
);

-- This table lists all available training modules and whether they are required.
CREATE TABLE training_modules (
    module_id INT PRIMARY KEY,
    module_name VARCHAR(100),
    is_mandatory BOOLEAN
);

-- This table logs every time an employee successfully completes a module.
CREATE TABLE training_completions (
    completion_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    module_id INT,
    completion_date DATE
);

INSERT INTO employees (emp_id, emp_name) VALUES
(101, 'Alice'),
(102, 'Bob'),
(103, 'Charlie'),
(104, 'Diana'),
(105, 'Evan');

INSERT INTO training_modules (module_id, module_name, is_mandatory) VALUES
(1, 'Phishing Awareness', TRUE),
(2, 'Data Privacy & GDPR', TRUE),
(3, 'Password Security', TRUE),
(4, 'Physical Office Security', TRUE),
(5, 'Advanced Excel Tricks', FALSE), -- Optional
(6, 'Public Speaking 101', FALSE);   -- Optional

INSERT INTO training_completions (emp_id, module_id, completion_date) VALUES
-- Alice: Completes all 4 mandatory modules.
(101, 1, '2026-01-15'),
(101, 2, '2026-01-16'),
(101, 3, '2026-01-20'),
(101, 4, '2026-01-25'),

-- Bob: Completes only 2 mandatory modules.
(102, 1, '2026-02-01'),
(102, 3, '2026-02-15'),

-- Charlie: Completes 0 modules. (No records in the completions table)

-- Diana: Completes all 4 mandatory modules PLUS 2 optional ones.
(104, 1, '2026-03-01'),
(104, 2, '2026-03-02'),
(104, 3, '2026-03-03'),
(104, 4, '2026-03-04'),
(104, 5, '2026-03-10'), -- Optional
(104, 6, '2026-03-15'), -- Optional

-- Evan: Completes 0 mandatory modules, but DOES complete an optional one.
(105, 5, '2026-04-01'); -- Optional only
