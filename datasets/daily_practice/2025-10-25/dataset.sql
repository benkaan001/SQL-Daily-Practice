CREATE DATABASE IF NOT EXISTS daily_practice_20251025_schema;
USE daily_practice_20251025_schema;

-- This table logs readings from various IoT sensors, including their expected operating range.
CREATE TABLE iot_sensor_readings (
    reading_id INT PRIMARY KEY AUTO_INCREMENT,
    sensor_id VARCHAR(50),
    reading_timestamp DATETIME(3),
    reading_value DECIMAL(10, 2),
    expected_min DECIMAL(10, 2),
    expected_max DECIMAL(10, 2),
    sensor_type VARCHAR(50)
);

INSERT INTO iot_sensor_readings (sensor_id, reading_timestamp, reading_value, expected_min, expected_max, sensor_type) VALUES
-- Sensor T-001 (Temperature): Stays within range
('T-001', '2023-12-01 10:00:00.000', 25.5, 0.0, 50.0, 'Temperature'),
('T-001', '2023-12-01 10:01:00.000', 26.0, 0.0, 50.0, 'Temperature'),
('T-001', '2023-12-01 10:02:00.000', 25.8, 0.0, 50.0, 'Temperature'),

-- Sensor P-001 (Pressure): Goes below min
('P-001', '2023-12-01 11:00:00.000', 101.3, 100.0, 105.0, 'Pressure'),
('P-001', '2023-12-01 11:01:00.000', 99.8, 100.0, 105.0, 'Pressure'), -- Anomaly (Below Min)
('P-001', '2023-12-01 11:02:00.000', 101.5, 100.0, 105.0, 'Pressure'),

-- Sensor H-001 (Humidity): Goes above max
('H-001', '2023-12-01 12:00:00.000', 60.0, 40.0, 70.0, 'Humidity'),
('H-001', '2023-12-01 12:01:00.000', 72.5, 40.0, 70.0, 'Humidity'), -- Anomaly (Above Max)
('H-001', '2023-12-01 12:02:00.000', 68.0, 40.0, 70.0, 'Humidity'),

-- Sensor T-002 (Temperature): Multiple anomalies, including outside both ranges
('T-002', '2023-12-02 09:00:00.000', 15.0, 10.0, 30.0, 'Temperature'),
('T-002', '2023-12-02 09:01:00.000', 32.5, 10.0, 30.0, 'Temperature'), -- Anomaly (Above Max)
('T-002', '2023-12-02 09:02:00.000', 28.0, 10.0, 30.0, 'Temperature'),
('T-002', '2023-12-02 09:03:00.000', 8.0, 10.0, 30.0, 'Temperature'),  -- Anomaly (Below Min)
('T-002', '2023-12-02 09:04:00.000', 12.0, 10.0, 30.0, 'Temperature'),

-- Sensor P-002 (Pressure): No anomalies
('P-002', '2023-12-02 10:00:00.000', 102.0, 100.0, 105.0, 'Pressure'),
('P-002', '2023-12-02 10:01:00.000', 102.5, 100.0, 105.0, 'Pressure');
