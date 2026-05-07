CREATE DATABASE IF NOT EXISTS daily_practice_20260507_schema;
USE daily_practice_20260507_schema;

-- This table stores user accounts and their current security status.
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    account_status ENUM('ACTIVE', 'BLOCKED')
);

-- This table logs peer-to-peer money transfers.
CREATE TABLE transactions (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    amount DECIMAL(10, 2),
    txn_time DATETIME
);

INSERT INTO users (user_id, account_status) VALUES
(101, 'BLOCKED'),
(102, 'ACTIVE'),
(103, 'ACTIVE'),
(104, 'BLOCKED'),
(105, 'ACTIVE'),
(106, 'ACTIVE'),
(107, 'BLOCKED'),
(108, 'ACTIVE'),
(109, 'ACTIVE'),
(110, 'ACTIVE'),
(111, 'ACTIVE'),
(112, 'ACTIVE'),
(113, 'ACTIVE');

INSERT INTO transactions (sender_id, receiver_id, amount, txn_time) VALUES
-- Scenario 1 (The Mule): Blocked 101 sends to Active 102. 
-- 102 then forwards 90% of it to other Active users within 24 hours.
(101, 102, 1000.00, '2026-05-07 10:00:00'),
(102, 103, 500.00, '2026-05-07 12:00:00'),
(102, 113, 400.00, '2026-05-07 15:00:00'),

-- Scenario 2 (Legitimate Use): Blocked 104 sends to Active 105. 
-- 105 forwards some money, but less than the 80% threshold.
(104, 105, 2000.00, '2026-05-07 09:00:00'),
(105, 106, 1000.00, '2026-05-07 14:00:00'),

-- Scenario 3 (Delayed Transfer): Blocked 107 sends to Active 108.
-- 108 forwards 90%, but it happens more than 24 hours later (48+ hours).
(107, 108, 500.00, '2026-05-05 08:00:00'),
(108, 109, 450.00, '2026-05-08 10:00:00'),

-- Scenario 4 (Clean Network): Active 110 sends to Active 111, who sends to Active 112. 
-- No blocked users are involved in this chain.
(110, 111, 1000.00, '2026-05-07 11:00:00'),
(111, 112, 950.00, '2026-05-07 13:00:00');