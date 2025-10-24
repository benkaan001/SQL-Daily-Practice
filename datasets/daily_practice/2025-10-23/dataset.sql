CREATE DATABASE IF NOT EXISTS daily_practice_20251023_schema;
USE daily_practice_20251023_schema;

-- This table logs every time a user changes their subscription plan on a streaming service.
CREATE TABLE subscription_plan_changes (
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    change_date DATE,
    -- 'previous_plan' is NULL for a new user's first-ever plan.
    previous_plan VARCHAR(50),
    new_plan VARCHAR(50)
);

INSERT INTO subscription_plan_changes (user_id, change_date, previous_plan, new_plan) VALUES
-- User 101: Upgrades and then downgrades
(101, '2023-01-15', NULL, 'Basic'),
(101, '2023-03-20', 'Basic', 'Standard'),
(101, '2023-05-10', 'Standard', 'Premium'),
(101, '2023-09-05', 'Premium', 'Standard'),

-- User 102: Downgrades, then cancels
(102, '2023-02-10', NULL, 'Premium'),
(102, '2023-06-15', 'Premium', 'Basic'),
(102, '2023-07-20', 'Basic', 'Cancelled'),

-- User 103: Starts, cancels, then re-subscribes
(103, '2023-03-01', NULL, 'Standard'),
(103, '2023-04-01', 'Standard', 'Cancelled'),
(103, '2023-08-15', 'Cancelled', 'Standard'),
(103, '2023-10-01', 'Standard', 'Premium'),

-- User 104: Multiple changes, ends on Premium
(104, '2023-01-20', NULL, 'Basic'),
(104, '2023-02-20', 'Basic', 'Standard'),
(104, '2023-06-30', 'Standard', 'Basic'), -- Downgrade
(104, '2023-08-20', 'Basic', 'Standard'), -- Upgrade
(104, '2023-11-01', 'Standard', 'Premium'), -- Upgrade

-- User 105: Stays on the same plan
(105, '2023-05-05', NULL, 'Premium'),

-- User 106: Cancels immediately
(106, '2023-06-10', NULL, 'Basic'),
(106, '2023-06-11', 'Basic', 'Cancelled'),

-- User 107: Starts with Standard, no other changes
(107, '2023-07-01', NULL, 'Standard'),

-- User 108: Churns and returns to a different plan
(108, '2023-02-05', NULL, 'Premium'),
(108, '2023-05-10', 'Premium', 'Cancelled'),
(108, '2023-10-15', 'Cancelled', 'Basic');
