CREATE DATABASE IF NOT EXISTS daily_practice_20251120_schema;
USE daily_practice_20251120_schema;

-- This table logs user activity on different pages of a website.
-- It tracks the session, the URL visited, and the duration (in seconds) the user spent on that page.
CREATE TABLE page_visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(50),
    visit_timestamp DATETIME(3),
    page_url VARCHAR(255),
    duration_seconds INT
);

INSERT INTO page_visits (user_id, session_id, visit_timestamp, page_url, duration_seconds) VALUES
-- User 101, Session A: Short session, quick browsing
(101, 'sess_A', '2023-12-01 10:00:00.000', '/home', 10),
(101, 'sess_A', '2023-12-01 10:00:10.000', '/products/1', 5),
(101, 'sess_A', '2023-12-01 10:00:15.000', '/cart', 20),
(101, 'sess_A', '2023-12-01 10:00:35.000', '/checkout', 10),
(101, 'sess_A', '2023-12-01 10:00:45.000', '/thank-you', 5),

-- User 102, Session B: Long dwell time on a product page
(102, 'sess_B', '2023-12-01 11:00:00.000', '/home', 15),
(102, 'sess_B', '2023-12-01 11:00:15.000', '/blog/article-1', 120),
(102, 'sess_B', '2023-12-01 11:02:15.000', '/products/2', 300), -- 5 minutes dwell time
(102, 'sess_B', '2023-12-01 11:07:15.000', '/home', 10),

-- User 101, Session C: Another session, different pattern
(101, 'sess_C', '2023-12-02 12:00:00.000', '/home', 10),
(101, 'sess_C', '2023-12-02 12:00:10.000', '/products/1', 5),
(101, 'sess_C', '2023-12-02 12:00:15.000', '/products/2', 10),
(101, 'sess_C', '2023-12-02 12:00:25.000', '/products/3', 5),
(101, 'sess_C', '2023-12-02 12:00:30.000', '/cart', 5),

-- User 103, Session D: Only one page view, high duration
(103, 'sess_D', '2023-12-02 14:00:00.000', '/contact', 180),

-- User 104, Session E: Very short dwell times (likely bot/scraping)
(104, 'sess_E', '2023-12-03 09:00:00.000', '/home', 1),
(104, 'sess_E', '2023-12-03 09:00:01.000', '/products/5', 1),
(104, 'sess_E', '2023-12-03 09:00:02.000', '/products/6', 1),
(104, 'sess_E', '2023-12-03 09:00:03.000', '/products/7', 1),
(104, 'sess_E', '2023-12-03 09:00:04.000', '/products/8', 1);