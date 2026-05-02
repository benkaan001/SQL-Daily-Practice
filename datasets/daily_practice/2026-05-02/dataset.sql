CREATE DATABASE IF NOT EXISTS daily_practice_20260502_schema;
USE daily_practice_20260502_schema;

-- This table logs combat events in an action RPG game.
CREATE TABLE combat_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('ATTACK_LANDED', 'DAMAGE_TAKEN'),
    combo_points INT -- The score awarded for an attack. 0 for taking damage.
);

INSERT INTO combat_logs (player_id, event_timestamp, event_type, combo_points) VALUES
-- Player 101: Builds a combo of 25, takes damage (reset), then builds a combo of 35. (Max = 35)
(101, '2026-05-02 10:00:00.000', 'ATTACK_LANDED', 10),
(101, '2026-05-02 10:00:02.000', 'ATTACK_LANDED', 15),
(101, '2026-05-02 10:00:05.000', 'DAMAGE_TAKEN', 0),
(101, '2026-05-02 10:00:10.000', 'ATTACK_LANDED', 5),
(101, '2026-05-02 10:00:12.000', 'ATTACK_LANDED', 10),
(101, '2026-05-02 10:00:15.000', 'ATTACK_LANDED', 20),

-- Player 102: Constantly interrupted. (Max = 10)
(102, '2026-05-02 10:05:00.000', 'ATTACK_LANDED', 10),
(102, '2026-05-02 10:05:03.000', 'DAMAGE_TAKEN', 0),
(102, '2026-05-02 10:05:05.000', 'DAMAGE_TAKEN', 0),
(102, '2026-05-02 10:05:10.000', 'ATTACK_LANDED', 10),

-- Player 103: Flawless victory! No damage taken. (Max = 50)
(103, '2026-05-02 10:10:00.000', 'ATTACK_LANDED', 10),
(103, '2026-05-02 10:10:02.000', 'ATTACK_LANDED', 15),
(103, '2026-05-02 10:10:04.000', 'ATTACK_LANDED', 25),

-- Player 104: Takes a beating, never lands an attack. (Max = 0)
(104, '2026-05-02 10:15:00.000', 'DAMAGE_TAKEN', 0),
(104, '2026-05-02 10:15:02.000', 'DAMAGE_TAKEN', 0);