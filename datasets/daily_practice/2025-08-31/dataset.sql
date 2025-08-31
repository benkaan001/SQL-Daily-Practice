CREATE DATABASE IF NOT EXISTS daily_practice_20250831_schema;
USE daily_practice_20250031_schema;

-- This table logs all incoming requests to an API gateway.
CREATE TABLE api_gateway_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id VARCHAR(50),
    api_key VARCHAR(50),
    service_name VARCHAR(50),
    http_method VARCHAR(10),
    resource_path VARCHAR(255),
    status_code INT,
    response_time_ms INT,
    request_timestamp DATETIME(3)
);

INSERT INTO api_gateway_logs (request_id, api_key, service_name, http_method, resource_path, status_code, response_time_ms, request_timestamp) VALUES
-- Key-A: Normal traffic
('req_01', 'key-A', 'product-service', 'GET', '/products/123', 200, 50, '2023-09-20 10:00:00.000'),
('req_02', 'key-A', 'user-service', 'GET', '/users/profile', 200, 30, '2023-09-20 10:01:00.000'),

-- Key-B: Rate limiting scenario
('req_03', 'key-B', 'search-service', 'GET', '/search?q=a', 200, 80, '2023-09-20 10:30:00.000'),
('req_04', 'key-B', 'search-service', 'GET', '/search?q=b', 200, 85, '2023-09-20 10:30:10.000'),
('req_05', 'key-B', 'search-service', 'GET', '/search?q=c', 200, 90, '2023-09-20 10:30:20.000'),
('req_06', 'key-B', 'search-service', 'GET', '/search?q=d', 200, 95, '2023-09-20 10:30:30.000'),
('req_07', 'key-B', 'search-service', 'GET', '/search?q=e', 429, 5, '2023-09-20 10:30:35.000'), -- Throttled
('req_08', 'key-B', 'search-service', 'GET', '/search?q=f', 429, 5, '2023-09-20 10:30:40.000'), -- Throttled

-- Cascading failure scenario: order-service depends on user-service
('req_09', 'key-C', 'user-service', 'GET', '/users/404', 503, 1500, '2023-09-21 11:00:00.000'), -- user-service fails
('req_09', 'key-C', 'order-service', 'POST', '/orders', 500, 200, '2023-09-21 11:00:00.500'), -- order-service fails as a result

-- P95 Latency anomaly scenario for payment-service
('req_10', 'key-A', 'payment-service', 'POST', '/charge', 200, 100, '2023-09-22 09:00:00.000'),
('req_11', 'key-A', 'payment-service', 'POST', '/charge', 200, 110, '2023-09-22 09:01:00.000'),
('req_12', 'key-A', 'payment-service', 'POST', '/charge', 200, 90, '2023-09-22 09:02:00.000'),
('req_13', 'key-A', 'payment-service', 'POST', '/charge', 200, 120, '2023-09-22 09:03:00.000'),
('req_14', 'key-A', 'payment-service', 'POST', '/charge', 200, 300, '2023-09-22 09:04:00.000'), -- P95 for this day is around 300ms
('req_15', 'key-C', 'payment-service', 'POST', '/charge', 200, 700, '2023-09-23 09:00:00.000'), -- Latency spikes next day
('req_16', 'key-C', 'payment-service', 'POST', '/charge', 200, 750, '2023-09-23 09:01:00.000'),
('req_17', 'key-C', 'payment-service', 'POST', '/charge', 200, 680, '2023-09-23 09:02:00.000'),
('req_18', 'key-C', 'payment-service', 'POST', '/charge', 200, 720, '2023-09-23 09:03:00.000'),
('req_19', 'key-C', 'payment-service', 'POST', '/charge', 200, 900, '2023-09-23 09:04:00.000'), -- P95 for this day is around 900ms

-- Another failed request for order-service without a dependency failure
('req_20', 'key-D', 'order-service', 'POST', '/orders', 500, 250, '2023-09-24 14:00:00.000');
