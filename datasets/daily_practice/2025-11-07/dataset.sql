CREATE DATABASE IF NOT EXISTS daily_practice_20251107_schema;
USE daily_practice_20251107_schema;

-- This table logs individual events within a user's session on a website.
CREATE TABLE web_session_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    user_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('PAGE_VIEW', 'CLICK', 'SCROLL', 'ADD_TO_CART'),
    page_url VARCHAR(255)
);

INSERT INTO web_session_events (session_id, user_id, event_timestamp, event_type, page_url) VALUES
-- Session A: User views landing page, then nothing for > 2 mins. (Bounce)
('sess_A', 101, '2023-11-29 09:00:00.000', 'PAGE_VIEW', '/landing-page-A'),

-- Session B: User views, then clicks within 2 mins. (No bounce)
('sess_B', 102, '2023-11-29 09:05:00.000', 'PAGE_VIEW', '/product/123'),
('sess_B', 102, '2023-11-29 09:05:45.000', 'CLICK', '/product/123'),

-- Session C: User views, has no activity, then views another page. (First page is a bounce)
('sess_C', 103, '2023-11-29 09:10:00.000', 'PAGE_VIEW', '/features'),
('sess_C', 103, '2023-11-29 09:12:30.000', 'PAGE_VIEW', '/pricing'), -- 2.5 mins later

-- Session D: User has multiple views, all with activity. (No bounce)
('sess_D', 104, '2023-11-29 09:15:00.000', 'PAGE_VIEW', '/'),
('sess_D', 104, '2023-11-29 09:15:20.000', 'SCROLL', '/'),
('sess_D', 104, '2023-11-29 09:16:00.000', 'CLICK', '/'),
('sess_D', 104, '2023-11-29 09:16:05.000', 'PAGE_VIEW', '/about-us'),
('sess_D', 104, '2023-11-29 09:16:30.000', 'SCROLL', '/about-us'),

-- Session E: User views, then clicks just after the 2-min window. (Bounce)
('sess_E', 105, '2023-11-29 09:20:00.000', 'PAGE_VIEW', '/product/456'),
('sess_E', 105, '2023-11-29 09:22:01.000', 'CLICK', '/product/456'), -- 2 mins, 1 sec later

-- Session F: User views, then adds to cart. (No bounce)
('sess_F', 106, '2023-11-29 09:25:00.000', 'PAGE_VIEW', '/product/789'),
('sess_F', 106, '2023-11-29 09:26:00.000', 'ADD_TO_CART', '/product/789');