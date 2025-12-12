CREATE DATABASE IF NOT EXISTS daily_practice_20251207_schema;
USE daily_practice_20251207_schema;

-- Logs employee shift assignments. Employees should not be double-booked.
CREATE TABLE shift_assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    shift_start DATETIME,
    shift_end DATETIME,
    role VARCHAR(50)
);

INSERT INTO shift_assignments (employee_id, shift_start, shift_end, role) VALUES
-- Emp 101: Clean schedule
(101, '2023-12-07 08:00:00', '2023-12-07 12:00:00', 'Cashier'),
(101, '2023-12-07 13:00:00', '2023-12-07 17:00:00', 'Stocker'),

-- Emp 102: Double booked! (Overlap)
(102, '2023-12-07 09:00:00', '2023-12-07 14:00:00', 'Manager'),
(102, '2023-12-07 13:00:00', '2023-12-07 17:00:00', 'Training'), -- Overlaps 13:00-14:00

-- Emp 103: Back-to-back (Allowed, not an overlap)
(103, '2023-12-07 08:00:00', '2023-12-07 12:00:00', 'Cashier'),
(103, '2023-12-07 12:00:00', '2023-12-07 16:00:00', 'Cashier');