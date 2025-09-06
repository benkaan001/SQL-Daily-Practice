CREATE DATABASE IF NOT EXISTS daily_practice_20250906_schema;
USE daily_practice_20250906_schema;

-- This table logs IoT sensor readings from different zones in a smart building.
CREATE TABLE smart_building_sensors (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    zone_id VARCHAR(50),
    log_timestamp DATETIME(3),
    sensor_type ENUM('TEMPERATURE', 'HUMIDITY', 'OCCUPANCY'),
    reading DECIMAL(5, 2)
);

INSERT INTO smart_building_sensors (zone_id, log_timestamp, sensor_type, reading) VALUES
-- Zone 'Lobby': Normal operations
('Lobby', '2023-12-10 08:00:00.000', 'TEMPERATURE', 22.50),
('Lobby', '2023-12-10 08:00:00.000', 'HUMIDITY', 45.00),
('Lobby', '2023-12-10 08:00:00.000', 'OCCUPANCY', 10.00),
('Lobby', '2023-12-10 08:05:00.000', 'TEMPERATURE', 22.60),
('Lobby', '2023-12-10 08:05:00.000', 'HUMIDITY', 45.10),
('Lobby', '2023-12-10 08:05:00.000', 'OCCUPANCY', 12.00),

-- Zone 'ConfRoom-A': Faulty HVAC causing fluctuations
('ConfRoom-A', '2023-12-10 09:00:00.000', 'TEMPERATURE', 21.00),
('ConfRoom-A', '2023-12-10 09:00:00.000', 'HUMIDITY', 50.00),
('ConfRoom-A', '2023-12-10 09:01:00.000', 'TEMPERATURE', 23.50), -- Temp spike > 2
('ConfRoom-A', '2023-12-10 09:01:00.000', 'HUMIDITY', 44.00), -- Humidity drop > 5
('ConfRoom-A', '2023-12-10 09:02:00.000', 'TEMPERATURE', 21.20),
('ConfRoom-A', '2023-12-10 09:02:00.000', 'HUMIDITY', 51.00), -- Humidity spike > 5 (Anomaly trigger)
('ConfRoom-A', '2023-12-10 09:03:00.000', 'TEMPERATURE', 24.00), -- Temp spike > 2
('ConfRoom-A', '2023-12-10 09:03:00.000', 'HUMIDITY', 52.00),
('ConfRoom-A', '2023-12-10 09:04:00.000', 'TEMPERATURE', 23.80),
('ConfRoom-A', '2023-12-10 09:04:00.000', 'HUMIDITY', 45.00), -- Humidity drop > 5

-- Zone 'ServerRoom': Stable but high temp
('ServerRoom', '2023-12-10 10:00:00.000', 'TEMPERATURE', 28.00),
('ServerRoom', '2023-12-10 10:00:00.000', 'HUMIDITY', 30.00),
('ServerRoom', '2023-12-10 10:05:00.000', 'TEMPERATURE', 28.10),
('ServerRoom', '2023-12-10 10:05:00.000', 'HUMIDITY', 30.10),

-- Zone 'OpenOffice': Occupancy-driven changes
('OpenOffice', '2023-12-11 13:00:00.000', 'TEMPERATURE', 23.00),
('OpenOffice', '2023-12-11 13:00:00.000', 'HUMIDITY', 48.00),
('OpenOffice', '2023-12-11 13:00:00.000', 'OCCUPANCY', 50.00),
('OpenOffice', '2023-12-11 13:05:00.000', 'OCCUPANCY', 0.00), -- Lunch break
('OpenOffice', '2023-12-11 13:05:00.000', 'TEMPERATURE', 22.00), -- Temp drops
('OpenOffice', '2023-12-11 13:05:00.000', 'HUMIDITY', 47.50);
