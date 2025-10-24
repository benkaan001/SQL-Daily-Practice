CREATE DATABASE IF NOT EXISTS daily_practice_20251022_schema;
USE daily_practice_20251022_schema;

-- This table logs employee logins and logouts from various company devices.
CREATE TABLE employee_device_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    device_id VARCHAR(50),
    log_timestamp DATETIME(3),
    status ENUM('LOGIN', 'LOGOUT')
);

INSERT INTO employee_device_logs (employee_id, device_id, log_timestamp, status) VALUES
-- User 101: Logs in on Device A, then Device B (concurrent), then logs out of A, then B
(101, 'Device-A', '2023-10-22 09:00:00.000', 'LOGIN'),
(101, 'Device-B', '2023-10-22 09:15:00.000', 'LOGIN'),
(101, 'Device-A', '2023-10-22 11:00:00.000', 'LOGOUT'),
(101, 'Device-B', '2023-10-22 11:30:00.000', 'LOGOUT'),

-- User 102: Normal sequential usage
(102, 'Device-C', '2023-10-22 10:00:00.000', 'LOGIN'),
(102, 'Device-C', '2023-10-22 12:00:00.000', 'LOGOUT'),
(102, 'Device-D', '2023-10-22 13:00:00.000', 'LOGIN'),
(102, 'Device-D', '2023-10-22 15:00:00.000', 'LOGOUT'),

-- User 103: Logs in on E, then F (concurrent), then logs out of E, but F remains active
(103, 'Device-E', '2023-10-22 09:30:00.000', 'LOGIN'),
(103, 'Device-F', '2023-10-22 09:45:00.000', 'LOGIN'),
(103, 'Device-E', '2023-10-22 10:30:00.000', 'LOGOUT'),

-- User 104: Logs in on G, logs out, logs back in on G (no concurrency)
(104, 'Device-G', '2023-10-22 14:00:00.000', 'LOGIN'),
(104, 'Device-G', '2023-10-22 15:00:00.000', 'LOGOUT'),
(104, 'Device-G', '2023-10-22 15:05:00.000', 'LOGIN'),

-- User 101: A new concurrent session
(101, 'Device-A', '2023-10-22 14:00:00.000', 'LOGIN'),
(101, 'Device-B', '2023-10-22 14:05:00.000', 'LOGIN'),
(101, 'Device-B', '2023-10-22 14:30:00.000', 'LOGOUT'),
(101, 'Device-A', '2023-10-22 15:00:00.000', 'LOGOUT'),

-- User 103: Logs in on E while F is still active
(103, 'Device-E', '2023-10-22 11:00:00.000', 'LOGIN');

