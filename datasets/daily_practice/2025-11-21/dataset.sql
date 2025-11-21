CREATE DATABASE IF NOT EXISTS daily_practice_20251121_schema;
USE daily_practice_20251121_schema;

-- This table logs user access events for a system.
CREATE TABLE user_access_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('LOGIN', 'LOGOUT'),
    ip_address VARCHAR(45),
    details JSON
);

INSERT INTO user_access_logs (user_id, event_timestamp, event_type, ip_address, details) VALUES
-- User 101: Normal sequential login/logout cycle
(101, '2023-11-20 09:00:00.000', 'LOGIN', '10.0.0.1', '{"device": "desktop"}'),
(101, '2023-11-20 10:00:00.000', 'LOGOUT', '10.0.0.1', NULL),

-- User 102: Missing Logout (Ghost Session 1 starts here, then a second login)
(102, '2023-11-20 11:00:00.000', 'LOGIN', '10.0.0.2', '{"device": "mobile"}'),
(102, '2023-11-20 11:15:00.000', 'LOGIN', '10.0.0.3', '{"device": "tablet"}'), -- Login without preceding logout

-- User 103: Normal cycle
(103, '2023-11-20 13:00:00.000', 'LOGIN', '10.0.0.4', '{"device": "desktop"}'),
(103, '2023-11-20 13:30:00.000', 'LOGOUT', '10.0.0.4', NULL),

-- User 104: Out-of-order log entries (should be handled by ordering)
(104, '2023-11-20 14:00:00.000', 'LOGOUT', '10.0.0.5', NULL), -- Should not be the first event
(104, '2023-11-20 14:15:00.000', 'LOGIN', '10.0.0.5', '{"device": "desktop"}'),
(104, '2023-11-20 15:00:00.000', 'LOGOUT', '10.0.0.5', NULL),

-- User 105: Missing Logout (Ghost Session 2)
(105, '2023-11-20 15:00:00.000', 'LOGIN', '10.0.0.6', '{"device": "mobile"}'),
(105, '2023-11-20 15:30:00.000', 'LOGOUT', '10.0.0.6', NULL),
(105, '2023-11-20 16:00:00.000', 'LOGIN', '10.0.0.6', '{"device": "desktop"}'); -- Ghost Session 2 starts here.