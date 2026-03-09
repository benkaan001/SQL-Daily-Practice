CREATE DATABASE IF NOT EXISTS daily_practice_20260306_schema;
USE daily_practice_20260306_schema;

-- This table logs the match history and outcomes for players in an online game.
CREATE TABLE match_history (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    match_date DATETIME,
    outcome ENUM('WIN', 'LOSS', 'DRAW')
);

INSERT INTO match_history (player_id, match_date, outcome) VALUES
-- Player 101: Has a streak of 3, a loss, then a streak of 4
(101, '2026-03-01 10:00:00', 'WIN'),
(101, '2026-03-01 14:00:00', 'WIN'),
(101, '2026-03-02 09:00:00', 'WIN'),   -- Streak of 3
(101, '2026-03-02 15:00:00', 'LOSS'),  -- Streak broken
(101, '2026-03-03 10:00:00', 'WIN'),
(101, '2026-03-04 11:00:00', 'WIN'),
(101, '2026-03-04 16:00:00', 'WIN'),
(101, '2026-03-05 09:00:00', 'WIN'),   -- Streak of 4 (Longest)
(101, '2026-03-05 20:00:00', 'DRAW'),  -- Streak broken

-- Player 102: Alternating wins and losses (Longest streak is 1)
(102, '2026-03-01 11:00:00', 'LOSS'),
(102, '2026-03-02 12:00:00', 'WIN'),
(102, '2026-03-03 13:00:00', 'LOSS'),
(102, '2026-03-04 14:00:00', 'WIN'),

-- Player 103: Undefeated (Longest streak is 5)
(103, '2026-03-01 08:00:00', 'WIN'),
(103, '2026-03-02 08:00:00', 'WIN'),
(103, '2026-03-03 08:00:00', 'WIN'),
(103, '2026-03-04 08:00:00', 'WIN'),
(103, '2026-03-05 08:00:00', 'WIN'),

-- Player 104: Has never won a game (Longest streak is 0)
(104, '2026-03-01 19:00:00', 'LOSS'),
(104, '2026-03-02 20:00:00', 'LOSS'),
(104, '2026-03-05 21:00:00', 'DRAW');