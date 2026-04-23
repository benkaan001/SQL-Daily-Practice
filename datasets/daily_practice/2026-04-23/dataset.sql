CREATE DATABASE IF NOT EXISTS daily_practice_20260423_schema;
USE daily_practice_20260423_schema;

-- This table logs user events within a shopping cart.
CREATE TABLE shopping_cart_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    event_timestamp DATETIME,
    event_type ENUM('ADD_ITEM', 'REMOVE_ITEM', 'CHECKOUT'),
    item_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO shopping_cart_events (session_id, event_timestamp, event_type, item_name, price) VALUES
-- Session sess_01: Adds items and checks out (Not abandoned)
('sess_01', '2026-04-23 10:00:00', 'ADD_ITEM', 'Wireless Mouse', 25.00),
('sess_01', '2026-04-23 10:05:00', 'ADD_ITEM', 'Mechanical Keyboard', 75.00),
('sess_01', '2026-04-23 10:10:00', 'CHECKOUT', NULL, NULL),

-- Session sess_02: Adds items, removes one, then abandons (Abandoned value: $200.00)
('sess_02', '2026-04-23 11:00:00', 'ADD_ITEM', '27-inch Monitor', 200.00),
('sess_02', '2026-04-23 11:05:00', 'ADD_ITEM', 'HD Webcam', 50.00),
('sess_02', '2026-04-23 11:15:00', 'REMOVE_ITEM', 'HD Webcam', 50.00),

-- Session sess_03: Adds and removes everything, abandons (Abandoned value: $0.00 - Should be excluded)
('sess_03', '2026-04-23 12:00:00', 'ADD_ITEM', 'Laptop Stand', 40.00),
('sess_03', '2026-04-23 12:05:00', 'REMOVE_ITEM', 'Laptop Stand', 40.00),

-- Session sess_04: Adds multiple items, no checkout (Abandoned value: $45.00)
('sess_04', '2026-04-23 13:00:00', 'ADD_ITEM', 'USB-C Cable', 15.00),
('sess_04', '2026-04-23 13:05:00', 'ADD_ITEM', 'Phone Case', 30.00),

-- Session sess_05: Adds, removes, adds again, checks out (Not abandoned)
('sess_05', '2026-04-23 14:00:00', 'ADD_ITEM', 'Bluetooth Speaker', 60.00),
('sess_05', '2026-04-23 14:02:00', 'REMOVE_ITEM', 'Bluetooth Speaker', 60.00),
('sess_05', '2026-04-23 14:10:00', 'ADD_ITEM', 'Premium Headphones', 150.00),
('sess_05', '2026-04-23 14:15:00', 'CHECKOUT', NULL, NULL);