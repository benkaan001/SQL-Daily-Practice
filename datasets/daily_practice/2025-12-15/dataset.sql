CREATE DATABASE IF NOT EXISTS daily_practice_20251215_schema;
USE daily_practice_20251215_schema;

-- This table logs individual item purchases.
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    item_id INT,
    quantity INT,
    order_timestamp DATETIME
);

INSERT INTO order_items (user_id, item_id, quantity, order_timestamp) VALUES
-- User 101: Normal behavior
(101, 500, 1, '2023-12-15 10:00:00'),
(101, 501, 2, '2023-12-15 10:05:00'),

-- User 102: The Scalper (High volume, short time, same item)
(102, 999, 4, '2023-12-15 12:00:00'), -- 999 is the "Hot Item"
(102, 999, 4, '2023-12-15 12:02:00'),
(102, 999, 4, '2023-12-15 12:04:00'),

-- User 103: High volume, but spread out (Normal bulk buyer)
(103, 999, 5, '2023-12-15 08:00:00'),
(103, 999, 5, '2023-12-15 16:00:00');