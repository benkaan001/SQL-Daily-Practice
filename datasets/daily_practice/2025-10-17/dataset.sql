CREATE DATABASE IF NOT EXISTS daily_practice_20251017_schema;
USE daily_practice_20251017_schema;

-- This table stores employee access rights and termination dates for specific systems.
CREATE TABLE employee_access_rights (
    access_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    system_name VARCHAR(50),
    access_end_date DATETIME(3) -- The exact moment the employee's access was revoked.
);

-- This table logs every time an employee logs into or out of a system.
CREATE TABLE employee_access_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    event_timestamp DATETIME(3),
    access_event ENUM('LOGIN', 'LOGOUT'),
    system_name VARCHAR(50)
);

INSERT INTO employee_access_rights (employee_id, system_name, access_end_date) VALUES
-- Employee 101's access to Sales_CRM was terminated.
(101, 'Sales_CRM', '2023-11-20 17:00:00.000'),
-- Employee 103's access to HR_Portal was terminated.
(103, 'HR_Portal', '2023-11-22 10:00:00.000'),
-- Employee 104 has access terminated, but had no active sessions.
(104, 'Engineering_Docs', '2023-11-25 12:00:00.000');


INSERT INTO employee_access_logs (employee_id, event_timestamp, access_event, system_name) VALUES
-- Employee 101: Logs into CRM, access is terminated, but they never log out. A lingering session.
(101, '2023-11-20 09:00:00.000', 'LOGIN', 'Sales_CRM'),
(101, '2023-11-21 10:00:00.000', 'LOGIN', 'HR_Portal'), -- This session is fine.
(101, '2023-11-21 18:00:00.000', 'LOGOUT', 'HR_Portal'),

-- Employee 102: Active session, but their access is not terminated.
(102, '2023-11-21 11:00:00.000', 'LOGIN', 'Sales_CRM'),

-- Employee 103: Logs in and out of HR Portal cleanly before access is terminated. No issue.
(103, '2023-11-22 08:00:00.000', 'LOGIN', 'HR_Portal'),
(103, '2023-11-22 09:55:00.000', 'LOGOUT', 'HR_Portal'),

-- Employee 104: Access terminated, but they were already logged out. No issue.
(104, '2023-11-24 14:00:00.000', 'LOGIN', 'Engineering_Docs'),
(104, '2023-11-24 18:00:00.000', 'LOGOUT', 'Engineering_Docs');
