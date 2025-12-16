CREATE DATABASE IF NOT EXISTS daily_practice_20251213_schema;
USE daily_practice_20251213_schema;

-- This table logs user events within a mobile app.
CREATE TABLE app_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_type ENUM('ACCOUNT_CREATED', 'SEARCH', 'FILTER', 'ADD_TO_WISHLIST', 'LOGOUT'),
    event_timestamp DATETIME
);

INSERT INTO app_events (user_id, event_type, event_timestamp) VALUES
-- User 101: Power user, completes onboarding actions quickly
(101, 'ACCOUNT_CREATED', '2023-12-13 09:00:00'),
(101, 'SEARCH',            '2023-12-13 09:05:00'),
(101, 'FILTER',            '2023-12-13 09:10:00'),
(101, 'ADD_TO_WISHLIST',   '2023-12-13 09:15:00'),

-- User 102: Slow adopter, takes days
(102, 'ACCOUNT_CREATED', '2023-12-13 10:00:00'),
(102, 'SEARCH',            '2023-12-13 10:30:00'),
-- ... days pass
(102, 'FILTER',            '2023-12-15 09:00:00'),
(102, 'ADD_TO_WISHLIST',   '2023-12-15 09:05:00'),

-- User 103: Misses one step (Filter)
(103, 'ACCOUNT_CREATED', '2023-12-13 11:00:00'),
(103, 'SEARCH',            '2023-12-13 11:05:00'),
(103, 'ADD_TO_WISHLIST',   '2023-12-13 11:10:00'),

-- User 104: Does steps out of order (still counts if within time limit)
(104, 'ACCOUNT_CREATED', '2023-12-13 12:00:00'),
(104, 'ADD_TO_WISHLIST',   '2023-12-13 12:10:00'), -- Maybe navigated via link
(104, 'SEARCH',            '2023-12-13 12:15:00'),
(104, 'FILTER',            '2023-12-13 12:20:00');