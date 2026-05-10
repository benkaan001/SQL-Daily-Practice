CREATE DATABASE IF NOT EXISTS daily_practice_20260510_schema;
USE daily_practice_20260510_schema;

-- This table logs user authentication attempts across the platform.
CREATE TABLE auth_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    ip_address VARCHAR(15),
    attempt_time DATETIME,
    status ENUM('SUCCESS', 'FAILED')
);

INSERT INTO auth_logs (ip_address, attempt_time, status) VALUES
-- Subnet 203.0.113.X (Fraudulent Subnet: 4 Distinct IPs, High Failure Rate)
('203.0.113.15', '2026-05-10 08:01:00', 'FAILED'),
('203.0.113.15', '2026-05-10 08:02:00', 'FAILED'),
('203.0.113.22', '2026-05-10 08:03:00', 'FAILED'),
('203.0.113.22', '2026-05-10 08:04:00', 'SUCCESS'),
('203.0.113.45', '2026-05-10 08:05:00', 'FAILED'),
('203.0.113.45', '2026-05-10 08:06:00', 'FAILED'),
('203.0.113.88', '2026-05-10 08:07:00', 'FAILED'),

-- Subnet 192.168.1.X (Healthy Subnet: 3 Distinct IPs, Mostly Success)
('192.168.1.10', '2026-05-10 09:00:00', 'SUCCESS'),
('192.168.1.11', '2026-05-10 09:05:00', 'SUCCESS'),
('192.168.1.12', '2026-05-10 09:10:00', 'FAILED'),
('192.168.1.12', '2026-05-10 09:11:00', 'SUCCESS'),
('192.168.1.10', '2026-05-10 09:15:00', 'SUCCESS'),

-- Subnet 10.0.5.X (Single Attacker: 1 IP, High Failure) -> Should be ignored
('10.0.5.55', '2026-05-10 10:01:00', 'FAILED'),
('10.0.5.55', '2026-05-10 10:02:00', 'FAILED'),
('10.0.5.55', '2026-05-10 10:03:00', 'FAILED'),
('10.0.5.55', '2026-05-10 10:04:00', 'FAILED'),
('10.0.5.55', '2026-05-10 10:05:00', 'FAILED'),

-- Subnet 172.16.50.X (Borderline Subnet: 3 IPs, Successes > Failures) -> Should be ignored
('172.16.50.2', '2026-05-10 11:00:00', 'SUCCESS'),
('172.16.50.3', '2026-05-10 11:05:00', 'FAILED'),
('172.16.50.3', '2026-05-10 11:06:00', 'SUCCESS'),
('172.16.50.4', '2026-05-10 11:10:00', 'FAILED'),
('172.16.50.4', '2026-05-10 11:11:00', 'SUCCESS');