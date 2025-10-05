CREATE DATABASE IF NOT EXISTS daily_practice_20251004_schema;
USE daily_practice_20251004_schema;

-- This table logs the full lifecycle of user subscriptions to a SaaS product.
CREATE TABLE user_subscriptions (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    subscription_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('SUBSCRIBED', 'UPGRADED', 'DOWNGRADED', 'CANCELLED'),
    plan_id VARCHAR(50),
    monthly_price DECIMAL(10, 2)
);

INSERT INTO user_subscriptions (user_id, subscription_id, event_timestamp, event_type, plan_id, monthly_price) VALUES
-- User 101: Downgrades, then upgrades (a successful win-back)
(101, 'sub_A', '2023-01-15 10:00:00.000', 'SUBSCRIBED', 'pro', 29.99),
(101, 'sub_A', '2023-06-20 14:00:00.000', 'DOWNGRADED', 'basic', 9.99),
(101, 'sub_A', '2023-08-25 11:30:00.000', 'UPGRADED', 'pro', 29.99),

-- User 102: Subscribes, upgrades, then cancels
(102, 'sub_B', '2023-02-10 09:00:00.000', 'SUBSCRIBED', 'basic', 9.99),
(102, 'sub_B', '2023-05-15 18:00:00.000', 'UPGRADED', 'pro', 29.99),
(102, 'sub_B', '2023-09-01 12:00:00.000', 'CANCELLED', 'pro', 29.99),

-- User 103: Downgrades and stays there
(103, 'sub_C', '2023-03-01 11:00:00.000', 'SUBSCRIBED', 'pro', 29.99),
(103, 'sub_C', '2023-07-10 16:00:00.000', 'DOWNGRADED', 'basic', 9.99),

-- User 104: Downgrades, upgrades, then downgrades again
(104, 'sub_D', '2023-04-05 13:00:00.000', 'SUBSCRIBED', 'enterprise', 99.99),
(104, 'sub_D', '2023-08-01 10:00:00.000', 'DOWNGRADED', 'pro', 29.99),
(104, 'sub_D', '2023-09-01 10:00:00.000', 'UPGRADED', 'enterprise', 99.99), -- First win-back
(104, 'sub_D', '2023-10-01 10:00:00.000', 'DOWNGRADED', 'pro', 29.99),

-- User 105: Simple subscription, no changes
(105, 'sub_E', '2023-05-20 17:00:00.000', 'SUBSCRIBED', 'basic', 9.99),

-- User 106: Another successful win-back
(106, 'sub_F', '2023-02-15 09:30:00.000', 'SUBSCRIBED', 'pro', 29.99),
(106, 'sub_F', '2023-04-20 11:00:00.000', 'DOWNGRADED', 'basic', 9.99),
(106, 'sub_F', '2023-04-28 15:00:00.000', 'UPGRADED', 'pro', 29.99);
