-- Schema for the dataset
CREATE SCHEMA IF NOT EXISTS daily_practice_20250322_schema;
USE daily_practice_20250322_schema;


-- Table: employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    department VARCHAR(50) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    manager_id INT,
    salary DECIMAL(10, 2) NOT NULL,
    location_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Table: projects
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) UNIQUE NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20) NOT NULL,
    priority VARCHAR(10) NOT NULL
);

-- Table: employee_projects (linking table)
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    assignment_date DATE NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- Table: locations
CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL
);

-- Insert data into locations
INSERT INTO locations (city, state, country) VALUES
('New York', 'NY', 'USA'),
('Los Angeles', 'CA', 'USA'),
('Chicago', 'IL', 'USA'),
('Houston', 'TX', 'USA'),
('Austin', 'TX', 'USA'),
('Seattle', 'WA', 'USA'),
('London', NULL, 'UK'),
('Paris', NULL, 'France'),
('Tokyo', NULL, 'Japan'),
('Berlin', NULL, 'Germany');

-- Insert data into employees
INSERT INTO employees (first_name, last_name, email, hire_date, department, job_title, manager_id, salary, location_id) VALUES
('John', 'Doe', 'john.doe@example.com', '2020-01-15', 'Sales', 'Sales Manager', NULL, 75000.00, 1),
('Jane', 'Smith', 'jane.smith@example.com', '2021-03-20', 'Marketing', 'Marketing Specialist', 1, 60000.00, 2),
('Peter', 'Jones', 'peter.jones@example.com', '2019-05-10', 'Sales', 'Sales Representative', 1, 55000.00, 1),
('Mary', 'Brown', 'mary.brown@example.com', '2022-08-01', 'Engineering', 'Software Engineer', 5, 90000.00, 3),
('David', 'Wilson', 'david.wilson@example.com', '2018-11-25', 'Engineering', 'Senior Software Engineer', NULL, 120000.00, 3),
('Sarah', 'Garcia', 'sarah.garcia@example.com', '2023-04-05', 'Marketing', 'Marketing Manager', 1, 80000.00, 2),
('Michael', 'Lee', 'michael.lee@example.com', '2020-07-01', 'Finance', 'Financial Analyst', 8, 70000.00, 4),
('Linda', 'Chang', 'linda.chang@example.com', '2017-09-18', 'Finance', 'Finance Manager', NULL, 95000.00, 4),
('Robert', 'Taylor', 'robert.taylor@example.com', '2024-01-02', 'Sales', 'Sales Representative', 3, 52000.00, 5),
('Jennifer', 'Clark', 'jennifer.clark@example.com', '2022-06-10', 'Engineering', 'Software Engineer', 5, 88000.00, 3),
('James', 'Lewis', 'james.lewis@example.com', '2023-09-15', 'Marketing', 'Content Creator', 6, 58000.00, 2),
('Emily', 'Hall', 'emily.hall@example.com', '2021-12-01', 'Finance', 'Accountant', 8, 62000.00, 4),
('Thomas', 'Young', 'thomas.young@example.com', '2024-02-20', 'Engineering', 'Junior Software Engineer', 4, 70000.00, NULL),
('Jessica', 'Allen', 'jessica.allen@example.com', '2019-08-05', 'Human Resources', 'HR Manager', NULL, 85000.00, 6),
('Christopher', 'Scott', 'christopher.scott@example.com', '2022-11-30', 'Human Resources', 'HR Specialist', 14, 65000.00, 6),
('Amanda', 'Adams', 'amanda.adams@example.com', '2023-07-10', 'Sales', 'Sales Representative', 3, 53000.00, 1),
('Brian', 'Moore', 'brian.moore@example.com', '2020-04-25', 'Engineering', 'Data Engineer', 5, 105000.00, 3),
('Nicole', 'Wright', 'nicole.wright@example.com', '2021-06-12', 'Marketing', 'SEO Specialist', 6, 63000.00, 2),
('Kevin', 'Turner', 'kevin.turner@example.com', '2024-03-01', 'Finance', 'Senior Financial Analyst', 8, 82000.00, 4),
('Melissa', 'Baker', 'melissa.baker@example.com', '2022-09-01', 'Engineering', 'Software Architect', 5, 130000.00, 3);

