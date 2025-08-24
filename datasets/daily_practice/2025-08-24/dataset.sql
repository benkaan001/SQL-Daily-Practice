CREATE DATABASE IF NOT EXISTS daily_practice_20250724_schema;
USE daily_practice_20250724_schema;

CREATE TABLE subscription_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME,
    event_type ENUM('subscribed', 'upgraded', 'downgraded', 'cancelled'),
    plan_id VARCHAR(20),
    monthly_price DECIMAL(10, 2)
);

INSERT INTO subscription_events (user_id, event_timestamp, event_type, plan_id, monthly_price) VALUES
-- User 101: Subscribes to Basic, upgrades to Pro, then cancels
(101, '2023-01-15 10:00:00', 'subscribed', 'basic', 9.99),
(101, '2023-03-01 11:30:00', 'upgraded', 'pro', 19.99),
(101, '2023-05-20 14:00:00', 'cancelled', 'pro', 19.99),

-- User 102: Subscribes to Pro, never changes
(102, '2023-01-20 09:00:00', 'subscribed', 'pro', 19.99),

-- User 103: Subscribes to Pro, downgrades to Basic
(103, '2023-02-05 18:00:00', 'subscribed', 'pro', 19.99),
(103, '2023-04-10 16:00:00', 'downgraded', 'basic', 9.99),

-- User 104: Subscribes to Basic, cancels
(104, '2023-02-10 12:00:00', 'subscribed', 'basic', 9.99),
(104, '2023-04-15 09:30:00', 'cancelled', 'basic', 9.99),

-- User 105: Subscribes to Basic, upgrades to Pro
(105, '2023-03-12 15:00:00', 'subscribed', 'basic', 9.99),
(105, '2023-05-01 10:00:00', 'upgraded', 'pro', 19.99),

-- User 106: Subscribes and cancels in the same month
(106, '2023-03-20 13:00:00', 'subscribed', 'basic', 9.99),
(106, '2023-03-28 17:00:00', 'cancelled', 'basic', 9.99),

-- User 107: Subscribes late in the period
(107, '2023-05-25 11:00:00', 'subscribed', 'pro', 19.99);
