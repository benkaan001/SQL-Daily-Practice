CREATE DATABASE IF NOT EXISTS daily_practice_20260313_schema;
USE daily_practice_20260313_schema;

-- This table logs the dates on which users were active within the application.
-- Multiple actions on the same day are already deduplicated to a single row per user per day.
CREATE TABLE app_activity (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    activity_date DATE
);

INSERT INTO app_activity (user_id, activity_date) VALUES
-- Historical data (Needed to establish the rolling lookback for our target week)
(101, '2026-03-01'),
(102, '2026-03-02'),
(103, '2026-03-03'),
(101, '2026-03-05'),
(104, '2026-03-06'),

-- Target calculation week: March 7th - March 13th
(102, '2026-03-07'),
(105, '2026-03-07'),
(101, '2026-03-08'),
(103, '2026-03-09'),
(104, '2026-03-10'),
(106, '2026-03-10'),
(102, '2026-03-11'),
(101, '2026-03-12'),
(105, '2026-03-12'),
(107, '2026-03-13'),
(103, '2026-03-13');