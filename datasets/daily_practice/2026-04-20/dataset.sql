CREATE DATABASE IF NOT EXISTS daily_practice_20260420_schema;
USE daily_practice_20260420_schema;

-- This table holds the registered players for an online chess platform.
CREATE TABLE players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50)
);

-- This table logs the outcome of every match. 
-- Because chess is asymmetrical, players are recorded by the color they played.
CREATE TABLE chess_matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    white_player_id INT,
    black_player_id INT,
    match_date DATETIME,
    result ENUM('WHITE_WIN', 'BLACK_WIN', 'DRAW')
);

INSERT INTO players (player_id, player_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana'),
(5, 'Evan'); -- Evan registered but hasn't played any games yet.

INSERT INTO chess_matches (white_player_id, black_player_id, match_date, result) VALUES
-- Match 1: Alice (White) vs Bob (Black) -> Alice wins
(1, 2, '2026-04-20 09:00:00', 'WHITE_WIN'),

-- Match 2: Charlie (White) vs Alice (Black) -> Alice wins
(3, 1, '2026-04-20 10:00:00', 'BLACK_WIN'),

-- Match 3: Bob (White) vs Diana (Black) -> Draw
(2, 4, '2026-04-20 11:00:00', 'DRAW'),

-- Match 4: Alice (White) vs Diana (Black) -> Draw
(1, 4, '2026-04-20 12:00:00', 'DRAW'),

-- Match 5: Bob (White) vs Charlie (Black) -> Bob wins
(2, 3, '2026-04-20 13:00:00', 'WHITE_WIN'),

-- Match 6: Diana (White) vs Charlie (Black) -> Charlie wins
(4, 3, '2026-04-20 14:00:00', 'BLACK_WIN'),

-- Match 7: Alice (White) vs Charlie (Black) -> Alice wins
(1, 3, '2026-04-20 15:00:00', 'WHITE_WIN');