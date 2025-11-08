CREATE DATABASE IF NOT EXISTS daily_practice_20251108_schema;
USE daily_practice_20251108_schema;

-- This table logs periodic health checks from servers in a data center.
CREATE TABLE server_health_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    server_id VARCHAR(50),
    log_timestamp DATETIME(3),
    cpu_usage_percent DECIMAL(5, 2),
    memory_usage_gb DECIMAL(5, 2),
    total_memory_gb DECIMAL(5, 2),
    status ENUM('ONLINE', 'OFFLINE', 'REBOOTING')
);

INSERT INTO server_health_logs (server_id, log_timestamp, cpu_usage_percent, memory_usage_gb, total_memory_gb, status) VALUES
-- Server 'web-01': Experiences a CPU spike
('web-01', '2023-11-08 10:00:00.000', 15.5, 4.2, 16.0, 'ONLINE'),
('web-01', '2023-11-08 10:01:00.000', 80.0, 4.5, 16.0, 'ONLINE'),
('web-01', '2023-11-08 10:02:00.000', 92.0, 5.0, 16.0, 'ONLINE'), -- 1st spike
('web-01', '2023-11-08 10:03:00.000', 91.0, 5.2, 16.0, 'ONLINE'), -- 2nd spike
('web-01', '2023-11-08 10:04:00.000', 93.0, 5.5, 16.0, 'ONLINE'), -- 3rd spike (triggers alert)
('web-01', '2023-11-08 10:05:00.000', 20.0, 4.8, 16.0, 'ONLINE'), -- Recovers

-- Server 'db-01': Experiences a memory leak
('db-01', '2023-11-08 11:00:00.000', 30.0, 12.0, 32.0, 'ONLINE'),
('db-01', '2023-11-08 11:01:00.000', 32.0, 29.0, 32.0, 'ONLINE'), -- 1st spike
('db-01', '2023-11-08 11:02:00.000', 31.0, 29.5, 32.0, 'ONLINE'), -- 2nd spike
('db-01', '2023-11-08 11:03:00.000', 33.0, 30.0, 32.0, 'ONLINE'), -- 3rd spike (triggers alert)
('db-01', '2023-11-08 11:04:00.000', 30.0, 30.5, 32.0, 'ONLINE'),
('db-01', '2023-11-08 11:05:00.000', 10.0, 8.0, 32.0, 'REBOOTING'), -- Reboots

-- Server 'app-01': Spike is too short
('app-01', '2023-11-08 14:00:00.000', 40.0, 8.0, 16.0, 'ONLINE'),
('app-01', '2023-11-08 14:01:00.000', 91.0, 9.0, 16.0, 'ONLINE'), -- 1st spike
('app-01', '2023-11-08 14:02:00.000', 95.0, 9.2, 16.0, 'ONLINE'), -- 2nd spike
('app-01', '2023-11-08 14:03:00.000', 45.0, 8.5, 16.0, 'ONLINE'), -- Recovers too fast
('app-01', '2023-11-08 14:04:00.000', 42.0, 8.2, 16.0, 'ONLINE'),

-- Server 'web-02': Goes offline
('web-02', '2023-11-08 15:00:00.000', 20.0, 3.0, 16.0, 'ONLINE'),
('web-02', '2023-11-08 15:01:00.000', 22.0, 3.1, 16.0, 'ONLINE'),
('web-02', '2023-11-08 15:02:00.000', 10.0, 2.9, 16.0, 'OFFLINE');