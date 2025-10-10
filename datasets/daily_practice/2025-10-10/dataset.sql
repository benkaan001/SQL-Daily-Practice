CREATE DATABASE IF NOT EXISTS daily_practice_20251010_schema;
USE daily_practice_20251010_schema;

-- This table logs API requests, including successful calls and rate limit errors.
CREATE TABLE api_rate_limit_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    api_key VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('REQUEST_SUCCESS', 'RATE_LIMIT_EXCEEDED')
);

INSERT INTO api_rate_limit_logs (api_key, event_timestamp, event_type) VALUES
-- Key 'key-abc': A clear burst of rate limit errors
('key-abc', '2023-12-15 10:00:05.000', 'REQUEST_SUCCESS'),
('key-abc', '2023-12-15 10:00:10.000', 'RATE_LIMIT_EXCEEDED'),
('key-abc', '2023-12-15 10:00:15.000', 'RATE_LIMIT_EXCEEDED'),
('key-abc', '2023-12-15 10:00:20.000', 'RATE_LIMIT_EXCEEDED'),
('key-abc', '2023-12-15 10:00:25.000', 'RATE_LIMIT_EXCEEDED'), -- This is the 4th error, triggers the alert window
('key-abc', '2023-12-15 10:00:35.000', 'RATE_LIMIT_EXCEEDED'),
('key-abc', '2023-12-15 10:02:00.000', 'REQUEST_SUCCESS'), -- This is outside the 1-minute window

-- Key 'key-def': Errors are spread out, should not trigger an alert
('key-def', '2023-12-15 11:00:00.000', 'RATE_LIMIT_EXCEEDED'),
('key-def', '2023-12-15 11:01:30.000', 'RATE_LIMIT_EXCEEDED'),
('key-def', '2023-12-15 11:03:00.000', 'RATE_LIMIT_EXCEEDED'),
('key-def', '2023-12-15 11:04:30.000', 'RATE_LIMIT_EXCEEDED'),

-- Key 'key-xyz': A second burst incident
('key-xyz', '2023-12-15 14:30:10.000', 'RATE_LIMIT_EXCEEDED'),
('key-xyz', '2023-12-15 14:30:12.000', 'RATE_LIMIT_EXCEEDED'),
('key-xyz', '2023-12-15 14:30:15.000', 'RATE_LIMIT_EXCEEDED'),
('key-xyz', '2023-12-15 14:30:18.000', 'RATE_LIMIT_EXCEEDED'),
('key-xyz', '2023-12-15 14:30:55.000', 'RATE_LIMIT_EXCEEDED'),
('key-xyz', '2023-12-15 14:32:00.000', 'REQUEST_SUCCESS');
