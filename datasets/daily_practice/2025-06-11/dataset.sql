CREATE DATABASE IF NOT EXISTS ecommerce_20250611_schema;
USE ecommerce_20250611_schema;

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    product_name VARCHAR(100),
    quantity INT,
    price_per_unit DECIMAL(10, 2),
    discount DECIMAL(10, 2),
    total_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, product_name, quantity, price_per_unit, discount, total_amount) VALUES
(1, 101, '2025-06-01', 'Laptop', 1, 1200.00, 100.00, 1100.00),
(2, 102, '2025-06-02', 'Smartphone', 2, 800.00, 50.00, 1550.00),
(3, 103, '2025-06-03', 'Tablet', 3, 300.00, NULL, 900.00),
(4, NULL, '2025-06-04', 'Headphones', 5, 50.00, 25.00, 225.00),
(5, 104, '2025-06-05', 'Monitor', 2, 200.00, 20.00, 380.00),
(6, NULL, '2025-06-06', 'Keyboard', 4, 25.00, NULL, 100.00),
(7, 105, '2025-06-07', 'Mouse', 6, 20.00, 10.00, 110.00),
(8, 106, '2025-06-08', 'Printer', 1, 150.00, 15.00, 135.00),
(9, NULL, '2025-06-09', 'Router', 2, 75.00, 5.00, 145.00),
(10, 107, '2025-06-10', 'Webcam', 3, 40.00, NULL, 120.00),
(11, 108, '2025-06-11', 'Laptop', 1, 1200.00, 100.00, 1100.00),
(12, 109, '2025-06-12', 'Smartphone', 3, 800.00, 75.00, 2325.00),
(13, 110, '2025-06-13', 'Tablet', 2, 300.00, NULL, 600.00),
(14, NULL, '2025-06-14', 'Headphones', 10, 50.00, 50.00, 450.00),
(15, 111, '2025-06-15', 'Monitor', 4, 200.00, 40.00, 760.00),
(16, NULL, '2025-06-16', 'Keyboard', 8, 25.00, NULL, 200.00),
(17, 112, '2025-06-17', 'Mouse', 12, 20.00, 20.00, 220.00),
(18, 113, '2025-06-18', 'Printer', 2, 150.00, 30.00, 270.00),
(19, NULL, '2025-06-19', 'Router', 4, 75.00, 10.00, 290.00),
(20, 114, '2025-06-20', 'Webcam', 6, 40.00, NULL, 240.00);