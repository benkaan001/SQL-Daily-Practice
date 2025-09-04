CREATE DATABASE IF NOT EXISTS daily_practice_20250904_schema;
USE daily_practice_20250904_schema;

-- This table logs all user authentication events for a platform.
CREATE TABLE auth_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('LOGIN_SUCCESS', 'LOGIN_FAILURE', 'LOGOUT', 'PASSWORD_RESET_REQUEST', 'PASSWORD_RESET_SUCCESS'),
    ip_address VARCHAR(45),
    details JSON
);

INSERT INTO auth_events (user_id, event_timestamp, event_type, ip_address, details) VALUES
-- User 101: Concurrent session scenario
(101, '2023-10-10 09:00:00.000', 'LOGIN_SUCCESS', '192.168.1.10', '{"user_agent": "Chrome/118.0"}'),
(101, '2023-10-10 09:02:30.000', 'LOGIN_SUCCESS', '203.0.113.55', '{"user_agent": "Safari/17.0"}'), -- New IP, no logout
(101, '2023-10-10 10:00:00.000', 'LOGOUT', '192.168.1.10', NULL),

-- User 102: Normal activity
(102, '2023-10-10 09:30:00.000', 'LOGIN_SUCCESS', '198.51.100.2', '{"user_agent": "Firefox/117.0"}'),
(102, '2023-10-10 17:00:00.000', 'LOGOUT', '198.51.100.2', NULL),

-- User 103: Brute force attack scenario
(103, '2023-10-11 11:00:00.000', 'LOGIN_FAILURE', '198.51.100.88', '{"reason": "INVALID_PASSWORD"}'),
(103, '2023-10-11 11:00:15.000', 'LOGIN_FAILURE', '198.51.100.88', '{"reason": "INVALID_PASSWORD"}'),
(103, '2023-10-11 11:00:45.000', 'LOGIN_FAILURE', '198.51.100.88', '{"reason": "INVALID_PASSWORD"}'),
(103, '2023-10-11 11:01:30.000', 'LOGIN_FAILURE', '198.51.100.88', '{"reason": "INVALID_PASSWORD"}'),
(103, '2023-10-11 11:02:00.000', 'LOGIN_FAILURE', '198.51.100.88', '{"reason": "INVALID_PASSWORD"}'),
(103, '2023-10-11 11:02:10.000', 'LOGIN_SUCCESS', '198.51.100.88', '{"user_agent": "Chrome/118.0"}'), -- Finally succeeds

-- User 104: Successful password reset
(104, '2023-10-12 14:00:00.000', 'LOGIN_FAILURE', '203.0.113.12', '{"reason": "INVALID_PASSWORD"}'),
(104, '2023-10-12 14:01:00.000', 'PASSWORD_RESET_REQUEST', '203.0.113.12', NULL),
(104, '2023-10-12 14:05:30.000', 'PASSWORD_RESET_SUCCESS', '203.0.113.12', NULL),
(104, '2023-10-12 14:06:00.000', 'LOGIN_SUCCESS', '203.0.113.12', '{"user_agent": "Chrome/118.0"}'),

-- User 105: Abandoned password reset
(105, '2023-10-13 16:00:00.000', 'LOGIN_FAILURE', '198.51.100.40', '{"reason": "INVALID_PASSWORD"}'),
(105, '2023-10-13 16:01:00.000', 'PASSWORD_RESET_REQUEST', '198.51.100.40', NULL);
