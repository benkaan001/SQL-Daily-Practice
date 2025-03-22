-- Schema for the dataset
CREATE SCHEMA IF NOT EXISTS daily_practice_20250321_schema;
USE daily_practice_20250321_schema;


-- Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    manager_id INT, -- Self-referencing foreign key for the reporting structure
    hire_date DATE,
    salary DECIMAL(10, 2)
);

-- Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE
);

-- Projects table
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) UNIQUE,
    start_date DATE,
    end_date DATE
);

-- EmployeeProjects table (to handle many-to-many relationship between Employees and Projects)
CREATE TABLE EmployeeProjects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- Inserting data into Departments table
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'Engineering'),
(4, 'Finance'),
(5, 'Human Resources');

-- Inserting data into Employees table
INSERT INTO Employees (employee_id, first_name, last_name, department_id, manager_id, hire_date, salary) VALUES
(1, 'John', 'Doe', 3, NULL, '2020-01-15', 80000.00),
(2, 'Jane', 'Smith', 3, 1, '2021-05-20', 75000.00),
(3, 'Peter', 'Jones', 1, 4, '2022-03-10', 60000.00),
(4, 'Mary', 'Brown', 1, NULL, '2019-08-01', 90000.00),
(5, 'David', 'Wilson', 2, 4, '2023-01-25', 70000.00),
(6, 'Sarah', 'Miller', 3, 1, '2022-07-01', 85000.00),
(7, 'Michael', 'Davis', 4, 4, '2020-11-12', 95000.00),
(8, 'Linda', 'Garcia', 2, 5, '2021-09-05', 65000.00),
(9, 'Robert', 'Rodriguez', 3, 2, '2023-04-18', 78000.00),
(10, 'Jennifer', 'Williams', 5, 1, '2024-02-01', 62000.00),
(11, 'Charles', 'Moore', 3, 6, '2024-06-10', 92000.00),
(12, 'Jessica', 'Taylor', 1, 4, '2023-09-22', 68000.00);

-- Inserting data into Projects table
INSERT INTO Projects (project_id, project_name, start_date, end_date) VALUES
(101, 'Project Alpha', '2023-01-01', '2023-12-31'),
(102, 'Project Beta', '2023-06-15', '2024-08-30'),
(103, 'Project Gamma', '2024-03-01', '2025-05-31'),
(104, 'Project Delta', '2024-09-01', '2026-03-31'),
(105, 'Project Epsilon', '2025-01-01', '2025-12-31');

-- Inserting data into EmployeeProjects table
INSERT INTO EmployeeProjects (employee_id, project_id, role) VALUES
(1, 101, 'Lead Engineer'),
(2, 101, 'Software Engineer'),
(6, 101, 'Software Engineer'),
(3, 102, 'Sales Representative'),
(4, 102, 'Sales Manager'),
(5, 103, 'Marketing Specialist'),
(8, 103, 'Marketing Coordinator'),
(7, 104, 'Finance Analyst'),
(9, 104, 'Software Engineer'),
(1, 103, 'Technical Lead'),
(2, 102, 'Technical Contributor'),
(11, 103, 'Senior Engineer'),
(12, 101, 'Business Analyst');