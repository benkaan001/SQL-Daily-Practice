-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250621_schema;
USE daily_practice_20250621_schema;


-- Create Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

-- Insert Data into Employees Table
INSERT INTO Employees (employee_id, first_name, last_name, department, hire_date, salary) VALUES
(101, 'Alice', 'Smith', 'Engineering', '2022-01-10', 90000.00),
(102, 'Bob', 'Johnson', 'Engineering', '2022-03-15', 92000.00),
(103, 'Charlie', 'Brown', 'HR', '2023-02-01', 65000.00),
(104, 'Diana', 'Miller', 'Sales', '2023-01-20', 70000.00),
(105, 'Eve', 'Davis', 'Sales', '2023-03-01', 68000.00),
(106, 'Frank', 'Wilson', 'Marketing', '2022-05-01', 75000.00),
(107, 'Grace', 'Taylor', 'Engineering', '2024-01-01', 85000.00),
(108, 'Henry', 'Moore', 'HR', '2023-04-10', 68000.00);

-- Create AttendanceLogs Table
CREATE TABLE AttendanceLogs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    log_date DATE NOT NULL,
    log_in_time TIME NOT NULL,
    log_out_time TIME, -- Can be NULL if employee hasn't logged out yet
    activity_description VARCHAR(255), -- Can be NULL
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Insert Data into AttendanceLogs Table (with some NULLs for log_out_time and description)
-- Alice Smith (101) - Engineering, consistent attendance, some consecutive days
INSERT INTO AttendanceLogs (employee_id, log_date, log_in_time, log_out_time, activity_description) VALUES
(101, '2025-06-10', '09:00:00', '17:00:00', 'Project A development'),
(101, '2025-06-11', '09:05:00', '17:15:00', 'Team meeting and coding'),
(101, '2025-06-12', '08:55:00', '16:50:00', NULL), -- NULL description
(101, '2025-06-13', '09:00:00', '17:00:00', 'Code review'),
(101, '2025-06-14', '09:10:00', '16:45:00', 'Bug fixing'),
(101, '2025-06-17', '09:00:00', '17:00:00', 'Daily standup');

-- Bob Johnson (102) - Engineering, some incomplete logs
INSERT INTO AttendanceLogs (employee_id, log_date, log_in_time, log_out_time, activity_description) VALUES
(102, '2025-06-10', '09:15:00', '17:30:00', 'Feature implementation'),
(102, '2025-06-11', '09:00:00', '17:00:00', 'System testing'),
(102, '2025-06-12', '09:30:00', NULL, 'Working on critical bug'), -- NULL log_out_time (still working)
(102, '2025-06-13', '09:00:00', '17:00:00', 'Documentation update'),
(102, '2025-06-18', '08:45:00', NULL, 'Preparing for demo'); -- Another NULL log_out_time

-- Charlie Brown (103) - HR, regular hours
INSERT INTO AttendanceLogs (employee_id, log_date, log_in_time, log_out_time, activity_description) VALUES
(103, '2025-06-10', '08:30:00', '16:30:00', 'Recruitment calls'),
(103, '2025-06-11', '08:40:00', '16:45:00', 'Employee onboarding'),
(103, '2025-06-12', '08:35:00', '16:35:00', 'Policy review');

-- Diana Miller (104) - Sales, varied hours, one NULL
INSERT INTO AttendanceLogs (employee_id, log_date, log_in_time, log_out_time, activity_description) VALUES
(104, '2025-06-10', '09:00:00', '17:00:00', 'Client meetings'),
(104, '2025-06-11', '09:00:00', '18:00:00', 'Client presentations'),
(104, '2025-06-12', '09:00:00', NULL, 'Following up with leads'); -- NULL log_out_time

-- Eve Davis (105) - Sales, less activity
INSERT INTO AttendanceLogs (employee_id, log_date, log_in_time, log_out_time, activity_description) VALUES
(105, '2025-06-10', '09:00:00', '17:00:00', 'Sales strategy meeting');

-- Frank Wilson (106) - Marketing
INSERT INTO AttendanceLogs (employee_id, log_date, log_in_time, log_out_time, activity_description) VALUES
(106, '2025-06-10', '09:00:00', '17:00:00', 'Campaign planning'),
(106, '2025-06-11', '09:00:00', '17:00:00', 'Social media content creation');

-- Grace Taylor (107) - Engineering, new hire, limited logs
INSERT INTO AttendanceLogs (employee_id, log_date, log_in_time, log_out_time, activity_description) VALUES
(107, '2025-06-17', '09:00:00', '17:00:00', 'Onboarding modules');

-- Henry Moore (108) - HR, one log with NULL description
INSERT INTO AttendanceLogs (employee_id, log_date, log_in_time, log_out_time, activity_description) VALUES
(108, '2025-06-10', '08:50:00', '16:50:00', 'Performance reviews');
