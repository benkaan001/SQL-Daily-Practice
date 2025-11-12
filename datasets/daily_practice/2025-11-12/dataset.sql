CREATE DATABASE IF NOT EXISTS daily_practice_20251112_schema;
USE daily_practice_20251112_schema;

-- This table logs the state of servers. A new log is written only when the state changes.
CREATE TABLE server_state_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    server_id VARCHAR(50),
    log_timestamp DATETIME(3),
    state ENUM('RUNNING', 'STOPPED', 'REBOOTING', 'ERROR')
);

INSERT INTO server_state_logs (server_id, log_timestamp, state) VALUES
-- Server 101: A standard cycle
('server-101', '2023-11-20 09:00:00.000', 'RUNNING'),
('server-101', '2023-11-20 14:30:00.000', 'STOPPED'),
('server-101', '2023-11-21 08:00:00.000', 'RUNNING'),
('server-101', '2023-11-21 17:00:00.000', 'STOPPED'),

-- Server 102: Flaps into an error state
('server-102', '2023-11-20 10:00:00.000', 'RUNNING'),
('server-102', '2023-11-20 10:05:00.000', 'REBOOTING'),
('server-102', '2023-11-20 10:07:00.000', 'RUNNING'),
('server-102', '2023-11-20 10:10:00.000', 'ERROR'),
('server-102', '2023-11-20 10:12:00.000', 'REBOOTING'),
('server-102', '2023-11-20 10:14:00.000', 'RUNNING'),

-- Server 103: Starts and stays running
('server-103', '2023-11-22 09:00:00.000', 'RUNNING'),

-- Server 101: Comes back online
('server-101', '2023-11-22 09:30:00.000', 'RUNNING');