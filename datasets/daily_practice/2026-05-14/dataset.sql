CREATE DATABASE IF NOT EXISTS daily_practice_20260514_schema;
USE daily_practice_20260514_schema;

-- Table 1: Patient Admissions
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    department VARCHAR(50),
    admit_timestamp DATETIME,
    discharge_timestamp DATETIME,
    diagnosis VARCHAR(100)
);

-- Table 2: Doctor Shift Schedule
CREATE TABLE doctor_shifts (
    shift_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT,
    shift_start DATETIME,
    shift_end DATETIME,
    specialty VARCHAR(50)
);

INSERT INTO admissions (patient_id, doctor_id, department, admit_timestamp, discharge_timestamp, diagnosis) VALUES
-- Patient 1: Readmitted to Cardiology within 30 days
(1001, 501, 'Cardiology', '2026-04-01 10:00:00', '2026-04-05 14:00:00', 'Chest Pain'),
(1001, 501, 'Cardiology', '2026-04-20 08:00:00', '2026-04-22 12:00:00', 'Atrial Fibrillation'),

-- Patient 2: Readmitted but to a different department (Not a departmental readmission)
(1002, 502, 'Neurology',  '2026-04-05 09:00:00', '2026-04-10 15:00:00', 'Migraine'),
(1002, 503, 'Orthopedics', '2026-04-15 11:00:00', '2026-04-16 18:00:00', 'Fracture'),

-- Patient 3: Long stay spanning a peak
(1003, 501, 'Cardiology', '2026-05-14 08:00:00', '2026-05-14 20:00:00', 'Routine Check'),

-- Patient 4: Admitted during a peak
(1004, 504, 'Cardiology', '2026-05-14 10:00:00', '2026-05-14 14:00:00', 'Palpitations'),

-- Patient 5: Admitted during a peak
(1005, 501, 'Cardiology', '2026-05-14 11:00:00', '2026-05-14 15:00:00', 'Hypertension'),

-- Patient 6: Doctor Shift Violation Example (Admitted when Doc 505 wasn't on shift)
(1006, 505, 'Neurology',  '2026-05-14 02:00:00', '2026-05-14 06:00:00', 'Sleep Study');

INSERT INTO doctor_shifts (doctor_id, shift_start, shift_end, specialty) VALUES
(501, '2026-04-01 07:00:00', '2026-04-01 19:00:00', 'Cardiology'),
(501, '2026-04-20 07:00:00', '2026-04-20 19:00:00', 'Cardiology'),
(501, '2026-05-14 07:00:00', '2026-05-14 19:00:00', 'Cardiology'),
(502, '2026-04-05 07:00:00', '2026-04-05 19:00:00', 'Neurology'),
(503, '2026-04-15 07:00:00', '2026-04-15 19:00:00', 'Orthopedics'),
(504, '2026-05-14 07:00:00', '2026-05-14 19:00:00', 'Cardiology'),
(505, '2026-05-14 08:00:00', '2026-05-14 20:00:00', 'Neurology'); -- Shifts start at 08:00, Patient 1006 arrived at 02:00