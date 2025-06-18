CREATE DATABASE IF NOT EXISTS daily_practice_20250619_schema;
USE daily_practice_20250619_schema;


-- Create Departments Table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- Insert Data into Departments Table
INSERT INTO Departments (department_id, department_name, location) VALUES
(1, 'Sales', 'New York'),
(2, 'Marketing', 'San Francisco'),
(3, 'Engineering', 'Seattle'),
(4, 'Human Resources', 'New York'),
(5, 'Finance', 'Chicago');

-- Create Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);

-- Insert Data into Employees Table
-- Top-level employees (CEO, Heads of Departments) who report to CEO (101) or have no manager
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, department_id, manager_id) VALUES
(101, 'John', 'Doe', 'john.doe@example.com', '555-1234', '2018-01-15', 'CEO', 150000.00, NULL, NULL), -- CEO, no manager
(102, 'Jane', 'Smith', 'jane.smith@example.com', '555-5678', '2019-03-20', 'Head of Sales', 120000.00, 1, 101),
(103, 'Peter', 'Jones', 'peter.jones@example.com', '555-8765', '2018-07-01', 'Head of Marketing', 110000.00, 2, 101),
(104, 'Alice', 'Williams', 'alice.williams@example.com', '555-4321', '2017-05-10', 'Head of Engineering', 130000.00, 3, 101),
(105, 'Bob', 'Brown', 'bob.brown@example.com', '555-0011', '2020-01-01', 'Head of HR', 95000.00, 4, 101),
(106, 'Charlie', 'Davis', 'charlie.davis@example.com', '555-2233', '2019-11-25', 'Head of Finance', 115000.00, 5, 101);

-- Sales Department Employees
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, department_id, manager_id) VALUES
(107, 'Diana', 'Miller', 'diana.miller@example.com', '555-3344', '2021-02-10', 'Sales Representative', 60000.00, 1, 102),
(108, 'Ethan', 'Wilson', 'ethan.wilson@example.com', '555-5566', '2022-04-15', 'Sales Representative', 62000.00, 1, 102),
(109, 'Fiona', 'Moore', 'fiona.moore@example.com', '555-7788', '2021-02-10', 'Sales Representative', 60000.00, 1, 102), -- Tie with Diana
(110, 'George', 'Taylor', 'george.taylor@example.com', '555-9900', '2023-08-01', 'Sales Associate', 50000.00, 1, 102);

-- Marketing Department Employees
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, department_id, manager_id) VALUES
(111, 'Hannah', 'Anderson', 'hannah.anderson@example.com', '555-1122', '2020-06-01', 'Marketing Specialist', 70000.00, 2, 103),
(112, 'Ian', 'Thomas', 'ian.thomas@example.com', '555-3355', '2021-09-01', 'Marketing Coordinator', 55000.00, 2, 103),
(113, 'Julia', 'Jackson', 'julia.jackson@example.com', '555-6677', '2020-06-01', 'Marketing Specialist', 70000.00, 2, 103); -- Tie with Hannah

-- Engineering Department Employees
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, department_id, manager_id) VALUES
(114, 'Kevin', 'White', 'kevin.white@example.com', '555-8899', '2019-01-05', 'Software Engineer', 90000.00, 3, 104),
(115, 'Liam', 'Harris', 'liam.harris@example.com', '555-0022', '2020-03-10', 'Software Engineer', 92000.00, 3, 104),
(116, 'Mia', 'Martin', 'mia.martin@example.com', '555-4455', '2019-01-05', 'Software Engineer', 90000.00, 3, 104), -- Tie with Kevin
(117, 'Noah', 'Thompson', 'noah.thompson@example.com', '555-6688', '2023-01-20', 'Junior Developer', 75000.00, 3, 104),
(118, 'Olivia', 'Garcia', 'olivia.garcia@example.com', '555-1199', '2024-02-29', 'Intern', 40000.00, 3, 117); -- Employee reporting to a non-head manager

-- Human Resources Department Employees
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, department_id, manager_id) VALUES
(119, 'Paul', 'Martinez', 'paul.martinez@example.com', '555-2244', '2020-08-01', 'HR Specialist', 65000.00, 4, 105),
(120, 'Quinn', 'Robinson', 'quinn.robinson@example.com', '555-7799', '2022-10-01', 'HR Assistant', 50000.00, 4, 105);

-- Finance Department Employees
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, department_id, manager_id) VALUES
(121, 'Rachel', 'Clark', 'rachel.clark@example.com', '555-0033', '2019-04-01', 'Financial Analyst', 80000.00, 5, 106),
(122, 'Sam', 'Lewis', 'sam.lewis@example.com', '555-1144', '2021-07-01', 'Accountant', 72000.00, 5, 106),
(123, 'Tina', 'Walker', 'tina.walker@example.com', '555-3366', '2019-04-01', 'Financial Analyst', 80000.00, 5, 106); -- Tie with Rachel

-- Add some employees with NULL email or phone numbers to test edge cases
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, department_id, manager_id) VALUES
(124, 'Uma', 'Hall', NULL, '555-9876', '2022-01-01', 'Marketing Intern', 45000.00, 2, 112),
(125, 'Victor', 'Allen', 'victor.allen@example.com', NULL, '2023-05-10', 'HR Intern', 42000.00, 4, 119);

-- Add another top-level figure with no manager and a NULL department
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, department_id, manager_id) VALUES
(126, 'Wendy', 'Young', 'wendy.young@example.com', '555-0000', '2017-10-01', 'CTO', 140000.00, NULL, NULL);
