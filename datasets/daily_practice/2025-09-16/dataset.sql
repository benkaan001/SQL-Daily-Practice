CREATE DATABASE IF NOT EXISTS daily_practice_20250916_schema;
USE daily_practice_20250916_schema;

-- This table logs every interaction a user has with the marketing and sales platform.
CREATE TABLE user_touchpoints (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('AD_VIEW', 'AD_CLICK', 'ORGANIC_VISIT', 'PURCHASE'),
    -- campaign_id is only present for ad-related events
    campaign_id VARCHAR(50),
    -- purchase_value is only present for PURCHASE events
    purchase_value DECIMAL(10, 2)
);

INSERT INTO user_touchpoints (user_id, event_timestamp, event_type, campaign_id, purchase_value) VALUES
-- User 101: Simple click-to-purchase journey
(101, '2023-11-01 10:00:00.000', 'AD_CLICK', 'black_friday_23', NULL),
(101, '2023-11-02 11:00:00.000', 'PURCHASE', NULL, 100.00),

-- User 102: Views an ad, but later comes back organically to purchase
(102, '2023-11-01 12:00:00.000', 'AD_VIEW', 'winter_sale_23', NULL),
(102, '2023-11-03 13:00:00.000', 'ORGANIC_VISIT', NULL, NULL),
(102, '2023-11-03 13:05:00.000', 'PURCHASE', NULL, 50.00),

-- User 103: Clicks two different ads, the last click gets the credit
(103, '2023-11-05 09:00:00.000', 'AD_CLICK', 'winter_sale_23', NULL),
(103, '2023-11-06 10:00:00.000', 'AD_CLICK', 'black_friday_23', NULL),
(103, '2023-11-06 10:10:00.000', 'PURCHASE', NULL, 200.00),

-- User 104: A purely organic purchase
(104, '2023-11-07 14:00:00.000', 'ORGANIC_VISIT', NULL, NULL),
(104, '2023-11-07 14:05:00.000', 'PURCHASE', NULL, 75.00),

-- User 101: Second purchase, also attributed to the first click
(101, '2023-11-08 15:00:00.000', 'PURCHASE', NULL, 150.00),

-- User 105: Clicks an ad, but purchases more than 7 days later (should be organic)
(105, '2023-11-10 16:00:00.000', 'AD_CLICK', 'winter_sale_23', NULL),
(105, '2023-11-18 17:00:00.000', 'PURCHASE', NULL, 300.00),

-- User 103: Second purchase, still attributed to the last click
(103, '2023-11-12 11:00:00.000', 'PURCHASE', NULL, 25.00),

-- User 106: Clicks an ad, then makes two purchases within the attribution window
(106, '2023-11-20 09:00:00.000', 'AD_CLICK', 'cyber_monday_23', NULL),
(106, '2023-11-21 10:00:00.000', 'PURCHASE', NULL, 500.00),
(106, '2023-11-22 11:00:00.000', 'PURCHASE', NULL, 600.00);
