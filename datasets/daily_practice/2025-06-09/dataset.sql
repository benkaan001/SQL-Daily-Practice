CREATE DATABASE IF NOT EXISTS daily_practice_20250609_schema;
USE daily_practice_20250609_schema;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(100)
);

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    hire_date DATE,
    termination_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

DROP TABLE IF EXISTS timesheets;
CREATE TABLE timesheets (
    timesheet_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    work_date DATE,
    hours_worked DECIMAL(4,2),
    notes VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Marketing');

INSERT INTO employees VALUES
(1, 'Alice', 1, '2023-01-10', NULL),
(2, 'Bob', 1, '2023-03-15', NULL),
(3, 'Charlie', 2, '2024-02-01', '2025-05-31'),
(4, 'Diana', 3, '2024-06-20', NULL),
(5, 'Eve', 1, '2025-01-05', NULL);

INSERT INTO projects VALUES
(101, 'Website Redesign', '2024-12-01', NULL),
(102, 'Recruitment Drive', '2025-01-15', '2025-05-30'),
(103, 'Product Launch', '2025-03-01', '2025-06-30');

INSERT INTO timesheets VALUES
(1001, 1, 101, '2025-06-01', 8.0, 'Initial planning'),
(1002, 2, 101, '2025-06-01', 7.5, NULL),
(1003, 1, 103, '2025-06-02', 6.0, 'Kickoff'),
(1004, 5, 103, '2025-06-02', 8.0, NULL),
(1005, 3, 102, '2025-05-29', 4.0, 'Final interviews'),
(1006, 3, 102, '2025-05-30', 3.5, NULL),
(1007, 4, 103, '2025-06-03', 7.0, 'Marketing prep'),
(1008, 2, 101, '2025-06-03', 8.0, NULL),
(1009, 1, 101, '2025-06-04', 7.0, NULL),
(1010, 5, 103, '2025-06-04', 7.5, NULL),
(1011, 1, 103, '2025-06-05', 8.0, NULL),
(1012, 2, 101, '2025-06-05', 7.0, NULL),
(1013, 4, 103, '2025-06-05', 6.5, NULL),
(1014, 5, 103, '2025-06-06', 8.0, NULL),
(1015, 1, 101, '2025-06-06', 7.5, NULL);
