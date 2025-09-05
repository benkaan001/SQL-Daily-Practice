CREATE DATABASE IF NOT EXISTS daily_practice_20250905_schema;
USE daily_practice_20250905_schema;

-- This table logs real-time location pings from delivery couriers.
CREATE TABLE delivery_pings (
    ping_id INT PRIMARY KEY AUTO_INCREMENT,
    courier_id INT,
    order_id INT, -- NULL if courier is idle
    ping_timestamp DATETIME(3),
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    speed_kmh INT,
    status ENUM('IDLE', 'ASSIGNED', 'EN_ROUTE_TO_PICKUP', 'AT_PICKUP', 'EN_ROUTE_TO_DROPOFF', 'AT_DROPOFF')
);

INSERT INTO delivery_pings (courier_id, order_id, ping_timestamp, latitude, longitude, speed_kmh, status) VALUES
-- Courier 201: Standard delivery followed by a long idle period
(201, 101, '2023-11-25 09:00:00.000', 34.0522, -118.2437, 0, 'ASSIGNED'),
(201, 101, '2023-11-25 09:05:00.000', 34.0522, -118.2437, 0, 'AT_PICKUP'),
(201, 101, '2023-11-25 09:10:00.000', 34.0542, -118.2517, 30, 'EN_ROUTE_TO_DROPOFF'),
(201, 101, '2023-11-25 09:15:00.000', 34.0562, -118.2597, 0, 'AT_DROPOFF'),
(201, NULL, '2023-11-25 09:20:00.000', 34.0562, -118.2597, 0, 'IDLE'),
(201, NULL, '2023-11-25 10:00:00.000', 34.0562, -118.2597, 0, 'IDLE'),
(201, 102, '2023-11-25 10:30:00.000', 34.0562, -118.2597, 0, 'ASSIGNED'),
(201, 102, '2023-11-25 10:35:00.000', 34.0562, -118.2597, 0, 'AT_PICKUP'),

-- Courier 202: Inefficient delivery route
(202, 103, '2023-11-25 11:00:00.000', 34.1000, -118.3000, 0, 'AT_PICKUP'), -- Start
(202, 103, '2023-11-25 11:05:00.000', 34.1200, -118.3000, 40, 'EN_ROUTE_TO_DROPOFF'), -- Goes North
(202, 103, '2023-11-25 11:10:00.000', 34.1000, -118.3200, 40, 'EN_ROUTE_TO_DROPOFF'), -- Goes West
(202, 103, '2023-11-25 11:15:00.000', 34.0800, -118.3000, 40, 'EN_ROUTE_TO_DROPOFF'), -- Goes South
(202, 103, '2023-11-25 11:20:00.000', 34.1000, -118.2800, 0, 'AT_DROPOFF'), -- Arrives East of start (inefficient)

-- Courier 203: Speeding scenario
(203, 104, '2023-11-26 14:00:00.000', 34.0000, -118.4000, 0, 'AT_PICKUP'),
(203, 104, '2023-11-26 14:05:00.000', 34.0100, -118.4100, 55, 'EN_ROUTE_TO_DROPOFF'),
(203, 104, '2023-11-26 14:06:00.000', 34.0200, -118.4200, 65, 'EN_ROUTE_TO_DROPOFF'), -- Speeding 1
(203, 104, '2023-11-26 14:07:00.000', 34.0300, -118.4300, 70, 'EN_ROUTE_TO_DROPOFF'), -- Speeding 2
(203, 104, '2023-11-26 14:08:00.000', 34.0400, -118.4400, 68, 'EN_ROUTE_TO_DROPOFF'), -- Speeding 3 (Alert!)
(203, 104, '2023-11-26 14:09:00.000', 34.0500, -118.4500, 50, 'EN_ROUTE_TO_DROPOFF'),
(203, 104, '2023-11-26 14:10:00.000', 34.0600, -118.4600, 0, 'AT_DROPOFF');
