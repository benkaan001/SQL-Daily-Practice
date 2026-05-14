CREATE DATABASE IF NOT EXISTS daily_practice_20260514_schema;
USE daily_practice_20260514_schema;

-- Table: Patient Admissions
-- This table tracks when patients enter and leave specific departments.
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    department VARCHAR(50),
    admit_timestamp DATETIME,
    discharge_timestamp DATETIME
);

INSERT INTO admissions (patient_id, department, admit_timestamp, discharge_timestamp) VALUES
-- Cardiology: High concurrency window on 2026-05-14
(1001, 'Cardiology', '2026-05-14 08:00:00', '2026-05-14 12:00:00'), -- P1 starts
(1002, 'Cardiology', '2026-05-14 09:00:00', '2026-05-14 11:30:00'), -- P2 starts (Count: 2)
(1003, 'Cardiology', '2026-05-14 10:00:00', '2026-05-14 14:00:00'), -- P3 starts (Count: 3)
(1004, 'Cardiology', '2026-05-14 11:00:00', '2026-05-14 13:00:00'), -- P4 starts (Count: 4 - PEAK)
(1005, 'Cardiology', '2026-05-14 12:30:00', '2026-05-14 15:00:00'), -- P5 starts

-- Neurology: Different peak window
(2001, 'Neurology',  '2026-05-14 10:00:00', '2026-05-14 16:00:00'),
(2002, 'Neurology',  '2026-05-14 11:00:00', '2026-05-14 12:00:00'),
(2003, 'Neurology',  '2026-05-14 11:30:00', '2026-05-14 13:00:00');