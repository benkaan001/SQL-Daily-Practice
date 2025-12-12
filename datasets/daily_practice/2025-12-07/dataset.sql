CREATE DATABASE IF NOT EXISTS daily_practice_20251207_schema;
USE daily_practice_20251207_schema;

CREATE TABLE traffic_light_logs (
    sensor_id INT,
    log_time DATETIME,
    signal_color ENUM('RED', 'YELLOW', 'GREEN')
);

INSERT INTO traffic_light_logs (sensor_id, log_time, signal_color) VALUES
-- Sensor 1: Normal cycle
(1, '2023-12-07 08:00:00', 'RED'),
(1, '2023-12-07 08:02:00', 'GREEN'),

-- Sensor 2: Stuck on RED
(2, '2023-12-07 09:00:00', 'RED'),
(2, '2023-12-07 09:05:00', 'RED'),
(2, '2023-12-07 09:10:00', 'RED');