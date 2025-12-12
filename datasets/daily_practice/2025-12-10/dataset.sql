CREATE DATABASE IF NOT EXISTS daily_practice_20251210_schema;
USE daily_practice_20251210_schema;

-- Logs status changes of a server.
CREATE TABLE system_status_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    server_name VARCHAR(50),
    status ENUM('OK', 'WARNING', 'CRITICAL'),
    log_time DATETIME
);

INSERT INTO system_status_log (server_name, status, log_time) VALUES
-- Server A: Stable
('Server-A', 'OK', '2023-12-10 08:00:00'),
('Server-A', 'OK', '2023-12-10 09:00:00'),

-- Server B: Flapping (OK -> CRITICAL -> OK -> CRITICAL)
('Server-B', 'OK',       '2023-12-10 10:00:00'),
('Server-B', 'CRITICAL', '2023-12-10 10:05:00'),
('Server-B', 'OK',       '2023-12-10 10:10:00'),
('Server-B', 'CRITICAL', '2023-12-10 10:15:00'),

-- Server C: Escalating (OK -> WARNING -> CRITICAL) - Normal behavior
('Server-C', 'OK',       '2023-12-10 11:00:00'),
('Server-C', 'WARNING',  '2023-12-10 11:30:00'),
('Server-C', 'CRITICAL', '2023-12-10 12:00:00');