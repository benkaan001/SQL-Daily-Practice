CREATE DATABASE IF NOT EXISTS daily_practice_20251019_schema;
USE daily_practice_20251019_schema;

-- This table logs player data for completed matches in a competitive online game.
CREATE TABLE game_matches (
    match_id INT,
    match_timestamp DATETIME(3),
    player_id INT,
    player_team ENUM('blue', 'red'),
    player_skill_rating INT, -- A numerical skill rating like MMR or Elo
    match_outcome ENUM('VICTORY', 'DEFEAT'),
    PRIMARY KEY (match_id, player_id)
);

INSERT INTO game_matches (match_id, match_timestamp, player_id, player_team, player_skill_rating, match_outcome) VALUES
-- Match 1: A balanced match, blue team wins.
(1, '2023-11-25 10:00:00.000', 101, 'blue', 1550, 'VICTORY'),
(1, '2023-11-25 10:00:00.000', 102, 'blue', 1450, 'VICTORY'),
(1, '2023-11-25 10:00:00.000', 201, 'red', 1520, 'DEFEAT'),
(1, '2023-11-25 10:00:00.000', 202, 'red', 1480, 'DEFEAT'),

-- Match 2: Unbalanced, higher-skilled red team wins. (Should be flagged)
(2, '2023-11-25 11:00:00.000', 103, 'blue', 1200, 'DEFEAT'),
(2, '2023-11-25 11:00:00.000', 104, 'blue', 1300, 'DEFEAT'),
(2, '2023-11-25 11:00:00.000', 203, 'red', 1500, 'VICTORY'),
(2, '2023-11-25 11:00:00.000', 204, 'red', 1450, 'VICTORY'),

-- Match 3: Unbalanced, but the lower-skilled team pulls off an upset win. (Should NOT be flagged)
(3, '2023-11-25 12:00:00.000', 105, 'blue', 1600, 'DEFEAT'),
(3, '2023-11-25 12:00:00.000', 106, 'blue', 1700, 'DEFEAT'),
(3, '2023-11-25 12:00:00.000', 205, 'red', 1350, 'VICTORY'),
(3, '2023-11-25 12:00:00.000', 206, 'red', 1400, 'VICTORY'),

-- Match 4: Another unbalanced match where the weaker blue team loses. (Should be flagged)
(4, '2023-11-25 13:00:00.000', 107, 'blue', 2100, 'DEFEAT'),
(4, '2023-11-25 13:00:00.000', 108, 'blue', 2200, 'DEFEAT'),
(4, '2023-11-25 13:00:00.000', 207, 'red', 2400, 'VICTORY'),
(4, '2023-11-25 13:00:00.000', 208, 'red', 2350, 'VICTORY'),

-- Match 5: A very close match, red team wins.
(5, '2023-11-25 14:00:00.000', 109, 'blue', 1800, 'DEFEAT'),
(5, '2023-11-25 14:00:00.000', 110, 'blue', 1850, 'DEFEAT'),
(5, '2023-11-25 14:00:00.000', 209, 'red', 1830, 'VICTORY'),
(5, '2023-11-25 14:00:00.000', 210, 'red', 1840, 'VICTORY');
