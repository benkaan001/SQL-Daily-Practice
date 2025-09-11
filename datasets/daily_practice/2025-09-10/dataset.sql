CREATE DATABASE IF NOT EXISTS daily_practice_20250910_schema;
USE daily_practice_20250910_schema;

-- This table logs the connectivity status changes for IoT devices in a smart home system.
CREATE TABLE device_connectivity_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    device_id VARCHAR(50),
    log_timestamp DATETIME(3),
    status ENUM('ONLINE', 'OFFLINE')
);

INSERT INTO device_connectivity_logs (device_id, log_timestamp, status) VALUES
-- Thermostat-A: Standard online/offline cycle
('Thermostat-A', '2023-12-20 00:00:00.000', 'ONLINE'),
('Thermostat-A', '2023-12-20 06:30:00.000', 'OFFLINE'),
('Thermostat-A', '2023-12-20 07:00:00.000', 'ONLINE'),
('Thermostat-A', '2023-12-20 18:00:00.000', 'OFFLINE'),
('Thermostat-A', '2023-12-20 20:00:00.000', 'ONLINE'), -- Stays online past midnight

-- Camera-B: Goes offline and stays offline for the day
('Camera-B', '2023-12-19 22:00:00.000', 'ONLINE'), -- Starts online from previous day
('Camera-B', '2023-12-20 01:00:00.000', 'OFFLINE'),
('Camera-B', '2023-12-21 02:00:00.000', 'ONLINE'), -- Comes back online the next day

-- SmartLock-C: A "flapping" device that connects and disconnects rapidly
('SmartLock-C', '2023-12-20 09:00:00.000', 'ONLINE'),
('SmartLock-C', '2023-12-20 09:01:00.000', 'OFFLINE'),
('SmartLock-C', '2023-12-20 09:02:00.000', 'ONLINE'),
('SmartLock-C', '2023-12-20 09:03:00.000', 'OFFLINE'),
('SmartLock-C', '2023-12-20 09:04:00.000', 'ONLINE'),
('SmartLock-C', '2023-12-20 10:00:00.000', 'OFFLINE'),

-- LightStrip-D: Comes online mid-day and stays online
('LightStrip-D', '2023-12-20 12:00:00.000', 'ONLINE');
