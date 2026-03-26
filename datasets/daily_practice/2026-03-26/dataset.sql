CREATE DATABASE IF NOT EXISTS daily_practice_20260326_schema;
USE daily_practice_20260326_schema;

-- This table logs individual purchases made by customers.
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

INSERT INTO customer_orders (customer_id, order_date, order_amount) VALUES
-- Customer 101: Reaches their 3rd order in 40 days
(101, '2026-01-01', 50.00),
(101, '2026-01-15', 45.00),
(101, '2026-02-10', 60.00),
(101, '2026-03-01', 55.00),

-- Customer 102: Only 2 orders (Should be excluded entirely)
(102, '2026-01-10', 100.00),
(102, '2026-02-15', 120.00),

-- Customer 103: Fast adoption, reaches 3rd order in just 9 days
(103, '2026-02-01', 30.00),
(103, '2026-02-05', 35.00),
(103, '2026-02-10', 40.00),

-- Customer 104: Takes a long time (60 days) to reach their 3rd order
(104, '2026-01-05', 80.00),
(104, '2026-02-20', 75.00),
(104, '2026-03-06', 90.00),
(104, '2026-03-15', 85.00);