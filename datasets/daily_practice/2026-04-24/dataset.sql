CREATE DATABASE IF NOT EXISTS daily_practice_20260424_schema;
USE daily_practice_20260424_schema;

-- This table logs all incoming traffic sessions to the website.
CREATE TABLE website_visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    visit_timestamp DATETIME,
    traffic_channel VARCHAR(50)
);

-- This table logs completed purchases.
CREATE TABLE sales_conversions (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    sale_timestamp DATETIME,
    revenue DECIMAL(10, 2)
);

INSERT INTO website_visits (user_id, visit_timestamp, traffic_channel) VALUES
-- User 101: Simple non-direct last click
(101, '2026-04-20 10:00:00', 'Paid Search'),
(101, '2026-04-22 14:00:00', 'Organic Search'), 

-- User 102: Direct visits interrupt, should skip back to Social Media
(102, '2026-04-21 09:00:00', 'Social Media'), 
(102, '2026-04-23 10:00:00', 'Direct'),
(102, '2026-04-24 11:00:00', 'Direct'),

-- User 103: Only ever used Direct
(103, '2026-04-22 08:00:00', 'Direct'), 
(103, '2026-04-24 09:00:00', 'Direct'),

-- User 104: Multiple purchases, needs to correctly attribute based on the specific sale time
(104, '2026-04-15 10:00:00', 'Email'),
-- Sale 1 happens here
(104, '2026-04-18 10:00:00', 'Paid Search'),
(104, '2026-04-23 10:00:00', 'Direct');
-- Sale 2 happens here

INSERT INTO sales_conversions (user_id, sale_timestamp, revenue) VALUES
(101, '2026-04-24 15:00:00', 150.00),
(102, '2026-04-24 16:00:00', 200.00),
(103, '2026-04-24 17:00:00', 50.00),
(104, '2026-04-16 12:00:00', 100.00),
(104, '2026-04-24 18:00:00', 300.00),
(105, '2026-04-24 19:00:00', 75.00); -- No prior visits on record