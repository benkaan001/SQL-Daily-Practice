CREATE DATABASE IF NOT EXISTS daily_practice_20251115_schema;
USE daily_practice_20251115_schema;

-- This table logs user activity in a mobile game.
-- 'EVENT_TYPE' = 'LEVEL_COMPLETE' means the user successfully finished a level.
-- 'EVENT_TYPE' = 'HIGH_SCORE_BEATEN' logs when a user's *new* score beats their *previous* high score for that level.
CREATE TABLE game_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    level_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('LEVEL_COMPLETE', 'HIGH_SCORE_BEATEN'),
    -- 'score' is only populated for 'HIGH_SCORE_BEATEN' events,
    -- representing the new high score.
    score INT
);

INSERT INTO game_logs (user_id, level_id, event_timestamp, event_type, score) VALUES
-- User 101: Completes level 1 (initial high score), then beats it.
(101, 1, '2023-11-10 09:00:00.000', 'LEVEL_COMPLETE', NULL),
(101, 1, '2023-11-10 09:00:00.000', 'HIGH_SCORE_BEATEN', 1500), -- This is their first score
(101, 1, '2023-11-11 10:30:00.000', 'LEVEL_COMPLETE', NULL),
(101, 1, '2023-11-11 10:30:00.000', 'HIGH_SCORE_BEATEN', 1800), -- Beats their old score

-- User 102: Completes level 1, but doesn't beat the score. Then completes level 2.
(102, 1, '2023-11-10 11:00:00.000', 'LEVEL_COMPLETE', NULL),
(102, 1, '2023-11-10 11:00:00.000', 'HIGH_SCORE_BEATEN', 2000), -- First score
(102, 1, '2023-11-10 11:30:00.000', 'LEVEL_COMPLETE', NULL), -- Score was < 2000, so no high score event
(102, 2, '2023-11-12 14:00:00.000', 'LEVEL_COMPLETE', NULL),
(102, 2, '2023-11-12 14:00:00.000', 'HIGH_SCORE_BEATEN', 500), -- First score for level 2

-- User 103: Completes level 1, but their high score event is delayed (not simultaneous)
(103, 1, '2023-11-11 09:30:00.000', 'LEVEL_COMPLETE', NULL),
(103, 1, '2023-11-11 09:30:05.000', 'HIGH_SCORE_BEATEN', 900), -- First score

-- User 104: Completes level 1, but fails to set a high score (implies score was 0 or a bug).
-- Then, completes level 1 again, finally setting a high score.
(104, 1, '2023-11-13 13:00:00.000', 'LEVEL_COMPLETE', NULL), -- No high score event
(104, 1, '2023-11-13 13:30:00.000', 'LEVEL_COMPLETE', NULL),
(104, 1, '2023-11-13 13:30:00.000', 'HIGH_SCORE_BEATEN', 1100); -- This is their first *recorded* high score