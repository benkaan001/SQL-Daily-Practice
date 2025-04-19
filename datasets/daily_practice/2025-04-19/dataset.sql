CREATE DATABASE IF NOT EXISTS daily_practice_20250419_schema;
USE daily_practice_20250419_schema;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_class VARCHAR(30),
    brand_name VARCHAR(30),
    is_low_fat CHAR(1),
    is_recyclable CHAR(1),
    product_category INT,
    product_family VARCHAR(30)
);

CREATE TABLE sales (
    product_id INT,
    promotion_id INT,
    cost_in_dollars INT,
    customer_id INT,
    date_sold DATE,
    units_sold INT
);

INSERT INTO products VALUES
(1, 'ACCESSORIES', 'Fort West', 'N', 'N', 3, 'GADGET'),
(2, 'DRINK', 'Fort West', 'N', 'Y', 2, 'CONSUMABLE'),
(3, 'FOOD', 'Fort West', 'Y', 'N', 1, 'CONSUMABLE'),
(4, 'DRINK', 'Golden', 'Y', 'Y', 3, 'CONSUMABLE'),
(5, 'FOOD', 'Golden', 'Y', 'N', 2, 'CONSUMABLE'),
(6, 'FOOD', 'Lucky Joe', 'N', 'Y', 3, 'CONSUMABLE'),
(7, 'ELECTRONICS', 'Lucky Joe', 'N', 'Y', 2, 'GADGET'),
(8, 'FURNITURE', 'Lucky Joe', 'N', 'Y', 3, 'GADGET'),
(9, 'ELECTRONICS', 'Lucky Joe', 'N', 'Y', 2, 'GADGET'),
(10, 'FURNITURE', 'American Home', 'N', 'Y', 2, 'GADGET'),
(11, 'FURNITURE', 'American Home', 'N', 'Y', 3, 'GADGET'),
(12, 'ELECTRONICS', 'American Home', 'N', 'Y', 3, 'ACCESSORY');

INSERT INTO sales VALUES
(1, 1, 2, 1, '2022-04-01', 4),
(3, 3, 6, 3, '2022-05-24', 6),
(1, 2, 2, 10, '2022-05-01', 3),
(1, 2, 3, 2, '2022-05-01', 9),
(2, 2, 10, 2, '2022-05-01', 1),
(9, 3, 1, 2, '2022-05-31', 5),
(6, 1, 4, 1, '2022-04-07', 8),
(6, 2, 2, 1, '2022-05-01', 12),
(3, 3, 5, 1, '2022-05-25', 4),
(3, 3, 6, 2, '2022-05-25', 6),
(3, 3, 7, 3, '2022-05-25', 7),
(2, 2, 12, 3, '2022-05-01', 1),
(8, 2, 4, 3, '2022-05-01', 4),
(9, 1, 1, 10, '2022-04-07', 2),
(9, 5, 2, 3, '2022-04-06', 20),
(10, 1, 3, 2, '2022-04-07', 4),
(10, 1, 3, 1, '2022-04-01', 5),
(3, 1, 6, 1, '2022-04-02', 10),
(2, 1, 10, 10, '2022-04-04', 8),
(2, 1, 11, 3, '2022-04-05', 6),
(4, 2, 2, 2, '2022-05-02', 7),
(5, 2, 8, 1, '2022-05-02', 7),
(2, 3, 13, 1, '2022-05-30', 3),
(1, 1, 2, 2, '2022-04-07', 3),
(10, 2, 2, 3, '2022-05-02', 9),
(11, 1, 5, 1, '2022-04-03', 9),
(5, 1, 7, 10, '2022-04-02', 9),
(5, 4, 8, 1, '2022-06-06', 8),
(1, 1, 2, 2, '2022-04-02', 9),
(5, 2, 8, 15, '2022-05-01', 2),
(8, 2, 4, 3, '2022-05-11', 1),
(8, 2, 4, 3, '2022-06-11', 1);
