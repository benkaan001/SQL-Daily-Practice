CREATE DATABASE IF NOT EXISTS daily_practice_20260315_schema;
USE daily_practice_20260315_schema;

-- This table stores the total aggregated revenue for products over the last quarter.
CREATE TABLE product_revenue (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    revenue DECIMAL(10, 2)
);

-- Total Revenue in this table is exactly $10,000.00
INSERT INTO product_revenue (product_id, product_name, revenue) VALUES
(101, 'Laptop Pro Max', 4500.00),
(102, 'Smartphone X1', 3000.00),
(103, 'Noise Cancelling Earbuds', 1000.00),
(104, 'Smartwatch Series 5', 500.00),
(105, '10-inch Tablet', 300.00),
(106, 'Leather Phone Case', 250.00),
(107, 'Fast Charging Cable', 200.00),
(108, 'Tempered Glass Protector', 150.00),
(109, 'HD Webcam', 75.00),
(110, 'Ergonomic Mousepad', 25.00);