CREATE DATABASE IF NOT EXISTS daily_practice_20250729_schema;
USE daily_practice_20250729_schema;

CREATE TABLE player_logins (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    login_timestamp DATETIME,
    logout_timestamp DATETIME,
    region VARCHAR(10)
);

INSERT INTO player_logins (player_id, login_timestamp, logout_timestamp, region) VALUES
-- Player 101: Plays consistently
(101, '2023-12-01 10:00:00', '2023-12-01 11:30:00', 'NA'),
(101, '2023-12-02 10:15:00', '2023-12-02 12:00:00', 'NA'),
(101, '2023-12-03 11:00:00', '2023-12-03 12:30:00', 'NA'),
(101, '2023-12-05 09:00:00', '2023-12-05 10:00:00', 'NA'), -- Breaks streak

-- Player 102: Plays in long sessions, multiple times a day
(102, '2023-12-01 14:00:00', '2023-12-01 18:00:00', 'EU'),
(102, '2023-12-01 20:00:00', '2023-12-01 23:30:00', 'EU'),
(102, '2023-12-02 15:00:00', '2023-12-02 19:00:00', 'EU'),
(102, '2023-12-04 16:00:00', '2023-12-04 20:00:00', 'EU'), -- Skips a day

-- Player 103: Short, frequent sessions
(103, '2023-12-01 08:00:00', '2023-12-01 08:30:00', 'APAC'),
(103, '2023-12-01 12:00:00', '2023-12-01 12:30:00', 'APAC'),
(103, '2023-12-01 16:00:00', '2023-12-01 16:30:00', 'APAC'),
(103, '2023-12-02 09:00:00', '2023-12-02 09:30:00', 'APAC'),
(103, '2023-12-03 08:30:00', '2023-12-03 09:00:00', 'APAC'),
(103, '2023-12-04 10:00:00', '2023-12-04 10:30:00', 'APAC'), -- 4-day streak

-- Player 104: Plays across regions (VPN user?)
(104, '2023-12-02 11:00:00', '2023-12-02 12:00:00', 'NA'),
(104, '2023-12-03 13:00:00', '2023-12-03 14:00:00', 'EU'),
(104, '2023-12-04 15:00:00', '2023-12-04 16:00:00', 'APAC'),

-- Player 105: Another consistent player
(105, '2023-12-05 18:00:00', '2023-12-05 19:30:00', 'EU'),
(105, '2023-12-06 18:30:00', '2023-12-06 20:00:00', 'EU'),
(105, '2023-12-07 19:00:00', '2023-12-07 20:30:00', 'EU'); -- 3-day streak
