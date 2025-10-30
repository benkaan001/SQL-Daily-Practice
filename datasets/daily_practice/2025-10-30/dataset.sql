CREATE DATABASE IF NOT EXISTS daily_practice_20251030_schema;
USE daily_practice_20251030_schema;

-- This table logs key events related to user subscriptions.
CREATE TABLE subscription_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM(
        'SUBSCRIBED',             -- A new subscription starts
        'RENEWAL_SUCCESSFUL',     -- A recurring payment was successful
        'PAYMENT_FAILED',         -- A recurring payment failed
        'CANCELLED_BY_USER',      -- User actively clicked 'cancel'
        'SUBSCRIPTION_ENDED_INVOLUNTARILY' -- System ended subscription after failed payments
    ),
    plan_name VARCHAR(50)
);

INSERT INTO subscription_events (user_id, event_timestamp, event_type, plan_name) VALUES
-- User 101: Subscribes, renews, then cancels
(101, '2023-01-15 10:00:00.000', 'SUBSCRIBED', 'Monthly'),
(101, '2023-02-15 10:00:00.000', 'RENEWAL_SUCCESSFUL', 'Monthly'),
(101, '2023-03-15 10:00:00.000', 'RENEWAL_SUCCESSFUL', 'Monthly'),
(101, '2023-03-20 14:00:00.000', 'CANCELLED_BY_USER', 'Monthly'), -- Ends subscription period 1

-- User 102: Subscribes, payment fails, subscription ends
(102, '2023-02-10 11:00:00.000', 'SUBSCRIBED', 'Annual'),
(103, '2023-02-15 11:00:00.000', 'SUBSCRIBED', 'Monthly'), -- User 103 starts
(102, '2023-03-10 11:00:00.000', 'PAYMENT_FAILED', 'Annual'),
(102, '2023-03-17 11:00:00.000', 'PAYMENT_FAILED', 'Annual'),
(102, '2023-03-24 11:00:00.000', 'SUBSCRIPTION_ENDED_INVOLUNTARILY', 'Annual'), -- Ends subscription period 1

-- User 101: Re-subscribes later (starts new period)
(101, '2023-05-01 12:00:00.000', 'SUBSCRIBED', 'Monthly'),
(101, '2023-06-01 12:00:00.000', 'RENEWAL_SUCCESSFUL', 'Monthly'),
-- This subscription is still active

-- User 103: Is still active
(103, '2023-03-15 11:00:00.000', 'RENEWAL_SUCCESSFUL', 'Monthly'),
(103, '2023-04-15 11:00:00.000', 'RENEWAL_SUCCESSFUL', 'Monthly'),
-- This subscription is also still active

-- User 104: Subscribes, payment fails, but then they cancel before the system does
(104, '2023-06-10 09:00:00.000', 'SUBSCRIBED', 'Monthly'),
(104, '2023-07-10 09:00:00.000', 'PAYMENT_FAILED', 'Monthly'),
(104, '2023-07-12 15:00:00.000', 'CANCELLED_BY_USER', 'Monthly'); -- Ends subscription period 1 (Voluntary)

-- User 102: Re-subscribes later
(102, '2023-06-15 10:00:00.000', 'SUBSCRIBED', 'Monthly'),
(102, '2023-07-15 10:00:00.000', 'RENEWAL_SUCCESSFUL', 'Monthly'),
(102, '2023-08-15 10:00:00.000', 'CANCELLED_BY_USER', 'Monthly'); -- Ends subscription period 2
