CREATE DATABASE IF NOT EXISTS daily_practice_20250902_schema;
USE daily_practice_20250902_schema;

-- This table logs user actions in a collaborative document editing platform.
CREATE TABLE doc_collaboration_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    doc_id INT,
    user_id INT,
    session_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('DOC_CREATE', 'DOC_EDIT', 'COMMENT_ADD', 'DOC_DELETE', 'DOC_RESTORE'),
    details JSON
);

INSERT INTO doc_collaboration_events (doc_id, user_id, session_id, event_timestamp, event_type, details) VALUES
-- Scenario 1: Standard editing workflow
(101, 1, 'sess_A', '2023-11-01 10:00:00.000', 'DOC_CREATE', '{"title": "Project Plan"}'),
(101, 1, 'sess_A', '2023-11-01 10:05:00.000', 'DOC_EDIT', '{"chars_added": 250}'),
(101, 2, 'sess_B', '2023-11-01 11:00:00.000', 'COMMENT_ADD', '{"comment_id": 1, "text": "Looks great!"}'),
(101, 1, 'sess_A', '2023-11-01 11:02:00.000', 'COMMENT_ADD', '{"comment_id": 2, "reply_to": 1, "text": "Thanks!"}'),

-- Scenario 2: A deleted and later restored document
(102, 3, 'sess_C', '2023-11-02 09:00:00.000', 'DOC_CREATE', '{"title": "Meeting Notes"}'),
(102, 3, 'sess_C', '2023-11-02 09:10:00.000', 'DOC_DELETE', NULL),
(102, 3, 'sess_C', '2023-11-02 09:15:00.000', 'DOC_RESTORE', NULL),
(102, 4, 'sess_D', '2023-11-02 09:20:00.000', 'DOC_EDIT', '{"chars_added": 100}'),

-- Scenario 3: Real-time conflict - two users edit, one "wins"
(103, 5, 'sess_E', '2023-11-03 14:00:00.000', 'DOC_CREATE', '{"title": "Brainstorming"}'),
(103, 5, 'sess_E', '2023-11-03 14:01:00.000', 'DOC_EDIT', '{"chars_added": 50, "chars_deleted": 0}'),
(103, 6, 'sess_F', '2023-11-03 14:01:15.000', 'DOC_EDIT', '{"chars_added": 30, "chars_deleted": 10}'),
(103, 5, 'sess_E', '2023-11-03 14:01:30.000', 'DOC_EDIT', '{"chars_added": 10, "chars_deleted": 30}'), -- This edit overwrites user 6's changes

-- Scenario 4: Comment storm and resolution
(104, 7, 'sess_G', '2023-11-04 16:00:00.000', 'DOC_CREATE', '{"title": "Q4 Report Draft"}'),
(104, 8, 'sess_H', '2023-11-04 16:05:00.000', 'COMMENT_ADD', '{"comment_id": 3, "text": "Needs clarification on slide 5."}'),
(104, 7, 'sess_G', '2023-11-04 16:05:30.000', 'COMMENT_ADD', '{"comment_id": 4, "reply_to": 3, "text": "Which part?"}'),
(104, 8, 'sess_H', '2023-11-04 16:06:00.000', 'COMMENT_ADD', '{"comment_id": 5, "reply_to": 4, "text": "The revenue projection."}'),
(104, 7, 'sess_G', '2023-11-04 16:10:00.000', 'DOC_EDIT', '{"chars_added": 300}');
