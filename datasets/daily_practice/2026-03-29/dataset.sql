CREATE DATABASE IF NOT EXISTS daily_practice_20260329_schema;
USE daily_practice_20260329_schema;

-- This table logs the total daily revenue for a boutique retail store.
-- The store is closed on certain days (like Sundays or holidays), meaning 
-- those dates simply do not exist in the table.
CREATE TABLE daily_store_sales (
    sales_date DATE PRIMARY KEY,
    revenue DECIMAL(10, 2)
);

INSERT INTO daily_store_sales (sales_date, revenue) VALUES
('2026-03-02', 100.00), -- Monday
('2026-03-03', 150.00), -- Tuesday
('2026-03-04', 200.00), -- Wednesday
-- CLOSED on Thursday, March 5th (Staff Training)
('2026-03-06', 300.00), -- Friday
('2026-03-07', 250.00), -- Saturday
-- CLOSED on Sunday, March 8th
('2026-03-09', 400.00), -- Monday
('2026-03-10', 100.00), -- Tuesday
('2026-03-11', 350.00); -- Wednesday