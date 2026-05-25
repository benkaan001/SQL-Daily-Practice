CREATE DATABASE IF NOT EXISTS daily_practice_20260525_schema;
USE daily_practice_20260525_schema;

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
(1001, 1, 'Downtown_01', '2026-05-25 08:00:00.000', '2026-05-25 08:05:00.000', -75, 'COMPLETED'),
(1002, 1, 'Downtown_01', '2026-05-25 08:01:30.000', '2026-05-25 08:03:00.000', -80, 'COMPLETED'),
(5001, 2, 'Suburban_East', '2026-05-25 10:05:00.000', '2026-05-25 10:15:00.000', -67, 'COMPLETED'),
(3001, 1, 'Downtown_01', '2026-05-25 12:00:00.000', '2026-05-25 12:05:00.000', -72, 'COMPLETED'),
(3001, 3, 'Airport_West', '2026-05-25 12:03:00.000', '2026-05-25 12:08:00.000', -71, 'COMPLETED'),
(5001, 3, 'Airport_West', '2026-05-25 10:10:00.000', '2026-05-25 10:20:00.000', -66, 'COMPLETED'),
(7001, 4, 'Industrial_Park', '2026-05-25 11:00:00.000', '2026-05-25 11:10:00.000', -85, 'DROPPED'),
(7001, 5, 'Harbor_South', '2026-05-25 11:10:00.000', '2026-05-25 11:20:00.000', -80, 'COMPLETED');