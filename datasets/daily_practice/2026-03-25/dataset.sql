CREATE DATABASE IF NOT EXISTS daily_practice_20260325_schema;
USE daily_practice_20260325_schema;

-- This table logs individual sales transactions across different product categories.
CREATE TABLE category_sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50),
    sale_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO category_sales (category, sale_date, amount) VALUES
-- Electronics: Steady growth then a dip
('Electronics', '2026-01-15', 500.00),
('Electronics', '2026-01-20', 500.00), -- Jan Total: 1000
('Electronics', '2026-02-10', 1200.00), -- Feb Total: 1200 (+20%)
('Electronics', '2026-03-05', 900.00),  -- Mar Total: 900 (-25%)

-- Apparel: Flat sales then a spike
('Apparel', '2026-01-10', 500.00), -- Jan Total: 500
('Apparel', '2026-02-15', 500.00), -- Feb Total: 500 (0%)
('Apparel', '2026-03-20', 750.00), -- Mar Total: 750 (+50%)

-- Home Goods: A newer category that started in February
('Home Goods', '2026-02-10', 400.00), -- Feb Total: 400 (First month)
('Home Goods', '2026-03-15', 500.00); -- Mar Total: 500 (+25%)