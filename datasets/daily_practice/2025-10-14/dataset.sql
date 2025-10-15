CREATE DATABASE IF NOT EXISTS daily_practice_20251014_schema;
USE daily_practice_20251014_schema;

-- This table logs telemetry data from a fleet of rental e-scooters.
CREATE TABLE scooter_telemetry (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    scooter_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('UNLOCK', 'LOCK', 'LOW_BATTERY_ALERT', 'LOCATION_UPDATE'),
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    battery_level INT
);

INSERT INTO scooter_telemetry (scooter_id, event_timestamp, event_type, latitude, longitude, battery_level) VALUES
-- Scooter 101: Normal trip
(101, '2023-12-18 08:30:00.000', 'UNLOCK', 34.052235, -118.243683, 95),
(101, '2023-12-18 08:35:00.000', 'LOCATION_UPDATE', 34.053211, -118.245112, 90),
(101, '2023-12-18 08:40:00.000', 'LOCATION_UPDATE', 34.054567, -118.247890, 85),
(101, '2023-12-18 08:45:00.000', 'LOCK', 34.055123, -118.249911, 82),

-- Scooter 102: Orphaned scooter - unlocked but never locked again
(102, '2023-12-18 09:00:00.000', 'UNLOCK', 40.712776, -74.005974, 88),
(102, '2023-12-18 09:05:00.000', 'LOCATION_UPDATE', 40.713555, -74.006111, 85),
(102, '2023-12-18 09:10:00.000', 'LOW_BATTERY_ALERT', 40.714222, -74.007888, 19), -- Last event, still unlocked

-- Scooter 103: Two trips, last one is fine
(103, '2023-12-18 10:00:00.000', 'UNLOCK', 34.052235, -118.243683, 100),
(103, '2023-12-18 10:15:00.000', 'LOCK', 34.055123, -118.249911, 92),
(103, '2023-12-18 14:00:00.000', 'UNLOCK', 34.055123, -118.249911, 91),
(103, '2023-12-18 14:10:00.000', 'LOCK', 34.058123, -118.251911, 87),

-- Scooter 104: Another orphaned scooter, last event is a location update
(104, '2023-12-18 11:00:00.000', 'UNLOCK', 40.712776, -74.005974, 75),
(104, '2023-12-18 11:05:00.000', 'LOCATION_UPDATE', 40.713999, -74.008222, 70),

-- Scooter 105: Was orphaned, but was eventually locked later
(105, '2023-12-18 13:00:00.000', 'UNLOCK', 34.052235, -118.243683, 60),
(105, '2023-12-18 13:05:00.000', 'LOCATION_UPDATE', 34.053211, -118.245112, 55),
(105, '2023-12-18 18:00:00.000', 'LOCK', 34.053211, -118.245112, 54);
