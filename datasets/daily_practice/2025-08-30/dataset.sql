CREATE DATABASE IF NOT EXISTS daily_practice_20250830_schema;
USE daily_practice_20250830_schema;

-- This table logs sensor readings and events from industrial machines on a factory floor.
CREATE TABLE factory_iot_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    machine_id INT,
    log_timestamp DATETIME(3),
    event_type ENUM('SENSOR_READING', 'STATUS_CHANGE', 'ERROR_ALERT'),
    details JSON
);

INSERT INTO factory_iot_logs (machine_id, log_timestamp, event_type, details) VALUES
-- Machine 101: Normal operation with a brief stop
(101, '2023-12-01 08:00:00.000', 'STATUS_CHANGE', '{"status": "RUNNING"}'),
(101, '2023-12-01 08:00:15.500', 'SENSOR_READING', '{"temperature": 85.5, "vibration": 0.2, "pressure": 150}'),
(101, '2023-12-01 09:30:00.000', 'STATUS_CHANGE', '{"status": "IDLE"}'),
(101, '2023-12-01 09:45:00.000', 'STATUS_CHANGE', '{"status": "RUNNING"}'),
(101, '2023-12-01 12:00:00.000', 'STATUS_CHANGE', '{"status": "OFFLINE"}'),

-- Machine 102: Overheats and triggers an error
(102, '2023-12-01 08:00:00.000', 'STATUS_CHANGE', '{"status": "RUNNING"}'),
(102, '2023-12-01 08:30:00.000', 'SENSOR_READING', '{"temperature": 90.0, "vibration": 0.3, "pressure": 160}'),
(102, '2023-12-01 08:30:45.000', 'SENSOR_READING', '{"temperature": 115.0, "vibration": 1.5, "pressure": 180}'), -- Anomaly
(102, '2023-12-01 08:31:00.000', 'ERROR_ALERT', '{"error_code": "TEMP_HIGH"}'),
(102, '2023-12-01 08:31:05.000', 'STATUS_CHANGE', '{"status": "ERROR"}'),
(102, '2023-12-01 09:00:00.000', 'STATUS_CHANGE', '{"status": "OFFLINE"}'),

-- Machine 103: Pressure warning followed by shutdown
(103, '2023-12-02 10:00:00.000', 'STATUS_CHANGE', '{"status": "RUNNING"}'),
(103, '2023-12-02 10:15:00.000', 'SENSOR_READING', '{"temperature": 88.0, "vibration": 0.25, "pressure": 210}'),
(103, '2023-12-02 10:15:30.000', 'ERROR_ALERT', '{"error_code": "PRESSURE_WARN"}'),
(103, '2023-12-02 10:16:00.000', 'STATUS_CHANGE', '{"status": "SHUTDOWN_MANUAL"}'),

-- Machine 104: Intermittent sensor failure
(104, '2023-12-02 11:00:00.000', 'STATUS_CHANGE', '{"status": "RUNNING"}'),
(104, '2023-12-02 11:10:00.000', 'SENSOR_READING', '{"temperature": 92.0, "vibration": 0.4, "pressure": 155}'),
(104, '2023-12-02 11:10:30.000', 'SENSOR_READING', '{"temperature": null, "vibration": 0.4, "pressure": 156}'), -- Missing data
(104, '2023-12-02 11:11:00.000', 'SENSOR_READING', '{"temperature": 92.5, "vibration": 0.41, "pressure": 155}'),
(104, '2023-12-02 11:11:30.000', 'SENSOR_READING', '{"temperature": null, "vibration": 0.42, "pressure": 154}'),
(104, '2023-12-02 11:12:00.000', 'SENSOR_READING', '{"temperature": 93.0, "vibration": 0.43, "pressure": 155}');
