CREATE DATABASE IF NOT EXISTS daily_practice_20260518_schema;
USE daily_practice_20260518_schema;

-- Tracks individual cellular towers and their technical specifications.
CREATE TABLE cell_towers (
    tower_id INT PRIMARY KEY,
    tower_name VARCHAR(100),
    region VARCHAR(50),
    max_capacity INT -- Max simultaneous calls allowed
);

-- Logs every call handled by the network.
-- start_time and end_time represent the connection window.
CREATE TABLE call_logs (
    call_id INT PRIMARY KEY AUTO_INCREMENT,
    tower_id INT,
    user_id INT,
    start_time DATETIME(3),
    end_time DATETIME(3),
    call_status ENUM('COMPLETED', 'DROPPED', 'FAILED'),
    signal_strength_dbm INT -- Lower is better (e.g., -70 is better than -100)
);

INSERT INTO cell_towers (tower_id, tower_name, region, max_capacity) VALUES
(1, 'Downtown_01', 'North', 5),
(2, 'Suburban_East', 'East', 10),
(3, 'Industrial_Park', 'North', 8);

INSERT INTO call_logs (tower_id, user_id, start_time, end_time, call_status, signal_strength_dbm) VALUES
-- Tower 1: Concurrency and signal issues
(1, 1001, '2026-05-18 08:00:00.000', '2026-05-18 08:05:00.000', 'COMPLETED', -75),
(1, 1002, '2026-05-18 08:01:00.000', '2026-05-18 08:03:00.000', 'COMPLETED', -80),
(1, 1003, '2026-05-18 08:02:00.000', '2026-05-18 08:02:05.000', 'DROPPED', -110), -- Short call
(1, 1004, '2026-05-18 08:02:30.000', '2026-05-18 08:04:00.000', 'COMPLETED', -85),
(1, 1005, '2026-05-18 08:02:45.000', '2026-05-18 08:06:00.000', 'COMPLETED', -70),
(1, 1006, '2026-05-18 08:03:00.000', '2026-05-18 08:03:10.000', 'FAILED', NULL),

-- Tower 2: High duration, stable
(2, 2001, '2026-05-18 10:00:00.000', '2026-05-18 10:20:00.000', 'COMPLETED', -65),
(2, 2002, '2026-05-18 10:05:00.000', '2026-05-18 10:25:00.000', 'COMPLETED', -68),

-- User 3001: Roaming pattern
(1, 3001, '2026-05-18 12:00:00.000', '2026-05-18 12:02:00.000', 'COMPLETED', -72),
(3, 3001, '2026-05-18 12:04:00.000', '2026-05-18 12:06:00.000', 'COMPLETED', -70), -- Within 5 mins, diff tower

-- Tower 3: Multiple failures
(3, 4001, '2026-05-18 14:00:00.000', '2026-05-18 14:00:05.000', 'DROPPED', -105),
(3, 4002, '2026-05-18 14:05:00.000', '2026-05-18 14:05:08.000', 'DROPPED', -108),
(3, 4003, '2026-05-18 14:10:00.000', '2026-05-18 14:10:02.000', 'FAILED', NULL);