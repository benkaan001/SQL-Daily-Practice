CREATE DATABASE IF NOT EXISTS company_analysis_schema;
USE company_analysis_schema;


-- Table for detailed employee information
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    department VARCHAR(100),
    hire_date DATE,
    salary INT
);

-- Table for tracking hours worked by employees on various projects
CREATE TABLE project_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    project_name VARCHAR(100),
    log_date DATE,
    hours_worked DECIMAL(5, 2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


-- Inserting substantial, multi-month data
INSERT INTO employees (employee_id, employee_name, department, hire_date, salary) VALUES
(101, 'Adeline Carter', 'Engineering', '2022-08-01', 95000),
(102, 'Benjamin Hayes', 'Engineering', '2023-01-15', 80000),
(103, 'Clara Rodriguez', 'Data Science', '2022-06-20', 110000),
(104, 'David Chen', 'Data Science', '2023-03-10', 98000),
(105, 'Eleanor Vance', 'Product', '2021-11-05', 120000);

INSERT INTO project_logs (employee_id, project_name, log_date, hours_worked) VALUES
-- Adeline Carter (Eng)
(101, 'Project Alpha', '2023-01-05', 8.00), (101, 'Project Alpha', '2023-01-12', 7.50),
(101, 'Project Gamma', '2023-02-08', 6.00), (101, 'Project Alpha', '2023-02-15', 8.50),
(101, 'Project Alpha', '2023-03-10', 8.00), (101, 'Project Gamma', '2023-03-20', 7.00),
(101, 'Project Alpha', '2023-04-05', 9.00),
-- Benjamin Hayes (Eng)
(102, 'Project Alpha', '2023-02-20', 8.00), (102, 'Project Alpha', '2023-02-27', 7.00),
(102, 'Project Beta', '2023-03-15', 8.50), (102, 'Project Beta', '2023-03-22', 8.00),
(102, 'Project Beta', '2023-04-10', 8.00), (102, 'Project Beta', '2023-04-18', 9.00),
(102, 'Project Beta', '2023-05-05', 7.50),
-- Clara Rodriguez (DS)
(103, 'Project Phoenix', '2023-01-10', 8.00), (103, 'Project Phoenix', '2023-01-25', 8.50),
(103, 'Project Phoenix', '2023-02-05', 7.50), (103, 'Project Phoenix', '2023-02-20', 8.00),
(103, 'Project Delta', '2023-03-01', 9.00), (103, 'Project Delta', '2023-03-15', 8.50),
(103, 'Project Delta', '2023-04-12', 9.50),
-- David Chen (DS)
(104, 'Project Phoenix', '2023-03-20', 8.00),
(104, 'Project Phoenix', '2023-04-05', 7.00), (104, 'Project Phoenix', '2023-04-20', 8.50),
(104, 'Project Delta', '2023-05-10', 9.00), (104, 'Project Delta', '2023-05-25', 8.00),
(104, 'Project Delta', '2023-06-15', 9.50),
-- Eleanor Vance (Product)
(105, 'Project Alpha', '2023-01-15', 8.00),
(105, 'Project Beta', '2023-02-10', 7.00),
(105, 'Project Gamma', '2023-03-05', 8.50),
(105, 'Project Delta', '2023-04-02', 8.00);