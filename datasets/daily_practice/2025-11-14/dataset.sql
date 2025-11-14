CREATE DATABASE IF NOT EXISTS daily_practice_20251114_schema;
USE daily_practice_20251114_schema;

-- This table logs every time a player earns an achievement in an MMO.
CREATE TABLE player_achievements (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    achievement_timestamp DATETIME,
    achievement_name VARCHAR(100)
);

INSERT INTO player_achievements (player_id, achievement_timestamp, achievement_name) VALUES
-- Player 101: Completes the full sequence in order, with other achievements in between.
(101, '2023-11-01 10:00:00', 'Goblin Puncher'),
(101, '2023-11-02 11:00:00', 'Troll Slayer'),        -- Step 1
(101, '2023-11-03 12:00:00', 'Griffin Tamer'),
(101, '2023-11-04 13:00:00', 'Dragon Whelpling'),   -- Step 2
(101, '2023-11-05 14:00:00', 'Lich Bane'),          -- Step 3 (Success)

-- Player 102: Does the sequence out of order.
(102, '2023-11-01 09:00:00', 'Troll Slayer'),        -- Step 1
(102, '2023-11-02 10:00:00', 'Lich Bane'),          -- Step 3 (Incorrect order)
(102, '2023-11-03 11:00:00', 'Dragon Whelpling'),   -- Step 2

-- Player 103: Completes the first two steps, but never the third.
(103, '2023-11-05 14:00:00', 'Troll Slayer'),        -- Step 1
(103, '2023-11-06 15:00:00', 'Dragon Whelpling'),   -- Step 2
(103, '2023-11-07 16:00:00', 'Goblin Puncher'),

-- Player 104: Completes the sequence, even with repeat achievements.
(104, '2023-11-10 18:00:00', 'Troll Slayer'),        -- Step 1
(104, '2023-11-11 19:00:00', 'Dragon Whelpling'),   -- Step 2
(104, '2023-11-12 20:00:00', 'Troll Slayer'),        -- (Repeat, should be ignored)
(104, '2023-11-13 21:00:00', 'Lich Bane'),          -- Step 3 (Success)

-- Player 105: Only completes the last step.
(105, '2023-11-15 10:00:00', 'Lich Bane');