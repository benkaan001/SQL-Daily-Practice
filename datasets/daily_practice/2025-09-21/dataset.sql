CREATE DATABASE IF NOT EXISTS daily_practice_20250921_schema;
USE daily_practice_20250921_schema;

-- This table logs API requests, tracking which key accessed which endpoint.
CREATE TABLE api_usage_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    api_key VARCHAR(50),
    endpoint_path VARCHAR(100),
    request_timestamp DATETIME(3),
    http_status INT
);

INSERT INTO api_usage_logs (api_key, endpoint_path, request_timestamp, http_status) VALUES
-- Key 'ABC-123': Shifts its primary usage from /users to /data
('ABC-123', '/v1/users', '2023-10-05 10:00:00.000', 200),
('ABC-123', '/v1/users', '2023-10-10 11:00:00.000', 200),
('ABC-123', '/v1/data', '2023-10-15 12:00:00.000', 200),
('ABC-123', '/v1/users', '2023-10-20 13:00:00.000', 200),
('ABC-123', '/v1/data', '2023-11-05 14:00:00.000', 200),
('ABC-123', '/v1/data', '2023-11-10 15:00:00.000', 200),
('ABC-123', '/v1/users', '2023-11-15 16:00:00.000', 200),
('ABC-123', '/v1/data', '2023-11-20 17:00:00.000', 200),

-- Key 'XYZ-789': Consistently uses the /billing endpoint
('XYZ-789', '/v1/billing', '2023-10-01 09:00:00.000', 200),
('XYZ-789', '/v1/billing', '2023-10-15 09:30:00.000', 200),
('XYZ-789', '/v1/data', '2023-10-20 10:00:00.000', 500), -- Error, but still a request
('XYZ-789', '/v1/billing', '2023-11-02 09:00:00.000', 200),
('XYZ-789', '/v1/billing', '2023-11-16 09:30:00.000', 200),
('XYZ-789', '/v1/billing', '2023-11-28 10:00:00.000', 200),

-- Key 'JKL-456': Only has activity in one month, so no shift can be detected
('JKL-456', '/v1/reports', '2023-11-10 18:00:00.000', 200),
('JKL-456', '/v1/reports', '2023-11-11 19:00:00.000', 200),
('JKL-456', '/v1/reports', '2023-11-12 20:00:00.000', 200);
