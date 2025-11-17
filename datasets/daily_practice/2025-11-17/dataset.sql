CREATE DATABASE IF NOT EXISTS daily_practice_20251117_schema;
USE daily_practice_20251117_schema;

-- This table logs user events on a website.
-- The 'event_name' tracks the specific action, and 'page_url' tracks where it happened.
CREATE TABLE user_page_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    user_id INT,
    event_timestamp DATETIME(3),
    event_name ENUM('VIEW_PAGE', 'CLICK_BUTTON', 'FORM_SUBMIT'),
    page_url VARCHAR(100),
    details VARCHAR(100) -- e.g., button name or form ID
);

INSERT INTO user_page_events (session_id, user_id, event_timestamp, event_name, page_url, details) VALUES
-- User 101: Successful 'Standard Signup'
('sess_A', 101, '2023-11-17 10:00:00.000', 'VIEW_PAGE', '/home', NULL),
('sess_A', 101, '2023-11-17 10:01:00.000', 'VIEW_PAGE', '/pricing', NULL),
('sess_A', 101, '2023-11-17 10:02:00.000', 'CLICK_BUTTON', '/pricing', 'signup_standard'),

-- User 102: Successful 'Enterprise Signup'
('sess_B', 102, '2023-11-17 11:00:00.000', 'VIEW_PAGE', '/home', NULL),
('sess_B', 102, '2023-11-17 11:01:00.000', 'VIEW_PAGE', '/enterprise', NULL),
('sess_B', 102, '2023-11-17 11:02:00.000', 'FORM_SUBMIT', '/enterprise', 'contact_sales'),

-- User 103: Fails 'Standard Signup' (skips a step)
('sess_C', 103, '2023-11-17 12:00:00.000', 'VIEW_PAGE', '/home', NULL),
('sess_C', 103, '2023-11-17 12:01:00.000', 'CLICK_BUTTON', '/home', 'signup_standard'),

-- User 104: Browses, doesn't complete a funnel
('sess_D', 104, '2023-11-17 13:00:00.000', 'VIEW_PAGE', '/home', NULL),
('sess_D', 104, '2023-11-17 13:01:00.000', 'VIEW_PAGE', '/pricing', NULL),
('sess_D', 104, '2023-11-17 13:02:00.000', 'VIEW_PAGE', '/enterprise', NULL),

-- User 105: Fails 'Enterprise Signup' (wrong order)
('sess_E', 105, '2023-11-17 14:00:00.000', 'VIEW_PAGE', '/enterprise', NULL),
('sess_E', 105, '2023-11-17 14:01:00.000', 'VIEW_PAGE', '/home', NULL),
('sess_E', 105, '2023-11-17 14:02:00.000', 'FORM_SUBMIT', '/enterprise', 'contact_sales'),

-- User 106: Successful 'Standard Signup' (with an interruption)
('sess_F', 106, '2023-11-17 15:00:00.000', 'VIEW_PAGE', '/home', NULL),
('sess_F', 106, '2023-11-17 15:01:00.000', 'VIEW_PAGE', '/pricing', NULL),
('sess_F', 106, '2023-11-17 15:02:00.000', 'VIEW_PAGE', '/about-us', NULL), -- Interruption
('sess_F', 106, '2023-11-17 15:03:00.000', 'CLICK_BUTTON', '/pricing', 'signup_standard');

-- User 102: Another 'Enterprise Signup'
('sess_G', 102, '2023-11-17 16:00:00.000', 'VIEW_PAGE', '/home', NULL),
('sess_G', 102, '2023-11-17 16:01:00.000', 'VIEW_PAGE', '/enterprise', NULL),
('sess_G', 102, '2023-11-17 16:03:00.000', 'FORM_SUBMIT', '/enterprise', 'contact_sales');