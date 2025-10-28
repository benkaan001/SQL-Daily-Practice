CREATE DATABASE IF NOT EXISTS daily_practice_20251028_schema;
USE daily_practice_20251028_schema;

-- This table logs job applications submitted by candidates.
CREATE TABLE job_applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT,
    application_date DATE,
    job_id INT,
    job_title VARCHAR(100),
    job_level ENUM('Junior', 'Mid-Level', 'Senior', 'Lead'),
    department VARCHAR(50),
    status ENUM('Received', 'Screening', 'Interviewing', 'Offer Extended', 'Hired', 'Rejected', 'Withdrawn')
);

INSERT INTO job_applications (candidate_id, application_date, job_id, job_title, job_level, department, status) VALUES
-- Candidate 101: Applies for Junior, then Senior in the same dept
(101, '2023-09-01', 501, 'Junior Software Engineer', 'Junior', 'Engineering', 'Rejected'),
(101, '2023-10-15', 505, 'Senior Software Engineer', 'Senior', 'Engineering', 'Interviewing'),

-- Candidate 102: Applies for Junior, then Mid-Level in different depts
(102, '2023-09-05', 601, 'Junior Data Analyst', 'Junior', 'Data Science', 'Hired'),
(102, '2023-10-20', 702, 'Mid-Level Product Manager', 'Mid-Level', 'Product', 'Withdrawn'),

-- Candidate 103: Applies for Mid-Level only
(103, '2023-09-10', 502, 'Mid-Level Software Engineer', 'Mid-Level', 'Engineering', 'Offer Extended'),

-- Candidate 104: Applies for Junior, then Lead in the same dept (large jump)
(104, '2023-09-15', 801, 'Junior Marketing Associate', 'Junior', 'Marketing', 'Screening'),
(104, '2023-11-01', 805, 'Marketing Lead', 'Lead', 'Marketing', 'Received'),

-- Candidate 105: Applies for Senior only
(105, '2023-09-20', 505, 'Senior Software Engineer', 'Senior', 'Engineering', 'Hired'),

-- Candidate 106: Applies for Junior (Eng), then Junior (Data) - no progression
(106, '2023-09-25', 501, 'Junior Software Engineer', 'Junior', 'Engineering', 'Rejected'),
(106, '2023-10-05', 601, 'Junior Data Analyst', 'Junior', 'Data Science', 'Screening'),

-- Candidate 101: Applies for another Senior role later
(101, '2023-11-05', 506, 'Senior Backend Engineer', 'Senior', 'Engineering', 'Received'),

-- Candidate 107: Applies for Mid-Level, then Senior in same dept
(107, '2023-10-01', 702, 'Mid-Level Product Manager', 'Mid-Level', 'Product', 'Rejected'),
(107, '2023-11-10', 705, 'Senior Product Manager', 'Senior', 'Product', 'Received');
