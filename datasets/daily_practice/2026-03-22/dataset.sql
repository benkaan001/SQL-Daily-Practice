CREATE DATABASE IF NOT EXISTS daily_practice_20260322_schema;
USE daily_practice_20260322_schema;

-- This table stores the initial registration data for users.
CREATE TABLE app_users (
    user_id INT PRIMARY KEY,
    signup_date DATE,
    acquisition_channel VARCHAR(50)
);

-- This table logs individual purchases made by customers.
CREATE TABLE user_purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    purchase_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO app_users (user_id, signup_date, acquisition_channel) VALUES
(101, '2026-01-01', 'Organic Search'),
(102, '2026-01-05', 'Paid Social'),
(103, '2026-01-10', 'Referral'),
(104, '2026-01-15', 'Organic Search'),
(105, '2026-01-20', 'Paid Social'),
(106, '2026-02-01', 'Referral');

INSERT INTO user_purchases (user_id, purchase_date, amount) VALUES
-- User 101: Same day purchase, plus a later purchase
(101, '2026-01-01', 50.00),
(101, '2026-01-15', 75.00),

-- User 102: Purchased within 7 days (4 days later)
(102, '2026-01-09', 120.00),

-- User 103: Purchased > 7 days (15 days later)
(103, '2026-01-25', 200.00),

-- User 104: Never purchased (No records in user_purchases)

-- User 105: Same day purchase
(105, '2026-01-20', 30.00),

-- User 106: Purchased > 7 days (19 days later)
(106, '2026-02-20', 15.00);