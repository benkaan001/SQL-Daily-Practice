CREATE DATABASE IF NOT EXISTS daily_practice_20260314_schema;
USE daily_practice_20260314_schema;

-- This table logs marketing ad clicks by users.
CREATE TABLE ad_clicks (
    click_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    click_time DATETIME,
    campaign_name VARCHAR(50)
);

-- This table logs completed purchases.
CREATE TABLE user_purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    purchase_time DATETIME,
    purchase_amount DECIMAL(10, 2)
);

INSERT INTO ad_clicks (user_id, click_time, campaign_name) VALUES
-- User 101: Interacts with two campaigns before buying
(101, '2026-03-10 10:00:00', 'Spring_Sale_Email'),
(101, '2026-03-12 14:00:00', 'Retargeting_Banner'),

-- User 102: One click is very old, one is recent
(102, '2026-03-01 09:00:00', 'Awareness_Video'),
(102, '2026-03-13 10:00:00', 'Search_Brand'),

-- User 104: One click drives multiple subsequent purchases
(104, '2026-03-10 08:00:00', 'Spring_Sale_Email');


INSERT INTO user_purchases (user_id, purchase_time, purchase_amount) VALUES
-- User 101: Purchase should be split 50/50 between their two clicks
(101, '2026-03-13 15:00:00', 120.00),

-- User 102: Purchase should only be attributed to Search_Brand (Awareness is > 7 days old)
(102, '2026-03-14 11:00:00', 50.00),

-- User 103: No ad clicks at all (Organic purchase)
(103, '2026-03-14 12:00:00', 80.00),

-- User 104: Two purchases, both influenced by the same single click
(104, '2026-03-11 09:00:00', 40.00),
(104, '2026-03-15 10:00:00', 60.00);