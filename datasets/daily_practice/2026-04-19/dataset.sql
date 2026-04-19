CREATE DATABASE IF NOT EXISTS daily_practice_20260419_schema;
USE daily_practice_20260419_schema;

-- This table stores the current, real-time stock levels in the warehouse.
CREATE TABLE current_inventory (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    stock_on_hand INT
);

-- This table logs incoming customer orders that need to be processed.
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_timestamp DATETIME
);

INSERT INTO current_inventory (product_id, product_name, stock_on_hand) VALUES
(1, 'Wireless Earbuds', 100),
(2, 'Smart Watch', 50),
(3, 'Mechanical Keyboard', 0); -- Out of stock completely

INSERT INTO customer_orders (customer_id, product_id, quantity, order_timestamp) VALUES
-- Wireless Earbuds (Warehouse has 100 in stock)
(101, 1, 40, '2026-04-19 08:00:00'), -- Will be fully fulfilled (60 left)
(102, 1, 50, '2026-04-19 08:15:00'), -- Will be fully fulfilled (10 left)
(103, 1, 30, '2026-04-19 08:30:00'), -- Will be partially fulfilled (Gets 10, backorders 20)
(104, 1, 20, '2026-04-19 09:00:00'), -- Completely backordered

-- Smart Watch (Warehouse has 50 in stock)
(105, 2, 20, '2026-04-19 08:10:00'), -- Will be fully fulfilled (30 left)
(106, 2, 30, '2026-04-19 08:20:00'), -- Will be fully fulfilled (0 left)
(107, 2, 15, '2026-04-19 08:45:00'), -- Completely backordered

-- Mechanical Keyboard (Warehouse has 0 in stock)
(108, 3, 5, '2026-04-19 09:15:00');  -- Completely backordered