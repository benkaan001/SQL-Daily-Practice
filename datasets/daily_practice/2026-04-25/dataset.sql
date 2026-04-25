CREATE DATABASE IF NOT EXISTS daily_practice_20260425_schema;
USE daily_practice_20260425_schema;

-- This table logs every time a user logs into the application.
-- Users may log in multiple times a day.
CREATE TABLE user_logins (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    login_timestamp DATETIME
);

INSERT INTO user_logins (user_id, login_timestamp) VALUES
-- User 101: Perfect 5-day streak leading up to today
(101, '2026-04-21 08:00:00'),
(101, '2026-04-22 09:30:00'),
(101, '2026-04-23 18:45:00'),
(101, '2026-04-24 12:15:00'),
(101, '2026-04-25 10:00:00'),
(101, '2026-04-25 22:00:00'), -- Multiple logins today (Should count as 1 day)

-- User 102: Missed the 23rd, so current streak is only 2 days (24th and 25th)
(102, '2026-04-20 11:00:00'),
(102, '2026-04-21 11:00:00'),
(102, '2026-04-22 11:00:00'),
(102, '2026-04-24 14:00:00'),
(102, '2026-04-25 09:00:00'),

-- User 103: Had a streak, but missed today (25th). Current Streak is 0.
(103, '2026-04-22 16:00:00'),
(103, '2026-04-23 16:00:00'),
(103, '2026-04-24 16:00:00'),

-- User 104: First day logging in. Streak is 1.
(104, '2026-04-25 19:00:00'),

-- User 105: Inactive for days. Streak is 0.
(105, '2026-04-10 12:00:00');