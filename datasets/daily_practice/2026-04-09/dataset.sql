CREATE DATABASE IF NOT EXISTS daily_practice_20260409_schema;
USE daily_practice_20260409_schema;

-- This table logs incoming requests for a ride-sharing application.
CREATE TABLE ride_requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    zone_id VARCHAR(10),
    request_timestamp DATETIME(3)
);

INSERT INTO ride_requests (zone_id, request_timestamp) VALUES
-- Zone A: A slow morning, no surge pricing should trigger.
('Zone-A', '2026-04-09 08:00:00.000'),
('Zone-A', '2026-04-09 08:05:00.000'),
('Zone-A', '2026-04-09 08:12:00.000'), 

-- Zone B: A sudden spike in demand (e.g., a concert just ended).
('Zone-B', '2026-04-09 17:00:00.000'),
('Zone-B', '2026-04-09 17:02:00.000'),
('Zone-B', '2026-04-09 17:04:00.000'),
('Zone-B', '2026-04-09 17:06:00.000'), -- Demand is building
('Zone-B', '2026-04-09 17:07:00.000'), 
('Zone-B', '2026-04-09 17:08:00.000'), 
('Zone-B', '2026-04-09 17:09:00.000'), -- High demand!

-- Zone A: Later in the day, a moderate amount of traffic.
('Zone-A', '2026-04-09 18:00:00.000'),
('Zone-A', '2026-04-09 18:02:00.000'),
('Zone-A', '2026-04-09 18:05:00.000'),
('Zone-A', '2026-04-09 18:09:00.000');