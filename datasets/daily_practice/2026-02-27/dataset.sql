CREATE DATABASE IF NOT EXISTS daily_practice_20260227_schema;
USE daily_practice_20260227_schema;

-- This table logs the active subscription revenue for each user per month.
-- A user only has a record if they had an active subscription in that month.
CREATE TABLE user_subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    billing_month DATE, -- Always the 1st of the month
    mrr_amount DECIMAL(10, 2) -- Monthly Recurring Revenue
);

INSERT INTO user_subscriptions (user_id, billing_month, mrr_amount) VALUES
-- User 101: Retained (No change in MRR)
(101, '2026-01-01', 10.00),
(101, '2026-02-01', 10.00),

-- User 102: Upgraded (Increased MRR)
(102, '2026-01-01', 10.00),
(102, '2026-02-01', 25.00),

-- User 103: Downgraded (Decreased MRR)
(103, '2026-01-01', 50.00),
(103, '2026-02-01', 15.00),

-- User 104: Churned (Had MRR in Jan, missing in Feb)
(104, '2026-01-01', 20.00),

-- User 105: New Customer (Missing in Jan, has MRR in Feb)
(105, '2026-02-01', 30.00),

-- User 106: Irrelevant historical data (Ignore for Jan-Feb comparison)
(106, '2025-12-01', 10.00);