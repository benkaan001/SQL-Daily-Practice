CREATE DATABASE IF NOT EXISTS daily_practice_20250813_schema;
USE daily_practice_20250813_schema;

CREATE TABLE api_usage_logs (
    request_id VARCHAR(50) PRIMARY KEY,
    api_key VARCHAR(50),
    endpoint VARCHAR(100),
    request_timestamp DATETIME(3),
    status_code INT,
    latency_ms INT,
    request_payload_kb DECIMAL(10, 2),
    response_payload_kb DECIMAL(10, 2)
);

INSERT INTO api_usage_logs (request_id, api_key, endpoint, request_timestamp, status_code, latency_ms, request_payload_kb, response_payload_kb) VALUES
-- key-abc: Triggers throttling. Assume 99 requests occurred in the minute before req_001 for this key.
('req_001', 'key-abc', '/users', '2023-11-25 09:58:00.000', 200, 50, 1.2, 5.5),
('req_100', 'key-abc', '/users', '2023-11-25 10:02:58.000', 200, 55, 1.3, 5.6),
('req_101', 'key-abc', '/users', '2023-11-25 10:02:59.000', 429, 10, 1.1, 0.1), -- This is the 101st request in a 5-minute window
('req_102', 'key-abc', '/users', '2023-11-25 10:03:00.000', 429, 11, 1.2, 0.1), -- Stays throttled

-- key-def: Normal usage in hour 13:00
('req_103', 'key-def', '/orders', '2023-11-25 13:05:00.000', 200, 150, 5.5, 10.0),
('req_104', 'key-def', '/orders', '2023-11-25 13:10:00.000', 200, 160, 5.6, 10.2),
('req_105', 'key-def', '/orders', '2023-11-25 13:15:00.000', 200, 155, 5.4, 9.8),
('req_106', 'key-def', '/orders', '2023-11-25 13:55:00.000', 200, 210, 5.8, 11.0),

-- key-def: Performance degradation in hour 14:00
('req_107', 'key-def', '/orders', '2023-11-25 14:05:00.000', 200, 180, 5.5, 10.0),
('req_108', 'key-def', '/orders', '2023-11-25 14:10:00.000', 200, 190, 5.6, 10.2),
('req_109', 'key-def', '/orders', '2023-11-25 14:15:00.000', 200, 450, 5.4, 9.8), -- Latency spike
('req_110', 'key-def', '/orders', '2023-11-25 14:20:00.000', 200, 480, 5.8, 11.0), -- Latency spike

-- key-ghi: Errors correlated with large payloads
('req_111', 'key-ghi', '/products', '2023-11-25 16:00:00.000', 200, 80, 2.5, 20.0),
('req_112', 'key-ghi', '/products', '2023-11-25 16:01:00.000', 200, 85, 3.0, 22.0),
('req_113', 'key-ghi', '/products', '2023-11-25 16:02:00.000', 500, 500, 55.0, 0.5), -- Large payload, error
('req_114', 'key-ghi', '/products', '2023-11-25 16:03:00.000', 200, 90, 2.8, 21.0),
('req_115', 'key-ghi', '/products', '2023-11-25 16:04:00.000', 503, 550, 65.0, 0.5), -- Large payload, error
('req_116', 'key-ghi', '/products', '2023-11-25 16:05:00.000', 200, 88, 3.1, 23.0),

-- key-xyz: Errors not correlated with payload size
('req_117', 'key-xyz', '/users', '2023-11-25 17:00:00.000', 200, 40, 1.5, 5.0),
('req_118', 'key-xyz', '/users', '2023-11-25 17:01:00.000', 500, 300, 1.6, 0.5),
('req_119', 'key-xyz', '/users', '2023-11-25 17:02:00.000', 200, 45, 1.4, 5.2);
