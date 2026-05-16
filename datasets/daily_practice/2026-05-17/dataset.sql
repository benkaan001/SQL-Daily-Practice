CREATE DATABASE IF NOT EXISTS daily_practice_20260517_schema;
USE daily_practice_20260517_schema;

-- Tracks the health status of various microservices.
-- The 'metadata' column contains JSON info about the environment and maintenance status.
CREATE TABLE service_health_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(50),
    status ENUM('UP', 'DOWN'),
    event_timestamp DATETIME(3),
    metadata JSON
);

INSERT INTO service_health_logs (service_name, status, event_timestamp, metadata) VALUES
-- Auth Service: Legitimate flapping (3 changes in < 30 mins, no maintenance)
('auth-service', 'UP',   '2026-05-17 08:00:00.000', '{"env": "prod", "maintenance": false}'),
('auth-service', 'DOWN', '2026-05-17 08:05:00.000', '{"env": "prod", "maintenance": false}'),
('auth-service', 'UP',   '2026-05-17 08:10:00.000', '{"env": "prod"}'), -- NULL maintenance defaults to false
('auth-service', 'DOWN', '2026-05-17 08:20:00.000', '{"env": "prod", "maintenance": false}'),
('auth-service', 'UP',   '2026-05-17 09:00:00.000', '{"env": "prod", "maintenance": false}'),

-- Payment Service: Status changes, but during a maintenance window
('payment-service', 'UP',   '2026-05-17 10:00:00.000', '{"env": "prod", "maintenance": true}'),
('payment-service', 'DOWN', '2026-05-17 10:05:00.000', '{"env": "prod", "maintenance": true}'),
('payment-service', 'UP',   '2026-05-17 10:10:00.000', '{"env": "prod", "maintenance": true}'),

-- Order Service: Only 2 changes, not enough to be flapping
('order-service', 'UP',   '2026-05-17 12:00:00.000', '{"env": "prod", "maintenance": false}'),
('order-service', 'DOWN', '2026-05-17 12:15:00.000', '{"env": "prod", "maintenance": false}'),
('order-service', 'UP',   '2026-05-17 12:45:00.000', '{"env": "prod", "maintenance": false}'),

-- Catalog Service: Flapping occurs across a wide window (> 30 mins)
('catalog-service', 'UP',   '2026-05-17 14:00:00.000', '{"env": "prod", "maintenance": false}'),
('catalog-service', 'DOWN', '2026-05-17 14:10:00.000', '{"env": "prod", "maintenance": false}'),
('catalog-service', 'UP',   '2026-05-17 14:25:00.000', '{"env": "prod", "maintenance": false}'),
('catalog-service', 'DOWN', '2026-05-17 14:40:00.000', '{"env": "prod", "maintenance": false}');