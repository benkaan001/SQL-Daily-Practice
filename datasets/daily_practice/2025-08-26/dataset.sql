CREATE DATABASE IF NOT EXISTS daily_practice_20250826_schema;
USE daily_practice_20250826_schema;

-- This table logs various events from an online multiplayer game.
CREATE TABLE game_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('LOGIN', 'LOGOUT', 'MATCH_START', 'MATCH_END', 'ITEM_PURCHASE', 'LEVEL_UP'),
    details JSON
);

INSERT INTO game_events (player_id, event_timestamp, event_type, details) VALUES
-- Player 101: Sessionization and churn risk example
(101, '2023-11-01 10:00:00.000', 'LOGIN', NULL),
(101, '2023-11-01 10:05:00.000', 'MATCH_START', '{"match_id": "m1"}'),
(101, '2023-11-01 10:25:00.000', 'MATCH_END', '{"match_id": "m1", "result": "win"}'),
(101, '2023-11-01 11:30:00.000', 'LOGOUT', NULL), -- End of first session
(101, '2023-11-20 18:00:00.000', 'LOGIN', NULL), -- Recent session
(101, '2023-11-20 18:05:00.000', 'MATCH_START', '{"match_id": "m50"}'),
(101, '2023-11-20 18:15:00.000', 'MATCH_END', '{"match_id": "m50", "result": "loss"}'),
(101, '2023-11-20 18:20:00.000', 'LOGOUT', NULL), -- Short recent session

-- Player 102: Level up and purchase behavior
(102, '2023-11-02 14:00:00.000', 'LOGIN', NULL),
(102, '2023-11-02 14:45:00.000', 'LEVEL_UP', '{"new_level": 5}'),
(102, '2023-11-02 14:50:00.000', 'ITEM_PURCHASE', '{"item_id": "sword_of_valor", "level_requirement": 5}'),
(102, '2023-11-02 16:00:00.000', 'LOGOUT', NULL),
(102, '2023-11-05 15:00:00.000', 'LOGIN', NULL),
(102, '2023-11-05 15:50:00.000', 'LEVEL_UP', '{"new_level": 6}'), -- Levels up, but doesn't buy anything immediately
(102, '2023-11-05 17:00:00.000', 'LOGOUT', NULL),

-- Player 103 & 104: Unfair matchmaking example
(103, '2023-11-03 19:00:00.000', 'MATCH_START', '{"match_id": "m5", "opponent_id": 104}'),
(104, '2023-11-03 19:00:00.000', 'MATCH_START', '{"match_id": "m5", "opponent_id": 103}'),
(103, '2023-11-03 19:20:00.000', 'MATCH_END', '{"match_id": "m5", "result": "loss", "winner_id": 104, "loser_id": 103, "winner_level": 15, "loser_level": 8}'), -- Unfair match
(104, '2023-11-03 19:20:00.000', 'MATCH_END', '{"match_id": "m5", "result": "win", "winner_id": 104, "loser_id": 103, "winner_level": 15, "loser_level": 8}'),
(103, '2023-11-03 19:30:00.000', 'MATCH_START', '{"match_id": "m6", "opponent_id": 105}'),
(103, '2023-11-03 19:55:00.000', 'MATCH_END', '{"match_id": "m6", "result": "win", "winner_id": 103, "loser_id": 105, "winner_level": 8, "loser_level": 8}'), -- Fair match

-- Player 105: Another level up example
(105, '2023-11-04 10:00:00.000', 'LEVEL_UP', '{"new_level": 5}'),
(105, '2023-11-04 10:02:00.000', 'ITEM_PURCHASE', '{"item_id": "shield_of_ages", "level_requirement": 5}');
