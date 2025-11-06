CREATE DATABASE IF NOT EXISTS daily_practice_20251106_schema;
USE daily_practice_20251106_schema;

-- This table logs all product returns from an e-commerce platform.
CREATE TABLE product_returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    user_id INT,
    return_timestamp DATETIME(3),
    purchase_timestamp DATETIME(3),
    return_reason VARCHAR(100),
    product_category VARCHAR(50),
    return_value DECIMAL(10, 2)
);

INSERT INTO product_returns (order_id, product_id, user_id, return_timestamp, purchase_timestamp, return_reason, product_category, return_value) VALUES
-- User 101: The "Serial Returner"
(1001, 10, 101, '2023-10-15 10:00:00.000', '2023-10-01 09:00:00.000', 'Wrong Size', 'Apparel', 150.00),
(1002, 20, 101, '2023-11-01 11:00:00.000', '2023-10-20 10:00:00.000', 'Defective', 'Electronics', 300.00),
(1003, 30, 101, '2023-11-05 14:00:00.000', '2023-11-01 12:00:00.000', 'Changed Mind', 'Home Goods', 100.00),
(1004, 11, 101, '2023-11-06 15:00:00.000', '2023-11-02 13:00:00.000', 'Wrong Size', 'Apparel', 50.00),

-- User 102: High value, but low category diversity
(1005, 21, 102, '2023-10-20 09:00:00.000', '2023-10-05 18:00:00.000', 'Not as Described', 'Electronics', 1000.00),
(1006, 22, 102, '2023-11-01 10:00:00.000', '2023-10-25 11:00:00.000', 'Defective', 'Electronics', 500.00),

-- User 103: High category diversity, but low value
(1007, 40, 103, '2023-10-25 16:00:00.000', '2023-10-15 14:00:00.000', 'Wrong Size', 'Apparel', 50.00),
(1008, 50, 103, '2023-10-26 17:00:00.000', '2023-10-16 15:00:00.000', 'Not Needed', 'Books', 30.00),
(1009, 60, 103, '2023-10-27 18:00:00.000', '2023-10-17 16:00:00.000', 'Changed Mind', 'Toys', 40.00),

-- User 104: Old returns, outside the 90-day window
(1010, 70, 104, '2023-07-01 10:00:00.000', '2023-06-20 09:00:00.000', 'Defective', 'Electronics', 300.00),
(1011, 80, 104, '2023-07-05 11:00:00.000', '2023-06-25 10:00:00.000', 'Wrong Size', 'Apparel', 150.00),
(1012, 90, 104, '2023-07-10 14:00:00.000', '2023-07-01 12:00:00.000', 'Changed Mind', 'Home Goods', 100.00),

-- User 105: No returns
(1013, 100, 105, '2023-11-01 10:00:00.000', '2023-10-25 09:00:00.000', 'Item Arrived Late', 'Groceries', 25.00);