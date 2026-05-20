CREATE DATABASE IF NOT EXISTS daily_practice_20260519_schema;
USE daily_practice_20260519_schema;

-- Tracks the health status of various microservices.
CREATE TABLE service_health_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(50),
    status ENUM('UP', 'DOWN'),
    event_timestamp DATETIME(3),
    metadata JSON
);

INSERT INTO service_health_logs (service_name, status, event_timestamp, metadata) VALUES
-- Gateway Service: Flapping (3 changes in < 30 mins)
('gateway-service', 'UP',   '2026-04-19 08:00:00.000', '{"env": "prod", "maintenance": false}'),
('gateway-service', 'DOWN', '2026-04-19 08:05:00.000', '{"env": "prod", "maintenance": false}'),
('gateway-service', 'UP',   '2026-04-19 08:10:00.000', '{"env": "prod", "maintenance": false}'),
('gateway-service', 'DOWN', '2026-04-19 08:25:00.000', '{"env": "prod", "maintenance": false}'),

-- Billing Service: Maintenance active, should be ignored
('billing-service', 'UP',   '2026-04-19 10:00:00.000', '{"env": "prod", "maintenance": true}'),
('billing-service', 'DOWN', '2026-04-19 10:05:00.000', '{"env": "prod", "maintenance": true}'),
('billing-service', 'UP',   '2026-04-19 10:10:00.000', '{"env": "prod", "maintenance": true}'),

-- Cache Service: Only 2 changes, not enough to be flapping
('cache-service', 'UP',   '2026-04-19 14:00:00.000', '{"env": "prod", "maintenance": false}'),
('cache-service', 'DOWN', '2026-04-19 14:40:00.000', '{"env": "prod", "maintenance": false}'),
('cache-service', 'UP',   '2026-04-19 15:00:00.000', '{"env": "prod", "maintenance": false}');
