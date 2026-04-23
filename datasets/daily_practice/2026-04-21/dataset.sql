CREATE DATABASE IF NOT EXISTS daily_practice_20260421_schema;
USE daily_practice_20260421_schema;

-- This table logs every time a user logs into the application.
-- Users can log in multiple times a day or month.
CREATE TABLE user_logins (
    login_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    login_date DATE
);

INSERT INTO user_logins (user_id, login_date) VALUES
-- User 101: Active Jan, Feb, Mar (Consistently Retained)
(101, '2026-01-15'), 
(101, '2026-02-10'), 
(101, '2026-03-05'),
(101, '2026-03-20'),

-- User 102: Active Jan, skips Feb, returns Mar (Resurrected)
(102, '2026-01-20'), 
(102, '2026-03-12'),

-- User 103: Active Feb, skips Mar (Churned in March)
(103, '2026-02-05'),

-- User 104: First seen in Mar (New)
(104, '2026-03-01'),

-- User 105: Active Jan, skips Feb, skips Mar (Already churned, should be ignored for March analysis)
(105, '2026-01-25'),

-- User 106: First seen in Feb, active Mar (Retained)
(106, '2026-02-28'), 
(106, '2026-03-15');