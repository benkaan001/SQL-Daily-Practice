CREATE DATABASE IF NOT EXISTS daily_practice_20260327_schema;
USE daily_practice_20260327_schema;

-- This table logs the start and end dates of user subscriptions.
CREATE TABLE user_subscriptions (
    sub_id INT PRIMARY KEY,
    user_id INT,
    plan_name VARCHAR(50),
    start_date DATE,
    end_date DATE
);

INSERT INTO user_subscriptions (sub_id, user_id, plan_name, start_date, end_date) VALUES
-- User 101: Upgraded mid-month, resulting in a partial overlap.
(1, 101, 'Basic', '2026-01-01', '2026-01-31'),
(2, 101, 'Premium', '2026-01-15', '2026-02-14'),

-- User 102: Back-to-back subscriptions (No overlapping days).
(3, 102, 'Basic', '2026-02-01', '2026-02-28'),
(4, 102, 'Premium', '2026-03-01', '2026-03-31'),

-- User 103: A system glitch allowed them to buy the same plan twice, creating an overlap.
(5, 103, 'Pro', '2026-03-01', '2026-03-15'),
(6, 103, 'Pro', '2026-03-10', '2026-03-25'),

-- User 104: Nested overlap (Sub 8 is entirely inside the dates of Sub 7).
(7, 104, 'Basic', '2026-04-01', '2026-04-30'),
(8, 104, 'Pro', '2026-04-05', '2026-04-10'),

-- User 105: Overlaps on the exact same day.
(9, 105, 'Basic', '2026-05-01', '2026-05-15'),
(10, 105, 'Premium', '2026-05-15', '2026-05-30');