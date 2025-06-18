-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250625_schema;
USE daily_practice_20250625_schema;


-- Create Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    phone_number VARCHAR(20), -- Can be NULL
    email VARCHAR(100) UNIQUE -- Can be NULL
);

-- Insert Data into Patients Table
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender, phone_number, email) VALUES
(1, 'John', 'Doe', '1985-05-10', 'Male', '555-1111', 'john.doe@example.com'),
(2, 'Jane', 'Smith', '1990-11-22', 'Female', '555-2222', 'jane.smith@example.com'),
(3, 'Peter', 'Jones', '1970-03-01', 'Male', '555-3333', NULL), -- NULL email
(4, 'Alice', 'Williams', '2000-07-15', 'Female', NULL, 'alice.w@example.com'), -- NULL phone_number
(5, 'Bob', 'Brown', '1962-09-01', 'Male', '555-5555', 'bob.b@example.com'),
(6, 'Charlie', 'Davis', '1995-01-20', 'Male', '555-6666', 'charlie.d@example.com');

-- Create Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50) NOT NULL,
    reason_for_visit TEXT, -- Can be NULL
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'No-Show') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Insert Data into Appointments Table
-- John Doe (patient_id 1) - varied appointments, some consecutive
INSERT INTO Appointments (patient_id, appointment_date, appointment_time, doctor_name, specialty, reason_for_visit, status) VALUES
(1, '2024-01-05', '09:00:00', 'Dr. Adams', 'General Practice', 'Annual Checkup', 'Completed'),
(1, '2024-01-10', '14:30:00', 'Dr. Smith', 'Cardiology', 'Chest Pain', 'Completed'),
(1, '2024-02-01', '10:00:00', 'Dr. Adams', 'General Practice', 'Follow-up', 'Completed'),
(1, '2024-02-08', '11:00:00', 'Dr. Adams', 'General Practice', 'Flu Symptoms', 'Completed'),
(1, '2024-03-01', '09:00:00', 'Dr. Evans', 'Dermatology', 'Skin Rash', 'Completed'),
(1, '2024-03-05', '13:00:00', 'Dr. Evans', 'Dermatology', 'Follow-up on rash', 'Scheduled'), -- Future appointment
(1, '2024-04-01', '10:00:00', 'Dr. Smith', 'Cardiology', 'Routine Check', 'Cancelled'),
(1, '2024-04-15', '10:00:00', 'Dr. Smith', 'Cardiology', 'Routine Check', 'Scheduled'); -- Rescheduled

-- Jane Smith (patient_id 2) - mostly completed, one no-show
INSERT INTO Appointments (patient_id, appointment_date, appointment_time, doctor_name, specialty, reason_for_visit, status) VALUES
(2, '2024-01-15', '10:00:00', 'Dr. Green', 'Pediatrics', 'Child Checkup', 'Completed'),
(2, '2024-02-10', '15:00:00', 'Dr. White', 'Ophthalmology', 'Eye Exam', 'Completed'),
(2, '2024-03-05', '11:00:00', 'Dr. Green', 'Pediatrics', NULL, 'No-Show'), -- NULL reason
(2, '2024-04-01', '09:30:00', 'Dr. Green', 'Pediatrics', 'Vaccination', 'Completed');

-- Peter Jones (patient_id 3) - regular, one cancelled
INSERT INTO Appointments (patient_id, appointment_date, appointment_time, doctor_name, specialty, reason_for_visit, status) VALUES
(3, '2024-01-20', '11:00:00', 'Dr. Brown', 'Orthopedics', 'Knee Pain', 'Completed'),
(3, '2024-02-20', '10:00:00', 'Dr. Brown', 'Orthopedics', 'Follow-up Knee', 'Completed'),
(3, '2024-03-10', '14:00:00', 'Dr. Brown', 'Orthopedics', 'Physical Therapy', 'Cancelled'),
(3, '2024-03-20', '14:00:00', 'Dr. Brown', 'Orthopedics', 'Physical Therapy', 'Completed'); -- Rescheduled and completed

-- Alice Williams (patient_id 4) - few appointments
INSERT INTO Appointments (patient_id, appointment_date, appointment_time, doctor_name, specialty, reason_for_visit, status) VALUES
(4, '2024-01-25', '08:00:00', 'Dr. Gray', 'Dentistry', 'Dental Cleaning', 'Completed');

-- Bob Brown (patient_id 5) - older patient, some specific appointments
INSERT INTO Appointments (patient_id, appointment_date, appointment_time, doctor_name, specialty, reason_for_visit, status) VALUES
(5, '2024-01-01', '10:00:00', 'Dr. Long', 'Geriatrics', 'General Checkup', 'Completed'),
(5, '2024-01-08', '10:00:00', 'Dr. Long', 'Geriatrics', 'Blood Test', 'Completed'),
(5, '2024-01-15', '10:00:00', 'Dr. Long', 'Geriatrics', 'Results Review', 'Completed');

-- Charlie Davis (patient_id 6) - single appointment
INSERT INTO Appointments (patient_id, appointment_date, appointment_time, doctor_name, specialty, reason_for_visit, status) VALUES
(6, '2024-02-05', '16:00:00', 'Dr. Adams', 'General Practice', 'New Patient Visit', 'Completed');
