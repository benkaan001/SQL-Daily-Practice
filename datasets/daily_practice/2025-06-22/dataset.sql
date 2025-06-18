-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250622_schema;
USE daily_practice_20250622_schema;


-- Create Projects Table
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE, -- Can be NULL for ongoing projects without a set end date
    budget DECIMAL(15, 2)
);

-- Insert Data into Projects Table
INSERT INTO Projects (project_id, project_name, start_date, end_date, budget) VALUES
(1, 'Website Redesign', '2024-01-15', '2024-06-30', 50000.00),
(2, 'Mobile App Development', '2024-03-01', '2025-03-31', 120000.00),
(3, 'Internal Tools Upgrade', '2024-05-10', '2025-01-31', 80000.00),
(4, 'Data Migration Project', '2024-08-01', '2024-11-30', 30000.00),
(5, 'New Product Launch', '2025-01-01', NULL, 75000.00); -- Ongoing, no set end date

-- Create Tasks Table
CREATE TABLE Tasks (
    task_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    task_name VARCHAR(150) NOT NULL,
    assigned_to VARCHAR(50), -- Employee name, can be NULL if unassigned
    status ENUM('Not Started', 'In Progress', 'Completed', 'Cancelled', 'On Hold') NOT NULL,
    priority ENUM('Low', 'Medium', 'High'), -- Can be NULL
    due_date DATE, -- Can be NULL
    actual_start_date DATE, -- Can be NULL
    actual_end_date DATE, -- Can be NULL
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- Insert Data into Tasks Table
-- Project 1: Website Redesign
INSERT INTO Tasks (project_id, task_name, assigned_to, status, priority, due_date, actual_start_date, actual_end_date) VALUES
(1, 'Gather Requirements', 'Alice Smith', 'Completed', 'High', '2024-01-30', '2024-01-15', '2024-01-28'),
(1, 'Design UI/UX', 'Bob Johnson', 'Completed', 'High', '2024-02-20', '2024-02-01', '2024-02-18'),
(1, 'Develop Frontend', 'Alice Smith', 'Completed', 'Medium', '2024-04-15', '2024-02-25', '2024-04-10'),
(1, 'Develop Backend', 'Charlie Brown', 'Completed', 'Medium', '2024-05-10', '2024-03-15', '2024-05-05'),
(1, 'Integrate APIs', 'Bob Johnson', 'In Progress', 'High', '2024-06-15', '2024-05-15', NULL), -- Overdue
(1, 'Testing Phase', 'Diana Miller', 'Not Started', 'Low', '2024-06-25', NULL, NULL), -- Overdue
(1, 'Deploy Website', 'Charlie Brown', 'Not Started', NULL, '2024-06-28', NULL, NULL); -- Overdue, NULL priority

-- Project 2: Mobile App Development
INSERT INTO Tasks (project_id, task_name, assigned_to, status, priority, due_date, actual_start_date, actual_end_date) VALUES
(2, 'Define Features', 'Alice Smith', 'Completed', 'High', '2024-03-15', '2024-03-01', '2024-03-12'),
(2, 'iOS Development', 'Eve Davis', 'In Progress', 'High', '2025-01-31', '2024-04-01', NULL),
(2, 'Android Development', 'Frank White', 'In Progress', 'Medium', '2025-02-28', '2024-04-10', NULL),
(2, 'Database Design', 'Charlie Brown', 'Completed', 'Medium', '2024-04-30', '2024-03-20', '2024-04-25'),
(2, 'User Acceptance Testing', 'Diana Miller', 'Not Started', 'Low', '2025-03-15', NULL, NULL);

-- Project 3: Internal Tools Upgrade
INSERT INTO Tasks (project_id, task_name, assigned_to, status, priority, due_date, actual_start_date, actual_end_date) VALUES
(3, 'Audit Current Tools', 'Grace Taylor', 'Completed', 'Medium', '2024-05-30', '2024-05-10', '2024-05-28'),
(3, 'Propose Solutions', 'Grace Taylor', 'Completed', 'High', '2024-06-20', '2024-06-01', '2024-06-19'),
(3, 'Implement Phase 1', 'Henry King', 'In Progress', 'Medium', '2024-10-31', '2024-07-01', NULL),
(3, 'Training Users', 'Grace Taylor', 'Not Started', 'Low', '2025-01-15', NULL, NULL);

-- Project 4: Data Migration Project
INSERT INTO Tasks (project_id, task_name, assigned_to, status, priority, due_date, actual_start_date, actual_end_date) VALUES
(4, 'Data Extraction', 'Henry King', 'Completed', 'High', '2024-08-15', '2024-08-01', '2024-08-10'),
(4, 'Data Transformation', 'Henry King', 'Completed', 'Medium', '2024-09-30', '2024-08-20', '2024-09-25'),
(4, 'Load Data', 'Henry King', 'Not Started', 'High', '2024-10-31', NULL, NULL), -- Overdue
(4, 'Validation', 'Grace Taylor', 'Not Started', 'Medium', '2024-11-20', NULL, NULL);

-- Project 5: New Product Launch
INSERT INTO Tasks (project_id, task_name, assigned_to, status, priority, due_date, actual_start_date, actual_end_date) VALUES
(5, 'Market Research', 'Diana Miller', 'Completed', 'Medium', '2025-01-30', '2025-01-01', '2025-01-25'),
(5, 'Product Design', 'Eve Davis', 'In Progress', 'High', '2025-03-15', '2025-02-01', NULL),
(5, 'Manufacturing Setup', NULL, 'Not Started', 'High', '2025-04-30', NULL, NULL); -- Unassigned
