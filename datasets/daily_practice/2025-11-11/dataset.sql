CREATE DATABASE IF NOT EXISTS daily_practice_20251111_schema;
USE daily_practice_20251111_schema;

-- This table logs every page view event in a user's session.
CREATE TABLE web_page_visits (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    user_id INT,
    page_url VARCHAR(255),
    event_timestamp DATETIME(3)
);

INSERT INTO web_page_visits (session_id, user_id, page_url, event_timestamp) VALUES
-- Session A: Successful purchase
('sess_A', 101, '/home', '2023-11-11 10:00:00.000'),
('sess_A', 101, '/products', '2023-11-11 10:01:00.000'),
('sess_A', 101, '/checkout', '2023-11-11 10:02:00.000'),
('sess_A', 101, '/purchase_complete', '2023-11-11 10:03:00.000'),

-- Session B: Abandons at checkout
('sess_B', 102, '/home', '2023-11-11 11:00:00.000'),
('sess_B', 102, '/products', '2023-11-11 11:01:00.000'),
('sess_B', 102, '/checkout', '2023-11-11 11:02:00.000'),
-- No purchase, session ends

-- Session C: Follows the path but with an interruption
('sess_C', 103, '/home', '2023-11-11 12:00:00.000'),
('sess_C', 103, '/products', '2023-11-11 12:01:00.000'),
('sess_C', 103, '/about_us', '2023-11-11 12:02:00.000'), -- Interruption
('sess_C', 103, '/checkout', '2023-11-11 12:03:00.000'),
('sess_C', 103, '/purchase_complete', '2023-11-11 12:04:00.000'),

-- Session D: Does the path out of order
('sess_D', 104, '/home', '2023-11-11 13:00:00.000'),
('sess_D', 104, '/checkout', '2023-11-11 13:01:00.000'),
('sess_D', 104, '/products', '2023-11-11 13:02:00.000'),

-- Session E: Another abandoned checkout
('sess_E', 101, '/home', '2023-11-11 14:00:00.000'),
('sess_E', 101, '/products', '2023-11-11 14:01:00.000'),
('sess_E', 101, '/products/detail', '2023-11-11 14:01:30.000'), -- Interruption
('sess_E', 101, '/checkout', '2023-11-11 14:02:00.000'),
-- No purchase, session ends

-- Session F: Just browsing
('sess_F', 102, '/home', '2023-11-11 15:00:00.000'),
('sess_F', 102, '/about_us', '2023-11-11 15:01:00.000');