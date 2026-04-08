CREATE DATABASE IF NOT EXISTS daily_practice_20260408_schema;
USE daily_practice_20260408_schema;

-- This table stores the pricing tiers for a SaaS platform.
CREATE TABLE subscription_plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    monthly_price DECIMAL(10, 2)
);

-- This table logs when a user chooses to upgrade their subscription mid-month.
CREATE TABLE plan_upgrades (
    upgrade_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    upgrade_date DATE,
    old_plan_id INT,
    new_plan_id INT
);

INSERT INTO subscription_plans (plan_id, plan_name, monthly_price) VALUES
(1, 'Basic', 30.00),
(2, 'Pro', 60.00),
(3, 'Max', 120.00);

INSERT INTO plan_upgrades (user_id, upgrade_date, old_plan_id, new_plan_id) VALUES
-- User 101 upgrades exactly halfway through April (a 30-day month)
(101, '2026-04-16', 1, 2),

-- User 102 upgrades with 10 days remaining in April
(102, '2026-04-21', 2, 3),

-- User 103 upgrades on the 2nd day of March (a 31-day month)
(103, '2026-03-02', 1, 3),

-- User 104 upgrades on the very last day of February (a 28-day month)
(104, '2026-02-28', 2, 3);