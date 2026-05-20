CREATE DATABASE IF NOT EXISTS daily_practice_20260420_schema;
USE daily_practice_20260420_schema;

CREATE TABLE network_connections (
    connection_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    tower_id INT,
    tower_name VARCHAR(100),
    start_time DATETIME(3),
    end_time DATETIME(3),
    signal_strength_dbm INT,
    call_status ENUM('COMPLETED', 'DROPPED', 'FAILED')
);

INSERT INTO network_connections (user_id, tower_id, tower_name, start_time, end_time, signal_strength_dbm, call_status) VALUES
(1001, 1, 'Downtown_01', '2026-04-20 08:00:00.000', '2026-04-20 08:05:00.000', -75, 'COMPLETED'),
(1002, 1, 'Downtown_01', '2026-04-20 08:01:00.000', '2026-04-20 08:03:30.000', -80, 'COMPLETED'),
(1003, 1, 'Downtown_01', '2026-04-20 08:02:00.000', '2026-04-20 08:02:05.000', -112, 'DROPPED'),
(1004, 1, 'Downtown_01', '2026-04-20 08:02:30.000', '2026-04-20 08:05:00.000', -85, 'COMPLETED'),
(1005, 1, 'Downtown_01', '2026-04-20 08:02:45.000', '2026-04-20 08:06:00.000', -70, 'COMPLETED'),
(1006, 1, 'Downtown_01', '2026-04-20 08:03:00.000', '2026-04-20 08:03:10.000', NULL, 'FAILED'),

(2001, 2, 'Suburban_East', '2026-04-20 10:00:00.000', '2026-04-20 10:20:00.000', -65, 'COMPLETED'),
(2002, 2, 'Suburban_East', '2026-04-20 10:05:00.000', '2026-04-20 10:25:00.000', -68, 'COMPLETED'),

(3001, 1, 'Downtown_01', '2026-04-20 12:00:00.000', '2026-04-20 12:05:00.000', -72, 'COMPLETED'),
(3001, 3, 'Airport_West', '2026-04-20 12:04:00.000', '2026-04-20 12:09:00.000', -71, 'COMPLETED'),
(5001, 2, 'Suburban_East', '2026-04-20 10:05:00.000', '2026-04-20 10:15:00.000', -67, 'COMPLETED'),
(5001, 3, 'Airport_West', '2026-04-20 10:05:00.000', '2026-04-20 10:10:00.000', -66, 'COMPLETED');