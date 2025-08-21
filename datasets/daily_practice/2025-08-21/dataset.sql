CREATE DATABASE IF NOT EXISTS daily_practice_20250821_schema;
USE daily_practice_20250821_schema;

-- This table logs user subscriptions to a premium delivery service.
CREATE TABLE subscription_periods (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    start_date DATE,
    end_date DATE -- NULL if the subscription is currently active
);

-- This table logs all orders placed by users.
CREATE TABLE user_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_timestamp DATETIME,
    order_value DECIMAL(10, 2)
);

INSERT INTO subscription_periods (user_id, start_date, end_date) VALUES
-- User 101: Subscribes and stays active
(101, '2023-03-15', NULL),
-- User 102: Subscribes, then churns
(102, '2023-04-01', '2023-06-30'),
-- User 103: Subscribes later
(103, '2023-05-10', NULL),
-- User 104: Subscribes, churns, then re-subscribes
(104, '2023-03-20', '2023-05-20'),
(104, '2023-07-01', NULL),
-- User 105: Never subscribes
(105, NULL, NULL);

INSERT INTO user_orders (user_id, order_timestamp, order_value) VALUES
-- User 101: Orders before and after subscribing
(101, '2023-02-10 10:00:00', 25.00),
(101, '2023-03-01 12:00:00', 30.00),
(101, '2023-03-16 18:00:00', 45.00), -- First order after subscribing
(101, '2023-03-25 19:00:00', 50.00),
(101, '2023-04-10 20:00:00', 55.00),

-- User 102: Orders before, during, and after subscription
(102, '2023-03-05 11:00:00', 20.00),
(102, '2023-04-05 13:00:00', 40.00), -- During subscription
(102, '2023-05-15 14:00:00', 42.00),
(102, '2023-06-20 15:00:00', 38.00), -- Last order before churn
(102, '2023-07-05 16:00:00', 15.00), -- After churn

-- User 103: Orders only after subscribing
(103, '2023-05-12 09:00:00', 60.00),
(103, '2023-06-15 10:00:00', 65.00),

-- User 104: Complex order pattern
(104, '2023-03-01 18:00:00', 18.00), -- Before first sub
(104, '2023-03-25 19:00:00', 35.00), -- During first sub
(104, '2023-04-20 20:00:00', 33.00),
(104, '2023-06-01 10:00:00', 22.00), -- Between subs
(104, '2023-07-02 11:00:00', 50.00), -- During second sub
(104, '2023-07-15 12:00:00', 52.00),

-- User 105: Non-subscriber
(105, '2023-03-10 14:00:00', 15.00),
(105, '2023-04-12 15:00:00', 17.00),
(105, '2023-05-18 16:00:00', 16.00);
