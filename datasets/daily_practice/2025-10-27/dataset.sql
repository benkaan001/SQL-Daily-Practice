CREATE DATABASE IF NOT EXISTS daily_practice_20251027_schema;
USE daily_practice_20251027_schema;

-- This table logs player progress through different levels in a game, including attempts and completion status.
CREATE TABLE game_level_attempts (
    attempt_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    level_id INT,
    attempt_start_timestamp DATETIME(3),
    attempt_end_timestamp DATETIME(3),
    outcome ENUM('COMPLETED', 'FAILED', 'QUIT'),
    score INT -- NULL if outcome is not 'COMPLETED'
);

INSERT INTO game_level_attempts (player_id, level_id, attempt_start_timestamp, attempt_end_timestamp, outcome, score) VALUES
-- Player 101: Completes levels 1, 2, then fails 3, quits 3, then completes 3
(101, 1, '2023-11-10 09:00:00.000', '2023-11-10 09:05:00.000', 'COMPLETED', 1500),
(101, 2, '2023-11-10 09:06:00.000', '2023-11-10 09:15:00.000', 'COMPLETED', 2200),
(101, 3, '2023-11-10 09:16:00.000', '2023-11-10 09:20:00.000', 'FAILED', NULL),
(101, 3, '2023-11-10 09:21:00.000', '2023-11-10 09:22:00.000', 'QUIT', NULL),
(101, 3, '2023-11-10 09:25:00.000', '2023-11-10 09:35:00.000', 'COMPLETED', 1800),

-- Player 102: Completes level 1, fails level 2 multiple times, then completes level 2
(102, 1, '2023-11-11 10:00:00.000', '2023-11-11 10:08:00.000', 'COMPLETED', 1200),
(102, 2, '2023-11-11 10:10:00.000', '2023-11-11 10:15:00.000', 'FAILED', NULL),
(102, 2, '2023-11-11 10:16:00.000', '2023-11-11 10:20:00.000', 'FAILED', NULL),
(102, 2, '2023-11-11 10:22:00.000', '2023-11-11 10:35:00.000', 'COMPLETED', 1900),

-- Player 103: Completes level 1 quickly, but never attempts level 2
(103, 1, '2023-11-12 11:00:00.000', '2023-11-12 11:03:00.000', 'COMPLETED', 1600),

-- Player 104: Fails level 1 multiple times, then completes it, then completes level 2
(104, 1, '2023-11-12 14:00:00.000', '2023-11-12 14:04:00.000', 'FAILED', NULL),
(104, 1, '2023-11-12 14:05:00.000', '2023-11-12 14:10:00.000', 'FAILED', NULL),
(104, 1, '2023-11-12 14:11:00.000', '2023-11-12 14:20:00.000', 'COMPLETED', 1100),
(104, 2, '2023-11-12 14:22:00.000', '2023-11-12 14:35:00.000', 'COMPLETED', 2100),

-- Player 101: Plays level 1 again later
(101, 1, '2023-11-15 15:00:00.000', '2023-11-15 15:04:00.000', 'COMPLETED', 1700);
