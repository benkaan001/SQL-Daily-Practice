CREATE DATABASE IF NOT EXISTS daily_practice_20260310_schema;
USE daily_practice_20260310_schema;

-- This table logs individual purchases made by customers.
CREATE TABLE customer_purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    purchase_date DATE,
    purchase_amount DECIMAL(10, 2)
);

INSERT INTO customer_purchases (customer_id, purchase_date, purchase_amount) VALUES
-- Day 1 (Mar 1): Initial launch, all customers are new.
-- Customer 101 makes two separate purchases on their first day.
(101, '2026-03-01', 50.00),
(102, '2026-03-01', 75.00),
(103, '2026-03-01', 120.00),
(101, '2026-03-01', 30.00), 

-- Day 2 (Mar 2): A mix of new and returning customers.
(104, '2026-03-02', 40.00), -- New customer
(101, '2026-03-02', 60.00), -- Returning
(102, '2026-03-02', 90.00), -- Returning

-- Day 3 (Mar 3): Only new customers today.
(105, '2026-03-03', 15.00), -- New
(106, '2026-03-03', 25.00), -- New

-- Day 4 (Mar 4): Strong retention, only returning customers today.
(103, '2026-03-04', 110.00), -- Returning (Last seen Mar 1)
(104, '2026-03-04', 45.00),  -- Returning (Last seen Mar 2)
(106, '2026-03-04', 35.00);  -- Returning (Last seen Mar 3)