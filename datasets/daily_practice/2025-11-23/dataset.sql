CREATE DATABASE IF NOT EXISTS daily_practice_20251123_schema;
USE daily_practice_20251123_schema;

-- This table logs every attempt, renewal, or change in status for an employee's mandatory training certification.
CREATE TABLE employee_certifications (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    cert_name VARCHAR(50),
    issue_date DATE,
    expiry_date DATE,
    -- Status reflects the outcome of the latest action for this certificate.
    status ENUM('Active', 'Expired', 'Revoked', 'Pending')
);

INSERT INTO employee_certifications (employee_id, cert_name, issue_date, expiry_date, status) VALUES
-- Employee 101: Certification expires on the cutoff day (should be flagged)
(101, 'First Aid (CPR)', '2023-01-01', '2024-01-01', 'Active'),
(101, 'Safety Protocol', '2023-06-01', '2024-06-01', 'Active'),

-- Employee 102: Renewed an expired cert, now current
(102, 'First Aid (CPR)', '2022-01-01', '2023-01-01', 'Expired'), -- Old record
(102, 'First Aid (CPR)', '2023-08-01', '2024-08-01', 'Active'), -- New active record
(102, 'Data Security', '2023-09-01', '2023-12-30', 'Active'), -- Expires just before cutoff

-- Employee 103: Latest certification is revoked
(103, 'IT Security Lvl 1', '2023-10-01', '2024-04-01', 'Active'),
(103, 'IT Security Lvl 1', '2023-11-01', '2024-05-01', 'Revoked'), -- This is the latest status

-- Employee 104: Cert is current, no issues
(104, 'Safety Protocol', '2023-10-15', '2024-10-15', 'Active'),

-- Employee 105: Two pending certifications
(105, 'First Aid (CPR)', '2023-11-01', '2024-11-01', 'Pending'),
(105, 'Safety Protocol', '2023-11-05', '2024-11-05', 'Pending');