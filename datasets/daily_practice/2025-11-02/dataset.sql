CREATE DATABASE IF NOT EXISTS daily_practice_20251102_schema;
USE daily_practice_20251102_schema;

-- This table logs the real-time status changes of delivery drivers.
CREATE TABLE driver_status_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT,
    log_timestamp DATETIME(3),
    -- ONLINE: Driver is active and waiting for orders.
    -- ON_DELIVERY: Driver is currently fulfilling an order.
    -- OFFLINE: Driver is not working.
    status ENUM('ONLINE', 'OFFLINE', 'ON_DELIVERY'),
    current_lat DECIMAL(9, 6),
    current_lon DECIMAL(9, 6)
);

INSERT INTO driver_status_logs (driver_id, log_timestamp, status, current_lat, current_lon) VALUES
-- Driver 101: Works a morning shift, takes a break, works an evening shift
(101, '2023-11-25 08:00:00.000', 'ONLINE', 34.0522, -118.2437),
(101, '2023-11-25 08:30:00.000', 'ON_DELIVERY', 34.0550, -118.2500),
(101, '2023-11-25 09:15:00.000', 'ONLINE', 34.0600, -118.2600),
(101, '2023-11-25 11:30:00.000', 'OFFLINE', 34.0522, -118.2437),
(101, '2023-11-25 17:00:00.000', 'ONLINE', 34.0522, -118.2437),
(101, '2023-11-25 17:30:00.000', 'ON_DELIVERY', 34.0700, -118.2800),
(101, '2023-11-25 18:15:00.000', 'ONLINE', 34.0800, -118.2900),
(101, '2023-11-25 21:00:00.000', 'OFFLINE', 34.0522, -118.2437),

-- Driver 102: Works one long continuous shift
(102, '2023-11-25 10:00:00.000', 'ONLINE', 40.7128, -74.0060),
(102, '2023-11-25 10:30:00.000', 'ON_DELIVERY', 40.7150, -74.0080),
(102, '2023-11-25 11:10:00.000', 'ONLINE', 40.7200, -74.0010),
(102, '2023-11-25 12:00:00.000', 'ON_DELIVERY', 40.7250, -74.0050),
(102, '2023-11-25 12:45:00.000', 'ONLINE', 40.7128, -74.0060),
(102, '2023-11-25 15:00:00.000', 'OFFLINE', 40.7128, -74.0060),

-- Driver 103: Starts a shift that continues past the end of the day
(103, '2023-11-25 18:00:00.000', 'ONLINE', 41.8781, -87.6298),
(103, '2023-11-25 18:45:00.000', 'ON_DELIVERY', 41.8800, -87.6350),
(103, '2023-11-25 19:30:00.000', 'ONLINE', 41.8900, -87.6400),
-- This driver's shift doesn't end on 2023-11-25

-- Driver 104: Only works the next day (should not be in the report)
(104, '2023-11-26 09:00:00.000', 'ONLINE', 34.0522, -118.2437),
(104, '2023-11-26 10:00:00.000', 'OFFLINE', 34.0522, -118.2437),

-- Driver 102: Works the next day as well
(102, '2023-11-26 11:00:00.000', 'ONLINE', 40.7128, -74.0060),
(102, '2023-11-26 14:00:00.000', 'OFFLINE', 40.7128, -74.0060);