-- Insert data into projects
INSERT INTO projects (project_name, start_date, end_date, status, priority) VALUES
('Project Alpha', '2023-01-01', '2023-12-31', 'Completed', 'High'),
('Project Beta', '2023-03-15', '2024-06-30', 'Completed', 'Medium'),
('Project Gamma', '2024-05-01', NULL, 'Active', 'High'),
('Project Delta', '2024-07-01', '2025-03-31', 'Active', 'Medium'),
('Project Epsilon', '2025-01-10', NULL, 'Active', 'Low'),
('Project Zeta', '2022-11-01', '2023-05-31', 'Completed', 'Medium'),
('Project Eta', '2024-09-01', '2025-07-31', 'Active', 'High'),
('Project Theta', '2023-06-01', '2024-03-31', 'Completed', 'Low'),
('Project Iota', '2025-03-01', NULL, 'Active', 'High'),
('Project Kappa', '2024-01-15', '2024-12-31', 'Completed', 'Medium'),
('Project Lambda', '2023-08-01', NULL, 'Active', 'Low'),
('Project Mu', '2022-05-01', '2022-12-31', 'Completed', 'High');

-- Insert data into employee_projects
INSERT INTO employee_projects (employee_id, project_id, assignment_date, role) VALUES
(1, 1, '2023-01-01', 'Project Manager'),
(2, 1, '2023-01-15', 'Marketing Lead'),
(3, 2, '2023-03-15', 'Sales Representative'),
(4, 3, '2024-05-01', 'Software Engineer'),
(5, 3, '2024-05-01', 'Lead Engineer'),
(6, 2, '2023-04-01', 'Marketing Specialist'),
(7, 4, '2024-07-01', 'Financial Analyst'),
(8, 4, '2024-07-15', 'Finance Manager'),
(9, 5, '2025-01-10', 'Sales Representative'),
(10, 3, '2024-06-01', 'Software Engineer'),
(11, 2, '2023-09-01', 'Content Creator'),
(12, 4, '2024-08-01', 'Accountant'),
(13, 3, '2024-07-01', 'Junior Software Engineer'),
(14, 1, '2023-02-01', 'HR Liaison'),
(15, 1, '2023-03-01', 'HR Representative'),
(16, 5, '2025-01-15', 'Sales Representative'),
(17, 3, '2024-08-01', 'Data Engineer'),
(18, 2, '2023-10-01', 'SEO Specialist'),
(19, 4, '2024-09-01', 'Senior Financial Analyst'),
(20, 3, '2024-09-15', 'Software Architect'),
(1, 6, '2022-11-01', 'Project Manager'),
(3, 6, '2022-11-15', 'Sales Representative'),
(6, 6, '2022-12-01', 'Marketing Manager'),
(4, 7, '2024-09-01', 'Software Engineer'),
(5, 7, '2024-09-15', 'Lead Engineer'),
(7, 7, '2024-10-01', 'Financial Analyst'),
(9, 8, '2023-06-01', 'Sales Representative'),
(10, 7, '2024-10-15', 'Software Engineer'),
(11, 8, '2023-07-01', 'Content Creator'),
(12, 7, '2024-11-01', 'Accountant'),
(13, 7, '2024-11-15', 'Junior Software Engineer'),
(15, 6, '2023-01-01', 'HR Specialist'),
(17, 7, '2024-12-01', 'Data Engineer'),
(19, 7, '2025-01-01', 'Senior Financial Analyst'),
(20, 7, '2025-01-15', 'Software Architect'),
(2, 9, '2025-03-01', 'Marketing Lead'),
(4, 9, '2025-03-15', 'Software Engineer'),
(10, 9, '2025-04-01', 'Software Engineer'),
(17, 9, '2025-04-15', 'Data Engineer'),
(20, 9, '2025-05-01', 'Software Architect'),
(1, 10, '2024-01-15', 'Project Manager'),
(3, 10, '2024-02-01', 'Sales Representative'),
(6, 10, '2024-03-01', 'Marketing Manager'),
(14, 10, '2024-04-01', 'HR Manager'),
(15, 10, '2024-05-01', 'HR Specialist'),
(2, 11, '2023-08-01', 'Marketing Lead'),
(11, 11, '2023-09-01', 'Content Creator'),
(18, 11, '2023-10-01', 'SEO Specialist'),
(7, 12, '2022-05-01', 'Financial Analyst'),
(8, 12, '2022-05-15', 'Finance Manager'),
(12, 12, '2022-06-01', 'Accountant'),
(19, 12, '2022-06-15', 'Senior Financial Analyst');
