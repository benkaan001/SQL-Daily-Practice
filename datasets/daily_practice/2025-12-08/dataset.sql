CREATE DATABASE IF NOT EXISTS daily_practice_20251208_schema;
USE daily_practice_20251208_schema;

-- Logs user posts.
CREATE TABLE user_posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_date DATE,
    content VARCHAR(100)
);

INSERT INTO user_posts (user_id, post_date, content) VALUES
-- User 101: Posted 3 days in a row (Streak!)
(101, '2023-12-01', 'Hello'),
(101, '2023-12-02', 'Updates'),
(101, '2023-12-03', 'Goodbye'),

-- User 102: Posted 2 days in a row (No Streak)
(102, '2023-12-01', 'Hi'),
(102, '2023-12-02', 'Bye'),

-- User 103: Gap in posting
(103, '2023-12-01', 'Start'),
(103, '2023-12-03', 'End');