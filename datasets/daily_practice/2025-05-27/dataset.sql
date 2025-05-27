-- Project Management System (copied from 2025-03-13, schema updated)
CREATE SCHEMA IF NOT EXISTS project_management_20250527;
USE project_management_20250527;

CREATE TABLE Projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    project_status VARCHAR(20) DEFAULT 'Active',
    budget DECIMAL(12, 2) NOT NULL
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NULL,
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL
);

CREATE TABLE Tasks (
    task_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT,
    task_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    assigned_to INT NULL,
    task_status VARCHAR(20) DEFAULT 'Open',
    priority VARCHAR(20) DEFAULT 'Medium',
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (assigned_to) REFERENCES Employees(employee_id)
);

CREATE TABLE TaskDependencies (
    dependency_id INT PRIMARY KEY AUTO_INCREMENT,
    task_id INT,
    depends_on INT,
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id),
    FOREIGN KEY (depends_on) REFERENCES Tasks(task_id)
);

CREATE TABLE ProjectUpdates (
    update_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT,
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_text TEXT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- Insert data into Projects
INSERT INTO Projects (project_name, start_date, end_date, project_status, budget) VALUES
('Project Phoenix', '2023-01-15', '2023-12-31', 'Completed', 500000.00),
('Project Titan', '2023-05-01', NULL, 'Active', 750000.00),
('Project Gemini', '2023-09-01', '2024-03-31', 'Active', 300000.00),
('Project Nova', '2024-01-01', NULL, 'Planning', 200000.00),
('Project Apollo', '2022-11-01', '2023-06-30', 'Completed', 600000.00);

-- Insert data into Employees
INSERT INTO Employees (first_name, last_name, email, phone_number, hire_date, job_title) VALUES
('John', 'Smith', 'john.smith@example.com', '555-1111', '2022-01-10', 'Project Manager'),
('Alice', 'Johnson', 'alice.johnson@example.com', '555-2222', '2022-03-15', 'Software Engineer'),
('Bob', 'Williams', 'bob.williams@example.com', NULL, '2022-05-20', 'Data Analyst'),
('Charlie', 'Brown', 'charlie.brown@example.com', '555-4444', '2023-01-05', 'UX Designer'),
('Diana', 'Miller', 'diana.miller@example.com', NULL, '2023-03-10', 'QA Engineer');

-- Insert data into Tasks
INSERT INTO Tasks (project_id, task_name, start_date, end_date, assigned_to, task_status, priority) VALUES
(1, 'Requirements Gathering', '2023-01-15', '2023-02-28', 1, 'Completed', 'High'),
(1, 'Software Development', '2023-03-01', '2023-10-31', 2, 'Completed', 'High'),
(2, 'Database Design', '2023-05-01', '2023-06-30', 3, 'Completed', 'High'),
(2, 'Frontend Development', '2023-07-01', NULL, 4, 'In Progress', 'Medium'),
(3, 'Backend Development', '2023-09-01', '2024-01-31', 2, 'Completed', 'High'),
(3, 'Testing and QA', '2024-02-01', '2024-03-31', 5, 'Completed', 'Medium'),
(4, 'Project Planning', '2024-01-01', '2024-02-29', 1, 'Completed', 'High'),
(4, 'Resource Allocation', '2024-03-01', NULL, NULL, 'Open', 'Medium'),
(5, 'System Design', '2022-11-01', '2023-01-31', 1, 'Completed', 'High'),
(5, 'Implementation', '2023-02-01', '2023-05-31', 2, 'Completed', 'High'),
(2, 'API Development', '2023-06-01', NULL, 3, 'In Progress', 'Medium'),
(3, 'Deployment', '2024-03-01', '2024-03-31', 1, 'Completed', 'High'),
(5, 'Integration Testing', '2023-06-01', '2023-06-30', 5, 'Completed', 'Medium'),
(1, 'Final Testing', '2023-11-01', '2023-12-31', 5, 'Completed', 'High'),
(4, 'Documentation', '2024-03-01', NULL, 4, 'Open', 'Medium');

-- Insert data into TaskDependencies
INSERT INTO TaskDependencies (task_id, depends_on) VALUES
(2, 1),
(5, 3),
(6, 5),
(10, 9),
(13, 10),
(14, 2);

-- Insert data into ProjectUpdates
INSERT INTO ProjectUpdates (project_id, update_text) VALUES
(1, 'Requirements gathering completed. Development started.'),
(2, 'Database design finalized.'),
(3, 'Backend development completed. Testing in progress.'),
(4, 'Project planning completed. Awaiting resource allocation.');
