CREATE DATABASE IF NOT EXISTS daily_practice_20251125_schema;
USE daily_practice_20251125_schema;

-- This table logs user activity, specifically tracking the date of their first transaction.
CREATE TABLE user_transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    transaction_date DATE,
    transaction_amount DECIMAL(10, 2)
);

-- This table tracks the initial registration date for every user.
CREATE TABLE user_registration (
    user_id INT PRIMARY KEY,
    registration_date DATE,
    acquisition_channel VARCHAR(50)
);

INSERT INTO user_registration (user_id, registration_date, acquisition_channel) VALUES
(101, '2023-01-01', 'Organic'),
(102, '2023-01-05', 'Paid Ad'),
(103, '2023-02-01', 'Organic'),
(104, '2023-03-01', 'Referral');

INSERT INTO user_transactions (user_id, transaction_date, transaction_amount) VALUES
-- User 101: High long-term engagement
(101, '2023-01-01', 50.00), -- Day 0
(101, '2023-01-10', 50.00), -- Day 9
(101, '2023-03-01', 100.00), -- Day 60 (Still buying)
(101, '2023-06-01', 100.00), -- Day 151

-- User 102: Quick initial activity, then churns
(102, '2023-01-05', 20.00), -- Day 0
(102, '2023-01-10', 30.00), -- Day 5
(102, '2023-01-15', 25.00), -- Day 10
(102, '2023-01-20', 10.00), -- Day 15 (No activity after Day 15)

-- User 103: Low initial activity, but buys later
(103, '2023-02-05', 10.00), -- Day 4
(103, '2023-03-05', 15.00), -- Day 32
(103, '2023-06-05', 20.00), -- Day 124

-- User 104: Low initial activity, but has activity 181 days later
(104, '2023-03-05', 5.00), -- Day 4
(104, '2023-09-01', 15.00); -- Day 184 (Active 181 days later)