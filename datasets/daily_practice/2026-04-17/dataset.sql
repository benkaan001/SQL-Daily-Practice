CREATE DATABASE IF NOT EXISTS daily_practice_20260417_schema;
USE daily_practice_20260417_schema;

-- This table logs individual purchases made by customers.
CREATE TABLE customer_purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_name VARCHAR(100),
    purchase_timestamp DATETIME
);

INSERT INTO customer_purchases (user_id, product_name, purchase_timestamp) VALUES
-- User 101: Starter Kit first, then Refill Pack, then Travel Mug
(101, 'Starter Kit', '2026-04-01 10:00:00'),
(101, 'Refill Pack', '2026-04-15 14:30:00'),
(101, 'Travel Mug', '2026-04-20 09:00:00'),

-- User 102: Starter Kit first, then Advanced Kit
(102, 'Starter Kit', '2026-04-02 11:00:00'),
(102, 'Advanced Kit', '2026-04-10 10:00:00'),

-- User 103: Starter Kit first, then Refill Pack
(103, 'Starter Kit', '2026-04-03 09:30:00'),
(103, 'Refill Pack', '2026-04-18 16:00:00'),

-- User 104: Starter Kit first, but never makes a second purchase (Churned)
(104, 'Starter Kit', '2026-04-04 12:00:00'),

-- User 105: Travel Mug first. They buy a Starter Kit second, but because 
-- it wasn't their FIRST purchase, they should be excluded from the analysis!
(105, 'Travel Mug', '2026-04-05 08:00:00'),
(105, 'Starter Kit', '2026-04-06 13:00:00'),

-- User 106: Starter Kit first, then Refill Pack
(106, 'Starter Kit', '2026-04-06 15:00:00'),
(106, 'Refill Pack', '2026-04-22 11:00:00'),

-- User 107: Starter Kit first, then Advanced Kit
(107, 'Starter Kit', '2026-04-07 10:30:00'),
(107, 'Advanced Kit', '2026-04-25 15:30:00');