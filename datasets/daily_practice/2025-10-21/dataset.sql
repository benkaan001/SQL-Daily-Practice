CREATE DATABASE IF NOT EXISTS daily_practice_20251021_schema;
USE daily_practice_20251021_schema;

-- This table logs player events in a real-time matchmaking system.
CREATE TABLE matchmaking_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('ENTER_QUEUE', 'MATCH_FOUND', 'MATCH_COMPLETE'),
    -- Details are null for queue events, but contain match info for match events.
    details JSON
);

INSERT INTO matchmaking_log (player_id, event_timestamp, event_type, details) VALUES
-- Player 101: Enters queue, finds a match quickly, and completes it.
(101, '2023-11-25 10:00:00.000', 'ENTER_QUEUE', NULL),
(101, '2023-11-25 10:01:30.000', 'MATCH_FOUND', JSON_OBJECT('match_id', 'match_A')),
(101, '2023-11-25 10:25:00.000', 'MATCH_COMPLETE', JSON_OBJECT('match_id', 'match_A', 'outcome', 'WIN')),

-- Player 102: Abandons the queue (no activity after entering).
(102, '2023-11-25 11:00:00.000', 'ENTER_QUEUE', NULL),

-- Player 103: Abandons the queue by re-entering it later.
(103, '2023-11-25 12:00:00.000', 'ENTER_QUEUE', NULL), -- This entry is abandoned.
(103, '2023-11-25 12:10:00.000', 'ENTER_QUEUE', NULL), -- Enters a new queue.
(103, '2023-11-25 12:11:00.000', 'MATCH_FOUND', JSON_OBJECT('match_id', 'match_B')),
(103, '2023-11-25 12:30:00.000', 'MATCH_COMPLETE', JSON_OBJECT('match_id', 'match_B', 'outcome', 'LOSS')),

-- Player 104: Finds a match, but just outside the 5-minute window (not an abandonment).
(104, '2023-11-25 13:00:00.000', 'ENTER_QUEUE', NULL),
(104, '2023-11-25 13:04:30.000', 'MATCH_FOUND', JSON_OBJECT('match_id', 'match_C')),

-- Player 105: Queue time is too long, so it's considered an abandonment.
(105, '2023-11-25 14:00:00.000', 'ENTER_QUEUE', NULL),
(105, '2023-11-25 14:06:00.000', 'MATCH_FOUND', JSON_OBJECT('match_id', 'match_D'));
