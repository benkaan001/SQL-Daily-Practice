CREATE DATABASE IF NOT EXISTS daily_practice_20250925_schema;
USE daily_practice_20250925_schema;

-- This table logs the state changes for loan applications.
CREATE TABLE loan_applications (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('SUBMITTED', 'UNDERWRITING_STARTED', 'ADDITIONAL_DOCS_REQUESTED', 'ADDITIONAL_DOCS_RECEIVED', 'APPROVED', 'REJECTED', 'FUNDS_DISBURSED')
);

INSERT INTO loan_applications (application_id, event_timestamp, event_type) VALUES
-- Application A-101: A smooth approval process
('A-101', '2023-11-01 10:00:00.000', 'SUBMITTED'),
('A-101', '2023-11-01 11:30:00.000', 'UNDERWRITING_STARTED'),
('A-101', '2023-11-02 14:00:00.000', 'APPROVED'),
('A-101', '2023-11-03 09:00:00.000', 'FUNDS_DISBURSED'),

-- Application B-202: A process with a documentation request
('B-202', '2023-11-05 09:00:00.000', 'SUBMITTED'),
('B-202', '2023-11-05 09:30:00.000', 'UNDERWRITING_STARTED'),
('B-202', '2023-11-06 15:00:00.000', 'ADDITIONAL_DOCS_REQUESTED'),
('B-202', '2023-11-08 11:00:00.000', 'ADDITIONAL_DOCS_RECEIVED'),
('B-202', '2023-11-08 16:00:00.000', 'APPROVED'),
('B-202', '2023-11-09 10:00:00.000', 'FUNDS_DISBURSED'),

-- Application C-303: A rejected application
('C-303', '2023-11-10 14:00:00.000', 'SUBMITTED'),
('C-303', '2023-11-10 14:15:00.000', 'UNDERWRITING_STARTED'),
('C-303', '2023-11-11 16:00:00.000', 'REJECTED'),

-- Application D-404: An application still in progress
('D-404', '2023-11-12 11:00:00.000', 'SUBMITTED'),
('D-404', '2023-11-12 11:10:00.000', 'UNDERWRITING_STARTED');
