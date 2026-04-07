CREATE DATABASE IF NOT EXISTS daily_practice_20260407_schema;
USE daily_practice_20260407_schema;

-- This table logs viewing sessions for a video streaming platform.
CREATE TABLE streaming_sessions (
    session_id VARCHAR(50) PRIMARY KEY,
    account_id INT,
    stream_start DATETIME,
    stream_end DATETIME
);

INSERT INTO streaming_sessions (session_id, account_id, stream_start, stream_end) VALUES
-- Account 101: Normal user (1 stream at a time)
('sess_01', 101, '2026-04-07 18:00:00', '2026-04-07 20:00:00'),
('sess_02', 101, '2026-04-07 20:30:00', '2026-04-07 22:00:00'),

-- Account 102: Password Sharer (Peak of 3 concurrent streams)
('sess_03', 102, '2026-04-07 19:00:00', '2026-04-07 21:00:00'), -- Stream A
('sess_04', 102, '2026-04-07 19:30:00', '2026-04-07 20:30:00'), -- Stream B (Overlaps A)
('sess_05', 102, '2026-04-07 20:00:00', '2026-04-07 20:15:00'), -- Stream C (Overlaps A & B -> 3 streams!)

-- Account 103: Family sharing (Peak of 2 streams, perfectly allowed)
('sess_06', 103, '2026-04-07 17:00:00', '2026-04-07 19:00:00'),
('sess_07', 103, '2026-04-07 18:00:00', '2026-04-07 20:00:00'),

-- Account 104: Heavy Password Sharer (Peak of 4 concurrent streams)
('sess_08', 104, '2026-04-07 14:00:00', '2026-04-07 16:00:00'),
('sess_09', 104, '2026-04-07 14:15:00', '2026-04-07 15:45:00'),
('sess_10', 104, '2026-04-07 14:30:00', '2026-04-07 15:30:00'),
('sess_11', 104, '2026-04-07 14:45:00', '2026-04-07 15:15:00'),

-- Account 105: Streams end precisely when another begins (Peak is 1)
('sess_12', 105, '2026-04-07 10:00:00', '2026-04-07 11:00:00'),
('sess_13', 105, '2026-04-07 11:00:00', '2026-04-07 12:00:00');