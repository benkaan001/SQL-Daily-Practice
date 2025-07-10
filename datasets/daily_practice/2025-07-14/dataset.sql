-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250714_schema;
USE daily_practice_20250714_schema;


-- Create Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    blood_type VARCHAR(5), -- Can be NULL
    allergies TEXT -- Can be NULL
);

-- Insert Data into Patients Table
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender, blood_type, allergies) VALUES
(1, 'Alice', 'Smith', '1980-01-15', 'Female', 'A+', 'Penicillin'),
(2, 'Bob', 'Johnson', '1975-03-20', 'Male', 'O-', NULL),
(3, 'Charlie', 'Brown', '1990-05-10', 'Male', 'B+', 'Pollen'),
(4, 'Diana', 'Miller', '1965-07-01', 'Female', 'AB+', NULL),
(5, 'Eve', 'Davis', '2000-09-25', 'Female', 'A-', 'Dust Mites'),
(6, 'Frank', 'Wilson', '1950-11-12', 'Male', NULL, 'Latex'); -- NULL blood_type

-- Create PatientVisits Table
CREATE TABLE PatientVisits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    visit_date DATE NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    reason_for_visit TEXT,
    visit_type ENUM('Check-up', 'Consultation', 'Emergency', 'Follow-up') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Insert Data into PatientVisits Table
-- Alice Smith (ID 1)
INSERT INTO PatientVisits (patient_id, visit_date, doctor_name, reason_for_visit, visit_type) VALUES
(1, '2024-01-10', 'Dr. Lee', 'Routine checkup', 'Check-up'),
(1, '2024-03-01', 'Dr. Chen', 'Persistent cough', 'Consultation'),
(1, '2024-03-15', 'Dr. Chen', 'Cough follow-up', 'Follow-up'),
(1, '2024-06-01', 'Dr. Lee', 'Annual physical', 'Check-up');

-- Bob Johnson (ID 2)
INSERT INTO PatientVisits (patient_id, visit_date, doctor_name, reason_for_visit, visit_type) VALUES
(2, '2024-01-20', 'Dr. Kim', 'Back pain', 'Consultation'),
(2, '2024-02-10', 'Dr. Kim', 'Back pain follow-up', 'Follow-up'),
(2, '2024-05-01', 'Dr. Lee', 'General health check', 'Check-up');

-- Charlie Brown (ID 3)
INSERT INTO PatientVisits (patient_id, visit_date, doctor_name, reason_for_visit, visit_type) VALUES
(3, '2024-02-05', 'Dr. Chen', 'Allergy symptoms', 'Consultation'),
(3, '2024-04-10', 'Dr. Kim', 'Sports injury', 'Emergency');

-- Diana Miller (ID 4)
INSERT INTO PatientVisits (patient_id, visit_date, doctor_name, reason_for_visit, visit_type) VALUES
(4, '2024-03-10', 'Dr. Lee', 'Blood pressure check', 'Check-up');

-- Eve Davis (ID 5)
INSERT INTO PatientVisits (patient_id, visit_date, doctor_name, reason_for_visit, visit_type) VALUES
(5, '2024-04-01', 'Dr. Chen', 'Skin irritation', 'Consultation');

-- Frank Wilson (ID 6)
INSERT INTO PatientVisits (patient_id, visit_date, doctor_name, reason_for_visit, visit_type) VALUES
(6, '2024-05-15', 'Dr. Kim', 'Joint pain', 'Consultation');

-- Create Diagnoses Table
CREATE TABLE Diagnoses (
    diagnosis_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    diagnosis_code VARCHAR(20) NOT NULL, -- e.g., ICD-10 code
    diagnosis_name VARCHAR(255) NOT NULL,
    is_primary BOOLEAN NOT NULL, -- True if primary diagnosis for the visit
    FOREIGN KEY (visit_id) REFERENCES PatientVisits(visit_id)
);

-- Insert Data into Diagnoses Table
-- Visit 1 (Alice, Check-up)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(1, 'Z00.00', 'Encounter for general adult medical examination without abnormal findings', TRUE);

-- Visit 2 (Alice, Consultation)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(2, 'J41.0', 'Simple chronic bronchitis', TRUE),
(2, 'R05', 'Cough', FALSE);

-- Visit 3 (Alice, Follow-up)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(3, 'J41.0', 'Simple chronic bronchitis', TRUE);

-- Visit 4 (Alice, Check-up)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(4, 'Z00.00', 'Encounter for general adult medical examination without abnormal findings', TRUE);

-- Visit 5 (Bob, Consultation)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(5, 'M54.5', 'Low back pain', TRUE);

-- Visit 6 (Bob, Follow-up)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(6, 'M54.5', 'Low back pain', TRUE);

-- Visit 7 (Bob, Check-up)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(7, 'Z00.00', 'Encounter for general adult medical examination without abnormal findings', TRUE);

-- Visit 8 (Charlie, Consultation)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(8, 'J30.1', 'Allergic rhinitis due to pollen', TRUE);

-- Visit 9 (Charlie, Emergency)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(9, 'S83.5', 'Sprain of knee', TRUE),
(9, 'W01.0XXA', 'Fall on same level', FALSE);

-- Visit 10 (Diana, Check-up)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(10, 'I10', 'Essential (primary) hypertension', TRUE);

-- Visit 11 (Eve, Consultation)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(11, 'L23.9', 'Allergic contact dermatitis, unspecified', TRUE);

-- Visit 12 (Frank, Consultation)
INSERT INTO Diagnoses (visit_id, diagnosis_code, diagnosis_name, is_primary) VALUES
(12, 'M25.56', 'Pain in knee, left', TRUE),
(12, 'M25.50', 'Pain in unspecified joint', FALSE);
