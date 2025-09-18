CREATE DATABASE IF NOT EXISTS daily_practice_20250917_schema;
USE daily_practice_20250917_schema;

-- This table logs events from a content moderation system.
-- An automated system first flags content, which can then be reviewed by a human.
CREATE TABLE moderation_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    content_id INT,
    event_timestamp DATETIME(3),
    actor_id VARCHAR(50), -- 'auto-mod' or a human moderator ID like 'mod-101'
    event_type ENUM('AUTO_FLAG', 'MANUAL_REVIEW'),
    decision VARCHAR(50), -- e.g., 'FLAG_FOR_REVIEW_REJECT', 'FLAG_FOR_REVIEW_APPROVE', 'APPROVE', 'REJECT'
    details JSON
);

INSERT INTO moderation_events (content_id, event_timestamp, actor_id, event_type, decision, details) VALUES
-- Content 101: Auto-flag reject, human agrees
(101, '2023-10-01 10:00:00.000', 'auto-mod', 'AUTO_FLAG', 'FLAG_FOR_REVIEW_REJECT', '{"reason": "spam"}'),
(101, '2023-10-01 10:05:00.000', 'mod-101', 'MANUAL_REVIEW', 'REJECT', '{"initial_flag": "REJECT"}'),

-- Content 102: Auto-flag reject, human overturns to approve
(102, '2023-10-01 11:00:00.000', 'auto-mod', 'AUTO_FLAG', 'FLAG_FOR_REVIEW_REJECT', '{"reason": "hate_speech"}'),
(102, '2023-10-01 11:15:00.000', 'mod-102', 'MANUAL_REVIEW', 'APPROVE', '{"initial_flag": "REJECT", "notes": "False positive"}'),

-- Content 103: Auto-flag approve, human agrees
(103, '2023-10-01 12:00:00.000', 'auto-mod', 'AUTO_FLAG', 'FLAG_FOR_REVIEW_APPROVE', '{"reason": "low_risk"}'),
(103, '2023-10-01 12:02:00.000', 'mod-101', 'MANUAL_REVIEW', 'APPROVE', '{"initial_flag": "APPROVE"}'),

-- Content 104: Auto-flagged but never reviewed by a human
(104, '2023-10-02 09:00:00.000', 'auto-mod', 'AUTO_FLAG', 'FLAG_FOR_REVIEW_REJECT', '{"reason": "spam"}'),

-- Content 105: Submitted directly for human review (should be ignored by the query)
(105, '2023-10-02 10:00:00.000', 'mod-103', 'MANUAL_REVIEW', 'REJECT', '{"initial_flag": null, "notes": "Direct submission"}'),

-- Content 106: Another auto-flag reject, human agrees (fast review)
(106, '2023-10-02 14:00:00.000', 'auto-mod', 'AUTO_FLAG', 'FLAG_FOR_REVIEW_REJECT', '{"reason": "hate_speech"}'),
(106, '2023-10-02 14:01:30.000', 'mod-101', 'MANUAL_REVIEW', 'REJECT', '{"initial_flag": "REJECT"}'),

-- Content 107: Another auto-flag reject, human overturns (slow review)
(107, '2023-10-03 15:00:00.000', 'auto-mod', 'AUTO_FLAG', 'FLAG_FOR_REVIEW_REJECT', '{"reason": "spam"}'),
(107, '2023-10-03 15:25:00.000', 'mod-103', 'MANUAL_REVIEW', 'APPROVE', '{"initial_flag": "REJECT", "notes": "Context matters"}');
