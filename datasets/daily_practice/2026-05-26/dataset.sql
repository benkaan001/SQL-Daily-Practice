CREATE DATABASE IF NOT EXISTS daily_practice_20260526_schema;
USE daily_practice_20260526_schema;

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
(1001, 1, 'Downtown_01', '2026-05-26 07:00:00.000', '2026-05-26 07:10:00.000', -73, 'COMPLETED'),
(1002, 1, 'Downtown_01', '2026-05-26 07:05:00.000', '2026-05-26 07:15:00.000', -82, 'COMPLETED'),
(5001, 2, 'Suburban_East', '2026-05-26 09:00:00.000', '2026-05-26 09:20:00.000', -68, 'COMPLETED'),
(3001, 1, 'Downtown_01', '2026-05-26 11:30:00.000', '2026-05-26 11:40:00.000', -74, 'COMPLETED'),
(3001, 3, 'Airport_West', '2026-05-26 11:35:00.000', '2026-05-26 11:45:00.000', -70, 'COMPLETED'),
(5001, 3, 'Airport_West', '2026-05-26 09:15:00.000', '2026-05-26 09:25:00.000', -65, 'COMPLETED'),
(6001, 4, 'Industrial_Park', '2026-05-26 13:00:00.000', '2026-05-26 13:05:00.000', -90, 'DROPPED'),
(6001, 5, 'Harbor_South', '2026-05-26 13:05:00.000', '2026-05-26 13:15:00.000', -80, 'COMPLETED');