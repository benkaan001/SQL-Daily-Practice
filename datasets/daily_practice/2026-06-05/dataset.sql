CREATE DATABASE IF NOT EXISTS daily_practice_20260605_schema;
USE daily_practice_20260605_schema;

CREATE TABLE network_connections (
    connection_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    tower_id INT,
    tower_name VARCHAR(100),
    start_time DATETIME(3),
    end_time DATETIME(3),
    signal_strength_dbm INT,
    call_status ENUM('COMPLETED','DROPPED','FAILED')
);

INSERT INTO network_connections (user_id, tower_id, tower_name, start_time, end_time, signal_strength_dbm, call_status) VALUES
(1001, 1, 'Downtown_01', '2026-06-05 08:00:00.000', '2026-06-05 08:05:00.000', -74, 'COMPLETED'),
(1002, 1, 'Downtown_01', '2026-06-05 08:01:30.000', '2026-06-05 08:03:00.000', -81, 'COMPLETED'),
(5001, 2, 'Suburban_East', '2026-06-05 09:55:00.000', '2026-06-05 10:10:00.000', -68, 'COMPLETED'),
(3001, 1, 'Downtown_01', '2026-06-05 12:00:00.000', '2026-06-05 12:06:00.000', -72, 'COMPLETED'),
(3001, 3, 'Airport_West', '2026-06-05 12:04:00.000', '2026-06-05 12:08:00.000', -69, 'COMPLETED'),
(5001, 3, 'Airport_West', '2026-06-05 10:00:00.000', '2026-06-05 10:05:00.000', -65, 'COMPLETED'),
(5001, 2, 'Suburban_East', '2026-06-05 10:05:00.000', '2026-06-05 10:15:00.000', -64, 'COMPLETED'),
(7001, 4, 'Industrial_Park', '2026-06-05 11:00:00.000', '2026-06-05 11:10:00.000', -86, 'DROPPED');