CREATE DATABASE IF NOT EXISTS daily_practice_20260427_schema;
USE daily_practice_20260427_schema;

-- This table logs temperature readings from smart greenhouse sensors.
-- The sensors are event-driven: they only log a new row when the temperature changes.
CREATE TABLE greenhouse_sensors (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    sensor_id VARCHAR(20),
    recorded_at DATETIME,
    temperature DECIMAL(5, 2)
);

INSERT INTO greenhouse_sensors (sensor_id, recorded_at, temperature) VALUES
-- Greenhouse 1: Stays cool most of the day, with a brief hot spike.
-- (A simple average of these 3 rows is 23.33, which is highly misleading!)
('GH-1', '2026-04-27 08:00:00', 20.00), -- Lasts for 4 hours
('GH-1', '2026-04-27 12:00:00', 30.00), -- Lasts for 2 hours
('GH-1', '2026-04-27 14:00:00', 20.00), -- Lasts for 2 hours

-- Greenhouse 2: Mostly hot all day, with brief cool periods.
('GH-2', '2026-04-27 08:00:00', 25.00), -- Lasts for 1 hour
('GH-2', '2026-04-27 09:00:00', 28.00), -- Lasts for 6 hours
('GH-2', '2026-04-27 15:00:00', 22.00), -- Lasts for 1 hour

-- Greenhouse 3: Frequent, rapid fluctuations
('GH-3', '2026-04-27 08:00:00', 24.00), -- 1 hour
('GH-3', '2026-04-27 09:00:00', 26.00), -- 3 hours
('GH-3', '2026-04-27 12:00:00', 22.00), -- 3.5 hours
('GH-3', '2026-04-27 15:30:00', 28.00); -- 0.5 hours