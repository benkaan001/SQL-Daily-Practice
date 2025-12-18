CREATE DATABASE IF NOT EXISTS daily_practice_20251218_schema;
USE daily_practice_20251218_schema;

-- This table logs user interactions with promotional emails.
CREATE TABLE email_engagement (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    email_id INT,
    event_timestamp DATETIME,
    event_type ENUM('SENT', 'OPENED', 'CLICKED', 'UNSUBSCRIBED')
);

INSERT INTO email_engagement (user_id, email_id, event_timestamp, event_type) VALUES
-- User 101: Highly engaged, opens and clicks everything
(101, 1001, '2023-12-18 09:00:00', 'SENT'),
(101, 1001, '2023-12-18 09:05:00', 'OPENED'),
(101, 1001, '2023-12-18 09:10:00', 'CLICKED'),
(101, 1002, '2023-12-18 10:00:00', 'SENT'),
(101, 1002, '2023-12-18 10:02:00', 'OPENED'),

-- User 102: "Ghost" user, receives but never opens
(102, 1001, '2023-12-18 09:00:00', 'SENT'),
(102, 1002, '2023-12-18 10:00:00', 'SENT'),
(102, 1003, '2023-12-18 11:00:00', 'SENT'),

-- User 103: Opens but never clicks
(103, 1001, '2023-12-18 09:00:00', 'SENT'),
(103, 1001, '2023-12-18 09:30:00', 'OPENED'),
(103, 1002, '2023-12-18 10:00:00', 'SENT'),
(103, 1002, '2023-12-18 10:15:00', 'OPENED'),

-- User 104: Clicked without opening (Tracking pixel blocked?) - Counts as interaction
(104, 1001, '2023-12-18 09:00:00', 'SENT'),
(104, 1001, '2023-12-18 09:05:00', 'CLICKED'),

-- User 105: Unsubscribed after receiving
(105, 1001, '2023-12-18 09:00:00', 'SENT'),
(105, 1001, '2023-12-18 09:01:00', 'UNSUBSCRIBED');