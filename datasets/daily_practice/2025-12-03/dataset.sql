CREATE DATABASE IF NOT EXISTS daily_practice_20251203_schema;
USE daily_practice_20251203_schema;

-- This table logs the timestamp of items being picked from shelves and packed into boxes.
CREATE TABLE warehouse_fulfillment (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    event_timestamp DATETIME,
    event_type ENUM('PICKED', 'PACKED')
);

INSERT INTO warehouse_fulfillment (order_id, item_id, event_timestamp, event_type) VALUES
-- Order 101: Efficient packing
(101, 501, '2023-12-03 08:00:00', 'PICKED'),
(101, 501, '2023-12-03 08:15:00', 'PACKED'),

-- Order 102: Slow packing
(102, 502, '2023-12-03 09:00:00', 'PICKED'),
(102, 503, '2023-12-03 09:05:00', 'PICKED'),
(102, 502, '2023-12-03 10:30:00', 'PACKED'), -- > 1 hour delay
(102, 503, '2023-12-03 10:35:00', 'PACKED'),

-- Order 103: Item picked but never packed (Lost?)
(103, 504, '2023-12-03 11:00:00', 'PICKED');