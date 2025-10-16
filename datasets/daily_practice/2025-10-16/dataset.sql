CREATE DATABASE IF NOT EXISTS daily_practice_20251016_schema;
USE daily_practice_20251016_schema;

-- This table logs periodic heartbeat signals from IoT devices.
CREATE TABLE device_heartbeats (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    device_id VARCHAR(50),
    event_timestamp DATETIME(3),
    status ENUM('ONLINE', 'REBOOTING'),
    firmware_version VARCHAR(20)
);

INSERT INTO device_heartbeats (device_id, event_timestamp, status, firmware_version) VALUES
-- Device D-001: Goes offline for a while
('D-001', '2023-10-15 10:00:00.000', 'ONLINE', 'v1.1.0'),
('D-001', '2023-10-15 10:05:00.000', 'ONLINE', 'v1.1.0'),
-- 15-minute gap here, indicating it went offline
('D-001', '2023-10-15 10:20:00.000', 'ONLINE', 'v1.1.0'),
('D-001', '2023-10-15 10:25:00.000', 'ONLINE', 'v1.1.0'),

-- Device D-002: Stable, then goes offline and reboots with a new firmware
('D-002', '2023-10-15 11:00:00.000', 'ONLINE', 'v2.0.1'),
('D-002', '2023-10-15 11:05:00.000', 'ONLINE', 'v2.0.1'),
('D-002', '2023-10-15 11:10:00.000', 'ONLINE', 'v2.0.1'),
-- Long gap here
('D-002', '2023-10-15 11:45:00.000', 'REBOOTING', 'v2.1.0'),
('D-002', '2023-10-15 11:50:00.000', 'ONLINE', 'v2.1.0'),

-- Device D-003: Stable connection, no gaps
('D-003', '2023-10-15 12:00:00.000', 'ONLINE', 'v1.5.0'),
('D-003', '2023-10-15 12:05:00.000', 'ONLINE', 'v1.5.0'),
('D-003', '2023-10-15 12:10:00.000', 'ONLINE', 'v1.5.0'),
('D-003', '2023-10-15 12:15:00.000', 'ONLINE', 'v1.5.0'),

-- Device D-004: Another device that goes offline
('D-004', '2023-10-15 13:00:00.000', 'ONLINE', 'v3.0.0'),
('D-004', '2023-10-15 13:05:00.000', 'ONLINE', 'v3.0.0'),
-- 30-minute gap
('D-004', '2023-10-15 13:35:00.000', 'ONLINE', 'v3.0.0');
