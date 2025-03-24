-- Create the database schema
CREATE DATABASE IF NOT EXISTS daily_practice_20250324_schema;
USE daily_practice_20250324_schema;

-- Employees table with department and salary information
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    hire_date DATE,
    salary DECIMAL(10, 2),
    manager_id INT
);

-- Departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

-- Projects table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12, 2)
);

-- Employee-Project assignments
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    hours_allocated INT,
    PRIMARY KEY (employee_id, project_id)
);

-- Sales table with monthly data
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    sale_date DATE,
    amount DECIMAL(10, 2),
    customer_id INT
);

-- Insert sample data
INSERT INTO departments VALUES
(1, 'Engineering', 'San Francisco'),
(2, 'Marketing', 'New York'),
(3, 'Finance', 'Chicago'),
(4, 'HR', 'San Francisco'),
(5, 'Sales', 'Los Angeles');

INSERT INTO employees VALUES
(1, 'John', 'Smith', 1, '2018-05-15', 85000.00, NULL),
(2, 'Sarah', 'Johnson', 1, '2019-03-20', 75000.00, 1),
(3, 'Michael', 'Brown', 1, '2020-01-10', 72000.00, 1),
(4, 'Emily', 'Davis', 2, '2018-08-15', 68000.00, NULL),
(5, 'David', 'Wilson', 2, '2019-09-25', 62000.00, 4),
(6, 'Lisa', 'Anderson', 3, '2017-04-12', 92000.00, NULL),
(7, 'Robert', 'Taylor', 3, '2021-02-28', 64000.00, 6),
(8, 'Jennifer', 'Thomas', 4, '2019-11-17', 59000.00, NULL),
(9, 'James', 'Martinez', 5, '2018-07-30', 81000.00, NULL),
(10, 'Patricia', 'Garcia', 5, '2020-06-15', 76000.00, 9),
(11, 'Mark', 'Lee', 1, '2022-01-15', 68000.00, 1),
(12, 'Elizabeth', 'White', 5, '2019-10-10', 79000.00, 9);

INSERT INTO projects VALUES
(101, 'Database Migration', '2022-01-01', '2022-06-30', 250000.00),
(102, 'Mobile App Development', '2022-03-15', '2022-12-31', 350000.00),
(103, 'Website Redesign', '2022-02-10', '2022-07-15', 175000.00),
(104, 'Data Warehouse Setup', '2022-04-01', '2023-01-31', 420000.00),
(105, 'CRM Implementation', '2022-05-15', '2022-11-30', 295000.00);

INSERT INTO employee_projects VALUES
(1, 101, 'Project Manager', 120),
(2, 101, 'Developer', 160),
(3, 101, 'Developer', 160),
(1, 102, 'Technical Advisor', 60),
(2, 102, 'Developer', 180),
(11, 102, 'Developer', 180),
(4, 103, 'Project Manager', 100),
(5, 103, 'Designer', 140),
(6, 104, 'Technical Lead', 140),
(7, 104, 'Data Analyst', 160),
(9, 105, 'Project Manager', 80),
(10, 105, 'Sales Specialist', 120),
(12, 105, 'Sales Specialist', 120);

INSERT INTO sales VALUES
(1001, 9, '2022-01-15', 12500.00, 501),
(1002, 10, '2022-01-20', 8900.00, 502),
(1003, 12, '2022-01-25', 15200.00, 503),
(1004, 9, '2022-02-05', 9700.00, 504),
(1005, 12, '2022-02-10', 11300.00, 505),
(1006, 10, '2022-02-15', 7800.00, 506),
(1007, 9, '2022-03-01', 14500.00, 507),
(1008, 10, '2022-03-10', 9200.00, 501),
(1009, 12, '2022-03-15', 10800.00, 502),
(1010, 9, '2022-04-05', 13100.00, 503),
(1011, 10, '2022-04-12', 8600.00, 504),
(1012, 12, '2022-04-20', 12400.00, 505),
(1013, 9, '2022-05-02', 15700.00, 506),
(1014, 10, '2022-05-15', 9900.00, 507),
(1015, 12, '2022-05-25', 11500.00, 501);