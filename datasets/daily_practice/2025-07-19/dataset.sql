CREATE DATABASE IF NOT EXISTS daily_practice_20250719_schema;
USE daily_practice_20250719_schema;

CREATE TABLE sales_data (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10, 2),
    transaction_date DATE
);

INSERT INTO sales_data (transaction_id, customer_id, product_id, product_name, category, quantity, price_per_unit, transaction_date) VALUES
-- January Data
(1, 101, 1001, 'Laptop', 'Electronics', 1, 1200.00, '2023-01-10'),
(2, 102, 2001, 'Coffee Maker', 'Home & Kitchen', 2, 29.99, '2023-01-12'),
(3, 103, 1002, 'Wireless Mouse', 'Electronics', 5, 19.99, '2023-01-15'),
(4, 101, 1002, 'Wireless Mouse', 'Electronics', 1, 19.99, '2023-01-25'),
(5, 104, 2002, 'Air Fryer', 'Home & Kitchen', 1, 79.99, '2023-01-28'),
(6, 105, 1001, 'Laptop', 'Electronics', 1, 1200.00, '2023-01-29'),
(7, 103, 2001, 'Coffee Maker', 'Home & Kitchen', 5, 29.99, '2023-01-30'),

-- February Data
(8, 101, 3001, 'T-Shirt', 'Apparel', 10, 24.99, '2023-02-05'),
(9, 106, 4001, 'Action Figure', 'Toys & Games', 15, 19.99, '2023-02-10'),
(10, 102, 1003, '4K Monitor', 'Electronics', 5, 499.99, '2023-02-15'),
(11, 104, 3002, 'Jeans', 'Apparel', 5, 49.99, '2023-02-20'),
(12, 107, 3001, 'T-Shirt', 'Apparel', 10, 24.99, '2023-02-22'),

-- March Data
(13, 101, 5001, 'SQL for Dummies', 'Books', 20, 12.99, '2023-03-01'),
(14, 104, 2002, 'Air Fryer', 'Home & Kitchen', 3, 79.99, '2023-03-05'),
(15, 108, 2003, 'Blender', 'Home & Kitchen', 2, 49.99, '2023-03-10'),
(16, 102, 2003, 'Blender', 'Home & Kitchen', 7, 49.99, '2023-03-28'),

-- Extra data to meet question criteria
(17, 101, 1003, '4K Monitor', 'Electronics', 1, 499.99, '2023-03-12'),
(18, 104, 3002, 'Jeans', 'Apparel', 10, 49.99, '2023-03-24');
