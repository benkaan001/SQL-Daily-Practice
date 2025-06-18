-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250630_schema;
USE daily_practice_20250630_schema;

-- Create Projects Table
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    due_date DATE, -- Overall project due date, can be NULL
    project_lead VARCHAR(50)
);

-- Insert Data into Projects Table
INSERT INTO Projects (project_id, project_name, start_date, due_date, project_lead) VALUES
(1, 'E-commerce Platform Relaunch', '2024-01-01', '2024-06-30', 'Alice'),
(2, 'Internal CRM Development', '2024-03-01', '2024-09-30', 'Bob'),
(3, 'Data Analytics Dashboard', '2024-05-15', NULL, 'Charlie'), -- Ongoing, no fixed due date
(4, 'Mobile App v2.0', '2024-07-01', '2025-01-31', 'Alice');

-- Create Milestones Table
CREATE TABLE Milestones (
    milestone_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    milestone_name VARCHAR(100) NOT NULL,
    planned_start_date DATE NOT NULL,
    planned_end_date DATE NOT NULL,
    actual_completion_date DATE, -- NULL if not completed
    dependency_milestone_id INT, -- Self-referencing FK, can be NULL
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (dependency_milestone_id) REFERENCES Milestones(milestone_id)
);

-- Insert Data into Milestones Table
-- Project 1: E-commerce Platform Relaunch
INSERT INTO Milestones (project_id, milestone_name, planned_start_date, planned_end_date, actual_completion_date, dependency_milestone_id) VALUES
(1, 'Requirements Gathering', '2024-01-01', '2024-01-31', '2024-01-25', NULL), -- M1
(1, 'UI/UX Design Approval', '2024-02-01', '2024-02-29', '2024-02-28', 1), -- M2 (depends on M1)
(1, 'Frontend Development Complete', '2024-03-01', '2024-04-15', '2024-04-10', 2), -- M3 (depends on M2)
(1, 'Backend API Integration', '2024-04-16', '2024-05-31', '2024-05-25', 3), -- M4 (depends on M3)
(1, 'Testing & QA', '2024-06-01', '2024-06-20', '2024-06-18', 4), -- M5 (depends on M4)
(1, 'Final Deployment', '2024-06-21', '2024-06-30', NULL, 5); -- M6 (depends on M5, not completed)

-- Project 2: Internal CRM Development
INSERT INTO Milestones (project_id, milestone_name, planned_start_date, planned_end_date, actual_completion_date, dependency_milestone_id) VALUES
(2, 'Database Schema Design', '2024-03-01', '2024-03-20', '2024-03-18', NULL), -- M7
(2, 'User Module Development', '2024-03-21', '2024-05-15', '2024-05-10', 7), -- M8 (depends on M7)
(2, 'Reporting Module Dev', '2024-05-16', '2024-07-31', '2024-08-05', 8), -- M9 (depends on M8, completed late)
(2, 'Security Audit', '2024-08-01', '2024-08-31', NULL, 9); -- M10 (depends on M9, still pending)

-- Project 3: Data Analytics Dashboard
INSERT INTO Milestones (project_id, milestone_name, planned_start_date, planned_end_date, actual_completion_date, dependency_milestone_id) VALUES
(3, 'Data Source Connection', '2024-05-15', '2024-05-30', '2024-05-28', NULL), -- M11
(3, 'Dashboard UI Prototyping', '2024-06-01', '2024-06-20', '2024-06-15', 11), -- M12
(3, 'Data Transformation Pipelines', '2024-06-21', '2024-07-31', NULL, 12); -- M13 (depends on M12, currently pending)

-- Project 4: Mobile App v2.0
INSERT INTO Milestones (project_id, milestone_name, planned_start_date, planned_end_date, actual_completion_date, dependency_milestone_id) VALUES
(4, 'Feature Specifications', '2024-07-01', '2024-07-31', '2024-07-28', NULL), -- M14
(4, 'Cross-Platform Dev Setup', '2024-08-01', '2024-08-15', '2024-08-10', 14), -- M15
(4, 'Core Functionality Build', '2024-08-16', '2024-11-30', NULL, 15); -- M16 (depends on M15, currently pending)

-- Add a milestone with a NULL actual_completion_date for a past planned_end_date to represent overdue
INSERT INTO Milestones (project_id, milestone_name, planned_start_date, planned_end_date, actual_completion_date, dependency_milestone_id) VALUES
(1, 'Post-Launch Review', '2024-07-01', '2024-07-15', NULL, 6); -- M17 (depends on M6, overdue if M6 was done)

-- Add a non-dependent, completed milestone to test overall project completion criteria
INSERT INTO Milestones (project_id, milestone_name, planned_start_date, planned_end_date, actual_completion_date, dependency_milestone_id) VALUES
(3, 'User Training Materials', '2024-08-01', '2024-08-20', '2024-08-15', NULL); -- M18

