CREATE DATABASE IF NOT EXISTS daily_practice_20260311_schema;
USE daily_practice_20260311_schema;

-- This table logs lifetime purchases for customers of a grocery delivery app.
CREATE TABLE customer_purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_name VARCHAR(100),
    purchase_date DATE
);

INSERT INTO customer_purchases (customer_id, product_name, purchase_date) VALUES
-- Customer 101: Bought all three (Chips, Salsa, Guac). Should be excluded.
(101, 'Tortilla Chips', '2026-01-15'),
(101, 'Salsa', '2026-01-15'),
(101, 'Guacamole', '2026-02-10'),

-- Customer 102: Bought Chips and Salsa, but NEVER Guac. (TARGET!)
(102, 'Tortilla Chips', '2026-02-01'),
(102, 'Salsa', '2026-02-05'),
(102, 'Paper Towels', '2026-02-20'),

-- Customer 103: Bought Chips, but no Salsa. Should be excluded.
(103, 'Tortilla Chips', '2026-02-15'),
(103, 'Diet Cola', '2026-02-15'),

-- Customer 104: Bought Salsa and Guac, but no Chips. Should be excluded.
(104, 'Salsa', '2026-02-20'),
(104, 'Guacamole', '2026-02-25'),

-- Customer 105: Bought Chips and Salsa multiple times, NEVER Guac. (TARGET!)
(105, 'Tortilla Chips', '2026-01-10'),
(105, 'Salsa', '2026-01-10'),
(105, 'Tortilla Chips', '2026-03-01'),
(105, 'Salsa', '2026-03-01');