CREATE DATABASE IF NOT EXISTS daily_practice_20250811_schema;
USE daily_practice_20250811_schema;

-- This table logs critical events from a distributed system.
CREATE TABLE system_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    node_id INT,
    service_name VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('CPU_USAGE', 'MEMORY_USAGE', 'SERVICE_RESTART', 'DEPLOYMENT_START', 'DEPLOYMENT_SUCCESS', 'DEPLOYMENT_FAILURE'),
    metric_value DECIMAL(10, 2), -- e.g., CPU %, Memory GB
    details JSON
);

INSERT INTO system_events (node_id, service_name, event_timestamp, event_type, metric_value, details) VALUES
-- Node 1: API Gateway issues
(1, 'api_gateway', '2023-11-20 09:50:00.000', 'CPU_USAGE', 92.50, NULL),
(1, 'api_gateway', '2023-11-20 09:55:00.000', 'CPU_USAGE', 95.80, NULL),
(1, 'api_gateway', '2023-11-20 10:01:00.000', 'SERVICE_RESTART', NULL, '{"reason": "health_check_failed"}'),
(1, 'api_gateway', '2023-11-20 10:05:00.000', 'CPU_USAGE', 50.00, NULL),
(1, 'api_gateway', '2023-11-20 10:30:00.000', 'SERVICE_RESTART', NULL, '{"reason": "unknown"}'), -- No preceding high CPU
(1, 'api_gateway', '2023-11-20 10:50:00.000', 'SERVICE_RESTART', NULL, '{"reason": "unknown"}'), -- Flapping
(1, 'api_gateway', '2023-11-20 11:15:00.000', 'SERVICE_RESTART', NULL, '{"reason": "unknown"}'), -- Flapping

-- Node 2: Data Pipeline deployment issues
(2, 'data_pipeline', '2023-11-21 14:00:00.000', 'DEPLOYMENT_START', NULL, '{"version": "v2.1"}'),
(2, 'data_pipeline', '2023-11-21 14:10:00.000', 'DEPLOYMENT_FAILURE', NULL, '{"error": "db_connection_timeout"}'),
(2, 'user_database', '2023-11-21 14:15:00.000', 'CPU_USAGE', 98.00, NULL), -- Cascade CPU spike
(2, 'user_database', '2023-11-21 14:20:00.000', 'SERVICE_RESTART', NULL, '{"reason": "high_cpu"}'), -- Cascade restart
(2, 'data_pipeline', '2023-11-21 15:00:00.000', 'DEPLOYMENT_START', NULL, '{"version": "v2.1.1"}'),
(2, 'data_pipeline', '2023-11-21 15:15:00.000', 'DEPLOYMENT_SUCCESS', NULL, '{"version": "v2.1.1"}'),

-- Node 3: Memory leak and successful deployment
(3, 'auth_service', '2023-11-22 11:00:00.000', 'MEMORY_USAGE', 8.50, NULL), -- Normal usage
(3, 'auth_service', '2023-11-22 12:00:00.000', 'MEMORY_USAGE', 12.00, NULL),
(3, 'auth_service', '2023-11-22 13:00:00.000', 'MEMORY_USAGE', 15.80, NULL), -- Leak
(3, 'auth_service', '2023-11-22 13:05:00.000', 'SERVICE_RESTART', NULL, '{"reason": "memory_limit_exceeded"}'),
(3, 'reporting_service', '2023-11-22 16:00:00.000', 'DEPLOYMENT_START', NULL, '{"version": "v1.5"}'),
(3, 'reporting_service', '2023-11-22 16:20:00.000', 'DEPLOYMENT_SUCCESS', NULL, '{"version": "v1.5"}'),

-- Node 1: More issues
(1, 'api_gateway', '2023-11-23 18:00:00.000', 'CPU_USAGE', 91.00, NULL),
(1, 'api_gateway', '2023-11-23 18:02:00.000', 'CPU_USAGE', 94.00, NULL),
(1, 'api_gateway', '2023-11-23 18:08:00.000', 'SERVICE_RESTART', NULL, '{"reason": "health_check_failed"}'),
(1, 'user_database', '2023-11-23 18:15:00.000', 'CPU_USAGE', 85.00, NULL); -- Not a cascade, different service
