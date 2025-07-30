CREATE DATABASE IF NOT EXISTS daily_practice_20250730_schema;
USE daily_practice_20250730_schema;

CREATE TABLE watch_history (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content_id INT,
    content_type ENUM('movie', 'series'),
    series_title VARCHAR(100), -- NULL for movies
    season_number INT, -- NULL for movies
    episode_number INT, -- NULL for movies
    watch_start_timestamp DATETIME,
    watch_end_timestamp DATETIME, -- Can be NULL if session is ongoing
    device_type VARCHAR(20)
);

INSERT INTO watch_history (user_id, content_id, content_type, series_title, season_number, episode_number, watch_start_timestamp, watch_end_timestamp, device_type) VALUES
-- User 101: Binges a series
(101, 2001, 'series', 'The Crown', 1, 1, '2023-10-01 20:00:00', '2023-10-01 20:50:00', 'Smart TV'),
(101, 2002, 'series', 'The Crown', 1, 2, '2023-10-01 20:52:00', '2023-10-01 21:40:00', 'Smart TV'),
(101, 2003, 'series', 'The Crown', 1, 3, '2023-10-01 21:45:00', '2023-10-01 22:35:00', 'Smart TV'),
(101, 1001, 'movie', NULL, NULL, NULL, '2023-10-05 19:00:00', '2023-10-05 21:00:00', 'Smart TV'),

-- User 102: Watches different content
(102, 1002, 'movie', NULL, NULL, NULL, '2023-10-02 18:00:00', '2023-10-02 19:30:00', 'Tablet'),
(102, 3001, 'series', 'Stranger Things', 1, 1, '2023-10-02 20:00:00', '2023-10-02 20:45:00', 'Tablet'),
(102, 1003, 'movie', NULL, NULL, NULL, '2023-10-02 21:00:00', '2023-10-02 22:45:00', 'Tablet'),
(102, 2001, 'series', 'The Crown', 1, 1, '2023-10-08 11:00:00', '2023-10-08 11:50:00', 'Mobile'),

-- User 103: Watches intermittently
(103, 3001, 'series', 'Stranger Things', 1, 1, '2023-10-03 21:00:00', '2023-10-03 21:45:00', 'Laptop'),
(103, 3002, 'series', 'Stranger Things', 1, 2, '2023-10-05 21:00:00', '2023-10-05 21:50:00', 'Laptop'), -- Not a binge (2-day gap)
(103, 1001, 'movie', NULL, NULL, NULL, '2023-11-01 19:30:00', '2023-11-01 21:30:00', 'Laptop'),

-- User 104: Another binge-watcher
(104, 4001, 'series', 'The Witcher', 1, 1, '2023-11-01 18:00:00', '2023-11-01 18:55:00', 'Smart TV'),
(104, 4002, 'series', 'The Witcher', 1, 2, '2023-11-01 18:58:00', '2023-11-01 19:50:00', 'Smart TV'),
(104, 4003, 'series', 'The Witcher', 1, 3, '2023-11-01 19:51:00', '2023-11-01 20:40:00', 'Smart TV'),
(104, 4004, 'series', 'The Witcher', 1, 4, '2023-11-01 20:45:00', NULL, 'Smart TV'), -- Ongoing session

-- User 105: Watches first episode of two different series
(105, 2001, 'series', 'The Crown', 1, 1, '2023-11-02 10:00:00', '2023-11-02 10:50:00', 'Mobile'),
(105, 3001, 'series', 'Stranger Things', 1, 1, '2023-11-02 11:00:00', '2023-11-02 11:45:00', 'Mobile');
