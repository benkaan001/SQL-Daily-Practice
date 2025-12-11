CREATE DATABASE IF NOT EXISTS daily_practice_20251201_schema;
USE daily_practice_20251201_schema;

-- This table logs real-time bidding (RTB) events for digital advertising campaigns.
CREATE TABLE ad_auctions (
    auction_id INT PRIMARY KEY AUTO_INCREMENT,
    campaign_id VARCHAR(50),
    auction_timestamp DATETIME(3),
    bid_amount DECIMAL(10, 2), -- The amount the system bid
    outcome ENUM('WON', 'LOST'),
    clearing_price DECIMAL(10, 2) -- The price actually paid (only populated if WON, usually slightly lower than bid)
);

INSERT INTO ad_auctions (campaign_id, auction_timestamp, bid_amount, outcome, clearing_price) VALUES
-- Campaign A: Low bidder strategy. Lots of losses, cheap wins.
('Camp_A', '2023-12-01 08:00:00.000', 0.40, 'LOST', NULL),
('Camp_A', '2023-12-01 08:01:00.000', 0.45, 'LOST', NULL),
('Camp_A', '2023-12-01 08:02:00.000', 0.48, 'WON', 0.45),
('Camp_A', '2023-12-01 08:03:00.000', 0.90, 'WON', 0.85),
('Camp_A', '2023-12-01 08:04:00.000', 0.30, 'LOST', NULL),
('Camp_A', '2023-12-01 08:05:00.000', 0.80, 'WON', 0.75),

-- Campaign B: Aggressive bidder. High win rate, but expensive.
('Camp_B', '2023-12-01 09:00:00.000', 2.50, 'WON', 2.10),
('Camp_B', '2023-12-01 09:01:00.000', 2.60, 'WON', 2.20),
('Camp_B', '2023-12-01 09:02:00.000', 1.20, 'LOST', NULL), -- Occasional low bid
('Camp_B', '2023-12-01 09:03:00.000', 2.80, 'WON', 2.50),
('Camp_B', '2023-12-01 09:04:00.000', 1.10, 'LOST', NULL),

-- Campaign C: Testing the "Sweet Spot" (Spread across buckets)
('Camp_C', '2023-12-01 10:00:00.000', 0.40, 'LOST', NULL), -- Bucket 0.0-0.5
('Camp_C', '2023-12-01 10:01:00.000', 0.45, 'LOST', NULL), -- Bucket 0.0-0.5

('Camp_C', '2023-12-01 10:05:00.000', 0.60, 'LOST', NULL), -- Bucket 0.5-1.0
('Camp_C', '2023-12-01 10:06:00.000', 0.90, 'WON', 0.80),  -- Bucket 0.5-1.0 (50% Win Rate)

('Camp_C', '2023-12-01 10:10:00.000', 1.20, 'WON', 1.10),  -- Bucket 1.0-1.5
('Camp_C', '2023-12-01 10:11:00.000', 1.30, 'WON', 1.15),  -- Bucket 1.0-1.5 (100% Win Rate)
('Camp_C', '2023-12-01 10:12:00.000', 1.10, 'WON', 1.05);  -- Bucket 1.0-1.5 (100% Win Rate)