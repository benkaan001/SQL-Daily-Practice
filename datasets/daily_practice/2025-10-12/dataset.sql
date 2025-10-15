CREATE DATABASE IF NOT EXISTS daily_practice_20251012_schema;
USE daily_practice_20251012_schema;

-- This table logs user engagement with a video streaming platform's content previews.
CREATE TABLE video_engagement_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('PREVIEW_WATCH', 'FULL_WATCH'),
    content_id INT,
    preview_duration_seconds INT
);

INSERT INTO video_engagement_logs (user_id, session_id, event_timestamp, event_type, content_id, preview_duration_seconds) VALUES
-- User 101: Successful conversion within the same session
(101, 'sess_A', '2023-10-12 10:00:00.000', 'PREVIEW_WATCH', 1001, 30),
(101, 'sess_A', '2023-10-12 10:05:00.000', 'FULL_WATCH', 1001, NULL),

-- User 102: Watches a preview but never the full content
(102, 'sess_B', '2023-10-12 11:00:00.000', 'PREVIEW_WATCH', 1002, 45),

-- User 103: Watches full content directly without a preview
(103, 'sess_C', '2023-10-12 12:00:00.000', 'FULL_WATCH', 1001, NULL),

-- User 104: Watches a preview, but the full watch is too long after (more than 1 hour)
(104, 'sess_D', '2023-10-12 13:00:00.000', 'PREVIEW_WATCH', 1003, 60),
(104, 'sess_D', '2023-10-12 14:30:00.000', 'FULL_WATCH', 1003, NULL),

-- User 105: Multiple previews before a successful conversion
(105, 'sess_E', '2023-10-12 15:00:00.000', 'PREVIEW_WATCH', 1004, 20),
(105, 'sess_E', '2023-10-12 15:05:00.000', 'PREVIEW_WATCH', 1004, 25),
(105, 'sess_E', '2023-10-12 15:10:00.000', 'FULL_WATCH', 1004, NULL),

-- User 106: Watches a preview, then other content, then the original full content
(106, 'sess_F', '2023-10-12 16:00:00.000', 'PREVIEW_WATCH', 1005, 30),
(106, 'sess_F', '2023-10-12 16:02:00.000', 'FULL_WATCH', 9999, NULL), -- Different content
(106, 'sess_F', '2023-10-12 16:08:00.000', 'FULL_WATCH', 1005, NULL);
