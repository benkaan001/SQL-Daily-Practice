CREATE DATABASE IF NOT EXISTS daily_practice_20251206_schema;
USE daily_practice_20251206_schema;

-- Raw clickstream data. We need to reconstruct user sessions from this stream.
CREATE TABLE clickstream (
    click_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    timestamp DATETIME,
    url VARCHAR(255)
);

INSERT INTO clickstream (user_id, timestamp, url) VALUES
-- User 101: One continuous session
(101, '2023-12-06 08:00:00', '/home'),
(101, '2023-12-06 08:15:00', '/products'),
(101, '2023-12-06 08:29:00', '/checkout'), -- < 30 mins gap

-- User 102: Two distinct sessions (gap > 30 mins)
(102, '2023-12-06 09:00:00', '/home'),
(102, '2023-12-06 09:05:00', '/blog'),
-- 55 minute gap here --
(102, '2023-12-06 10:00:00', '/home'), -- New session starts
(102, '2023-12-06 10:05:00', '/about');