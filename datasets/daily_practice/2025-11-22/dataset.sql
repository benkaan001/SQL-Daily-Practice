CREATE DATABASE IF NOT EXISTS daily_practice_20251122_schema;
USE daily_practice_20251122_schema;

-- This table logs user interactions with different pages and elements, tracking conversions.
CREATE TABLE user_conversion_paths (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('VIEW_PAGE', 'CLICK_CTA', 'PURCHASE'),
    page_url VARCHAR(255),
    conversion_goal VARCHAR(50) -- Populated for PURCHASE events
);

INSERT INTO user_conversion_paths (user_id, session_id, event_timestamp, event_type, page_url, conversion_goal) VALUES
-- User 101: Hits goal, but with distraction
(101, 'sess_A', '2023-12-01 10:00:00.000', 'VIEW_PAGE', '/home', NULL),
(101, 'sess_A', '2023-12-01 10:01:00.000', 'CLICK_CTA', '/home', NULL),
(101, 'sess_A', '2023-12-01 10:02:00.000', 'VIEW_PAGE', '/blog', NULL), -- Distraction
(101, 'sess_A', '2023-12-01 10:03:00.000', 'VIEW_PAGE', '/checkout', NULL),
(101, 'sess_A', '2023-12-01 10:04:00.000', 'PURCHASE', '/checkout', 'Goal_A'),

-- User 102: Hits goal, following the path perfectly
(102, 'sess_B', '2023-12-01 11:00:00.000', 'VIEW_PAGE', '/home', NULL),
(102, 'sess_B', '2023-12-01 11:01:00.000', 'CLICK_CTA', '/home', NULL),
(102, 'sess_B', '2023-12-01 11:02:00.000', 'VIEW_PAGE', '/checkout', NULL),
(102, 'sess_B', '2023-12-01 11:03:00.000', 'PURCHASE', '/checkout', 'Goal_A'),

-- User 103: Abandons before checkout
(103, 'sess_C', '2023-12-01 12:00:00.000', 'VIEW_PAGE', '/home', NULL),
(103, 'sess_C', '2023-12-01 12:01:00.000', 'CLICK_CTA', '/home', NULL),
(103, 'sess_C', '2023-12-01 12:02:00.000', 'VIEW_PAGE', '/features', NULL), -- Ends here

-- User 104: Abandons after checkout view
(104, 'sess_D', '2023-12-02 13:00:00.000', 'VIEW_PAGE', '/home', NULL),
(104, 'sess_D', '2023-12-02 13:01:00.000', 'CLICK_CTA', '/home', NULL),
(104, 'sess_D', '2023-12-02 13:02:00.000', 'VIEW_PAGE', '/checkout', NULL),

-- User 105: Hits goal B (different path)
(105, 'sess_E', '2023-12-02 14:00:00.000', 'VIEW_PAGE', '/landing2', NULL),
(105, 'sess_E', '2023-12-02 14:01:00.000', 'PURCHASE', '/landing2', 'Goal_B'),

-- User 106: Hits goal, but skips the middle step (should be excluded)
(106, 'sess_F', '2023-12-03 15:00:00.000', 'VIEW_PAGE', '/home', NULL),
(106, 'sess_F', '2023-12-03 15:00:30.000', 'VIEW_PAGE', '/checkout', NULL),
(106, 'sess_F', '2023-12-03 15:01:00.000', 'PURCHASE', '/checkout', 'Goal_A');