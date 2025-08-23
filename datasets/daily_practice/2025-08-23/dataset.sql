CREATE DATABASE IF NOT EXISTS daily_practice_20250823_schema;
USE daily_practice_20250823_schema;

-- This table logs the lifecycle of a food delivery order from creation to courier assignment.
CREATE TABLE delivery_dispatch_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    restaurant_id INT,
    log_timestamp DATETIME(3),
    event_type ENUM('ORDER_CREATED', 'COURIER_ASSIGNED', 'ORDER_PICKED_UP'),
    courier_id INT, -- NULL for ORDER_CREATED events
    details JSON
);

INSERT INTO delivery_dispatch_logs (order_id, restaurant_id, log_timestamp, event_type, courier_id, details) VALUES
-- Order 101: Quick assignment
(101, 1, '2023-12-05 12:00:00.000', 'ORDER_CREATED', NULL, '{"estimated_prep_time_mins": 15}'),
(101, 1, '2023-12-05 12:00:45.500', 'COURIER_ASSIGNED', 501, NULL),
(101, 1, '2023-12-05 12:14:30.000', 'ORDER_PICKED_UP', 501, NULL),

-- Order 102: Slower assignment during rush hour
(102, 2, '2023-12-05 18:30:00.000', 'ORDER_CREATED', NULL, '{"estimated_prep_time_mins": 20}'),
(102, 2, '2023-12-05 18:33:10.200', 'COURIER_ASSIGNED', 502, NULL),
(102, 2, '2023-12-05 18:55:00.000', 'ORDER_PICKED_UP', 502, NULL),

-- Order 103: Courier "hoarding" - accepts but waits to pick up
(103, 1, '2023-12-05 12:05:00.000', 'ORDER_CREATED', NULL, '{"estimated_prep_time_mins": 10}'),
(103, 1, '2023-12-05 12:06:00.000', 'COURIER_ASSIGNED', 501, NULL),
-- Courier 501 waits for another nearby order before picking this one up
(103, 1, '2023-12-05 12:20:00.000', 'ORDER_PICKED_UP', 501, NULL), -- 14 mins after assignment

-- Order 104: Another order for Courier 501
(104, 3, '2023-12-05 12:10:00.000', 'ORDER_CREATED', NULL, '{"estimated_prep_time_mins": 12}'),
(104, 3, '2023-12-05 12:11:00.000', 'COURIER_ASSIGNED', 501, NULL),
(104, 3, '2023-12-05 12:22:00.000', 'ORDER_PICKED_UP', 501, NULL),

-- Order 105: Fast courier during lunch
(105, 2, '2023-12-06 12:30:00.000', 'ORDER_CREATED', NULL, '{"estimated_prep_time_mins": 15}'),
(105, 2, '2023-12-06 12:30:30.000', 'COURIER_ASSIGNED', 503, NULL),
(105, 2, '2023-12-06 12:44:00.000', 'ORDER_PICKED_UP', 503, NULL),

-- Order 106: Slower courier during dinner
(106, 1, '2023-12-06 19:00:00.000', 'ORDER_CREATED', NULL, '{"estimated_prep_time_mins": 18}'),
(106, 1, '2023-12-06 19:04:00.000', 'COURIER_ASSIGNED', 503, NULL),
(106, 1, '2023-12-06 19:25:00.000', 'ORDER_PICKED_UP', 503, NULL),

-- Order 107: Never assigned
(107, 4, '2023-12-06 20:00:00.000', 'ORDER_CREATED', NULL, '{"estimated_prep_time_mins": 25}');
