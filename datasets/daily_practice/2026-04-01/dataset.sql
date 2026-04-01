CREATE DATABASE IF NOT EXISTS daily_practice_20260401_schema;
USE daily_practice_20260401_schema;

-- This table serves as our source of truth for the standard price of items.
CREATE TABLE catalog_prices (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    standard_price DECIMAL(10, 2)
);

-- This table logs all orders placed on April 1st.
CREATE TABLE april_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    order_timestamp DATETIME,
    price_paid DECIMAL(10, 2)
);

INSERT INTO catalog_prices (product_id, product_name, standard_price) VALUES
(101, 'Mechanical Keyboard', 150.00),
(102, 'Wireless Mouse', 80.00),
(103, 'Ultra-Wide Monitor', 400.00),
(104, 'Ergonomic Chair', 250.00);

INSERT INTO april_orders (customer_id, product_id, order_timestamp, price_paid) VALUES
-- Morning: Normal Operations
(501, 101, '2026-04-01 08:15:00', 150.00),
(502, 102, '2026-04-01 08:30:00', 80.00),
(503, 103, '2026-04-01 09:00:00', 360.00), -- 10% standard discount, perfectly normal

-- Mid-Morning: The Glitch Activates! (Prices drop to exactly 1% of the standard price)
(504, 103, '2026-04-01 09:15:00', 4.00),
(505, 104, '2026-04-01 10:05:00', 2.50),
(506, 101, '2026-04-01 11:30:00', 1.50),

-- Afternoon: The glitch is caught and fixed
(507, 102, '2026-04-01 12:00:00', 80.00),
(508, 104, '2026-04-01 12:30:00', 250.00);