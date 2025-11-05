CREATE DATABASE IF NOT EXISTS daily_practice_20251105_schema;
USE daily_practice_20251105_schema;

-- This table logs every login attempt made to the system, successful or not.
CREATE TABLE login_attempts (
    attempt_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT, -- NULL if the user does not exist
    username_attempted VARCHAR(100),
    ip_address VARCHAR(45),
    attempt_timestamp DATETIME(3),
    success BOOLEAN
);

INSERT INTO login_attempts (user_id, username_attempted, ip_address, attempt_timestamp, success) VALUES
-- IP '10.0.0.1': Normal activity
(101, 'user_101', '10.0.0.1', '2023-11-28 08:00:00.000', true),
(102, 'user_102', '10.0.0.1', '2023-11-28 08:05:00.000', true),

-- IP '203.0.113.55': A "Brute Force" attack (many attempts on one user)
(103, 'user_103', '203.0.113.55', '2023-11-28 09:00:00.000', false),
(103, 'user_103', '203.0.113.55', '2023-11-28 09:00:10.000', false),
(103, 'user_103', '203.0.113.55', '2023-11-28 09:00:20.000', false),
(103, 'user_103', '203.0.113.55', '2023-11-28 09:00:30.000', false),
(103, 'user_103', '203.0.113.55', '2023-11-28 09:00:40.000', false),

-- IP '198.51.100.82': A "Password Spraying" attack (many users, one IP)
(NULL, 'admin', '198.51.100.82', '2023-11-28 10:00:00.000', false),
(NULL, 'root', '198.51.100.82', '2023-11-28 10:01:00.000', false),
(101, 'user_101', '198.51.100.82', '2023-11-28 10:02:00.000', false),
(102, 'user_102', '198.51.100.82', '2023-11-28 10:03:00.000', false),
(103, 'user_103', '198.51.100.82', '2023-11-28 10:04:00.000', false), -- 5th unique user attempt
(104, 'user_104', '198.51.100.82', '2023-11-28 10:05:00.000', false),
(105, 'user_105', '198.51.100.82', '2023-11-28 10:06:00.000', false),

-- IP '198.51.100.82': Another "Password Spraying" attack later, outside the first window
(NULL, 'support', '198.51.100.82', '2023-11-28 10:45:00.000', false),
(NULL, 'billing', '198.51.100.82', '2023-11-28 10:45:30.000', false),
(NULL, 'dev', '198.51.100.82', '2023-11-28 10:46:00.000', false),
(NULL, 'test', '198.51.100.82', '2023-11-28 10:46:30.000', false),
(NULL, 'api_user', '198.51.100.82', '2023-11-28 10:47:00.000', false), -- 5th unique user attempt
(106, 'user_106', '198.51.100.82', '2023-11-28 10:47:30.000', false),

-- IP '203.0.113.99': A failed spray (not enough unique users)
(101, 'user_101', '203.0.113.99', '2023-11-28 11:00:00.000', false),
(101, 'user_101', '203.0.113.99', '2023-11-28 11:00:10.000', false),
(102, 'user_102', '203.0.113.99', '2023-11-28 11:00:20.000', false),
(102, 'user_102', '203.0.113.99', '2023-11-28 11:00:30.000', false),
(103, 'user_103', '203.0.113.99', '2023-11-28 11:00:40.000', false);
