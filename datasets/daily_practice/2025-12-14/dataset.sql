CREATE DATABASE IF NOT EXISTS daily_practice_20251214_schema;
USE daily_practice_20251214_schema;

-- This table logs every login event for users.
CREATE TABLE user_logins (
    login_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    login_timestamp DATETIME
);

INSERT INTO user_logins (user_id, login_timestamp) VALUES
-- User 101: Active regular user
(101, '2023-10-01 08:00:00'),
(101, '2023-11-01 08:00:00'),
(101, '2023-12-14 08:00:00'),

-- User 102: "Resurrected" user (Inactive for > 60 days, then logged in today)
(102, '2023-09-15 09:00:00'), -- Last login was 90 days ago
(102, '2023-12-14 09:00:00'), -- Returned today

-- User 103: Churned (Last login was long ago, no login today)
(103, '2023-09-01 10:00:00'),

-- User 104: Recently active (Gap is small)
(104, '2023-11-20 10:00:00'),
(104, '2023-12-14 10:00:00');