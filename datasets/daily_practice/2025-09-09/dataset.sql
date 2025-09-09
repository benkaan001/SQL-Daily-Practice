CREATE DATABASE IF NOT EXISTS daily_practice_20250909_schema;
USE daily_practice_20250909_schema;

-- This table logs every keycard swipe attempt at various doors in a secure facility.
CREATE TABLE door_access_logs (
    swipe_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    door_id VARCHAR(50),
    swipe_timestamp DATETIME(3),
    access_granted BOOLEAN
);

INSERT INTO door_access_logs (employee_id, door_id, swipe_timestamp, access_granted) VALUES
-- Normal entries
(101, 'Main_Entrance', '2023-12-18 08:00:00.000', true),
(102, 'Main_Entrance', '2023-12-18 08:01:05.000', true),
(101, 'Lab_A_Entrance', '2023-12-18 08:05:00.000', true),

-- Tailgating Scenario 1: Employee 103 follows 102 into the Server Room
(102, 'Server_Room', '2023-12-18 09:15:00.000', true),
(103, 'Server_Room', '2023-12-18 09:15:02.000', false), -- Denied swipe 2s after a granted one

-- Back to normal
(104, 'Main_Entrance', '2023-12-18 09:30:00.000', true),
(102, 'Server_Room', '2023-12-18 10:45:00.000', true),

-- Tailgating Scenario 2: Employee 101 follows 104 into the Break Room
(104, 'Break_Room', '2023-12-18 12:01:00.000', true),
(101, 'Break_Room', '2023-12-18 12:01:04.000', false), -- Denied swipe 4s after a granted one

-- Another normal entry, close in time but not a tailgating pattern (both granted)
(105, 'Main_Entrance', '2023-12-18 13:00:00.000', true),
(106, 'Main_Entrance', '2023-12-18 13:00:03.000', true),

-- A failed attempt that is not a tailgate (no preceding granted access)
(103, 'Restricted_Area', '2023-12-18 14:00:00.000', false);
