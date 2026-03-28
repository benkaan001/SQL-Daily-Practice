CREATE DATABASE IF NOT EXISTS daily_practice_20260328_schema;
USE daily_practice_20260328_schema;

-- This table acts as a Slowly Changing Dimension (SCD), logging every time a product's price changes.
CREATE TABLE price_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    price DECIMAL(10, 2),
    effective_date DATE
);

-- This table logs individual sales, but crucially, it does NOT store the price at the time of sale.
CREATE TABLE product_sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    sale_date DATE,
    quantity INT
);

INSERT INTO price_history (product_id, price, effective_date) VALUES
-- Product 101: Starts at $10, jumps to $12, then goes on a slight sale to $11
(101, 10.00, '2026-01-01'),
(101, 12.00, '2026-03-05'),
(101, 11.00, '2026-03-20'),

-- Product 102: Starts at $50, then permanently drops to $45
(102, 50.00, '2026-01-15'),
(102, 45.00, '2026-03-10');


INSERT INTO product_sales (product_id, sale_date, quantity) VALUES
-- Sales for Product 101
(101, '2026-02-15', 5),  -- Occurs before the first price hike (Price should be $10.00)
(101, '2026-03-10', 2),  -- Occurs during the highest price period (Price should be $12.00)
(101, '2026-03-25', 4),  -- Occurs after the final price drop (Price should be $11.00)

-- Sales for Product 102
(102, '2026-03-01', 1),  -- Occurs before the price drop (Price should be $50.00)
(102, '2026-03-15', 2);  -- Occurs after the price drop (Price should be $45.00)