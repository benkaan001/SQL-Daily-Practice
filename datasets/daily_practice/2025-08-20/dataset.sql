CREATE DATABASE IF NOT EXISTS daily_practice_20250820_schema;
USE daily_practice_20250820_schema;

-- This table logs user interactions with songs on a music streaming platform.
CREATE TABLE music_streaming_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(50),
    event_timestamp DATETIME(3),
    song_id INT,
    artist_id INT,
    event_type ENUM('PLAY', 'SKIP', 'LIKE', 'ADD_TO_PLAYLIST'),
    play_duration_seconds INT -- NULL for non-PLAY events
);

INSERT INTO music_streaming_events (user_id, session_id, event_timestamp, song_id, artist_id, event_type, play_duration_seconds) VALUES
-- User 101, Session A: Listens normally, likes a song, adds it to a playlist
('101', 'sess_A', '2023-12-15 10:00:00.000', 1001, 1, 'PLAY', 185),
('101', 'sess_A', '2023-12-15 10:03:05.000', 1002, 1, 'PLAY', 210),
('101', 'sess_A', '2023-12-15 10:06:35.000', 1002, 1, 'LIKE', NULL),
('101', 'sess_A', '2023-12-15 10:06:40.000', 1002, 1, 'ADD_TO_PLAYLIST', NULL),
('101', 'sess_A', '2023-12-15 10:06:45.000', 1003, 2, 'PLAY', 195),

-- User 102, Session B: Skips a lot
('102', 'sess_B', '2023-12-15 11:00:00.000', 2001, 3, 'PLAY', 15),
('102', 'sess_B', '2023-12-15 11:00:15.000', 2001, 3, 'SKIP', NULL),
('102', 'sess_B', '2023-12-15 11:00:16.000', 2002, 3, 'PLAY', 10),
('102', 'sess_B', '2023-12-15 11:00:26.000', 2002, 3, 'SKIP', NULL),
('102', 'sess_B', '2023-12-15 11:00:27.000', 1001, 1, 'PLAY', 185),

-- User 103, Session C: Likes a song but doesn't add to playlist
('103', 'sess_C', '2023-12-15 14:30:00.000', 1003, 2, 'PLAY', 195),
('103', 'sess_C', '2023-12-15 14:33:15.000', 1003, 2, 'LIKE', NULL),
('103', 'sess_C', '2023-12-15 14:33:20.000', 2001, 3, 'PLAY', 180),

-- User 101, Session D (New session): Listens to a song they previously liked
('101', 'sess_D', '2023-12-16 18:00:00.000', 1002, 1, 'PLAY', 210),
('101', 'sess_D', '2023-12-16 18:03:30.000', 1001, 1, 'PLAY', 185),

-- More data for skip rate anomaly
('104', 'sess_E', '2023-12-16 19:00:00.000', 3001, 4, 'PLAY', 200), -- Artist 4, normal song
('105', 'sess_F', '2023-12-16 19:05:00.000', 3001, 4, 'PLAY', 200),
('106', 'sess_G', '2023-12-16 19:10:00.000', 3002, 4, 'PLAY', 5),   -- Artist 4, high skip rate song
('106', 'sess_G', '2023-12-16 19:10:05.000', 3002, 4, 'SKIP', NULL),
('107', 'sess_H', '2023-12-16 19:15:00.000', 3002, 4, 'PLAY', 8),
('107', 'sess_H', '2023-12-16 19:15:08.000', 3002, 4, 'SKIP', NULL),
('108', 'sess_I', '2023-12-16 19:20:00.000', 3002, 4, 'PLAY', 210); -- One user listens all the way through
