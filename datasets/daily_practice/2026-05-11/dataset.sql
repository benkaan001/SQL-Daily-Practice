CREATE DATABASE IF NOT EXISTS daily_practice_20260511_schema;
USE daily_practice_20260511_schema;
-- test
-- This table logs delivery orders for a multi-vertical marketplace.
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    store_id INT,
    store_category VARCHAR(100), -- e.g., 'Groceries: Organic', 'Restaurant: Italian'
    courier_id INT,
    customer_id INT,
    order_time DATETIME,
    pickup_time DATETIME,
    delivery_time DATETIME,
    order_value DECIMAL(10, 2)
);

INSERT INTO orders (store_id, store_category, courier_id, customer_id, order_time, pickup_time, delivery_time, order_value) VALUES
(1, 'Restaurant: Italian', 501, 1001, '2026-05-11 10:00:00', '2026-05-11 10:15:00', '2026-05-11 10:35:00', 45.00),
(1, 'Restaurant: Italian', 502, 1002, '2026-05-11 10:05:00', '2026-05-11 10:25:00', '2026-05-11 10:50:00', 30.00),
(2, 'Groceries: Organic', 501, 1003, '2026-05-11 11:00:00', '2026-05-11 11:10:00', '2026-05-11 11:40:00', 85.00),
(1, 'Restaurant: Italian', 503, 1001, '2026-05-11 12:00:00', '2026-05-11 12:10:00', '2026-05-11 12:25:00', 25.00),
(3, 'Restaurant: Burgers', 504, 1004, '2026-05-11 12:30:00', '2026-05-11 12:55:00', '2026-05-11 13:15:00', 40.00),
(2, 'Groceries: Organic', 502, 1005, '2026-05-11 13:00:00', '2026-05-11 13:20:00', '2026-05-11 13:55:00', 120.00),
(1, 'Restaurant: Italian', 501, 1006, '2026-05-11 14:00:00', '2026-05-11 14:15:00', '2026-05-11 14:45:00', 60.00),
(3, 'Restaurant: Burgers', 504, 1001, '2026-05-11 15:00:00', '2026-05-11 15:10:00', '2026-05-11 15:30:00', 15.00),
(2, 'Groceries: Organic', 503, 1002, '2026-05-11 16:00:00', '2026-05-11 16:15:00', '2026-05-11 16:45:00', 95.00),
(1, 'Restaurant: Italian', 502, 1004, '2026-05-11 17:00:00', '2026-05-11 17:30:00', '2026-05-11 18:05:00', 55.00);