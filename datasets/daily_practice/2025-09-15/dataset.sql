CREATE DATABASE IF NOT EXISTS daily_practice_20250915_schema;
USE daily_practice_20250915_schema;

-- This table logs every time a user interacts with a specific feature in an application.
CREATE TABLE feature_usage (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    feature_name VARCHAR(50),
    event_timestamp DATETIME(3)
);

INSERT INTO feature_usage (user_id, feature_name, event_timestamp) VALUES
-- User 101: A 3-day streak, a break, then a 2-day streak.
(101, 'dashboard', '2023-09-01 10:00:00.000'),
(101, 'dashboard', '2023-09-02 11:00:00.000'),
(101, 'dashboard', '2023-09-02 11:05:00.000'), -- Multiple events on the same day
(101, 'reports',   '2023-09-03 12:00:00.000'),
(101, 'reports',   '2023-09-06 09:00:00.000'),
(101, 'dashboard', '2023-09-07 10:00:00.000'),

-- User 102: A solid 5-day streak, then a single day of activity later.
(102, 'search',    '2023-09-01 08:00:00.000'),
(102, 'filter',    '2023-09-02 08:30:00.000'),
(102, 'export',    '2023-09-03 09:00:00.000'),
(102, 'search',    '2023-09-04 09:30:00.000'),
(102, 'filter',    '2023-09-05 10:00:00.000'),
(102, 'dashboard', '2023-09-10 11:00:00.000'),

-- User 103: Sporadic usage, no streaks longer than 1 day.
(103, 'dashboard', '2023-09-01 14:00:00.000'),
(103, 'search',    '2023-09-05 15:00:00.000'),
(103, 'export',    '2023-09-10 16:00:00.000'),

-- User 104: A 2-day streak and a 3-day streak.
(104, 'reports',   '2023-09-02 13:00:00.000'),
(104, 'reports',   '2023-09-03 14:00:00.000'),
(104, 'dashboard', '2023-09-08 10:00:00.000'),
(104, 'search',    '2023-09-09 11:00:00.000'),
(104, 'filter',    '2023-09-10 12:00:00.000');
