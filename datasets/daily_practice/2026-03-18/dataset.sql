CREATE DATABASE IF NOT EXISTS daily_practice_20260318_schema;
USE daily_practice_20260318_schema;

-- This table holds the registered users for a payment app.
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50)
);

-- This table logs peer-to-peer money transfers between users.
-- Assume all users start with a $0.00 balance.
CREATE TABLE transfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    amount DECIMAL(10, 2),
    transfer_date DATETIME
);

INSERT INTO users (user_id, user_name) VALUES
(101, 'Alice'),
(102, 'Bob'),
(103, 'Charlie'),
(104, 'Diana'),
(105, 'Evan'); -- Evan registers but never sends or receives money.

INSERT INTO transfers (sender_id, receiver_id, amount, transfer_date) VALUES
-- Alice sends money to Bob and Charlie
(101, 102, 50.00, '2026-03-18 09:00:00'),
(101, 103, 15.00, '2026-03-18 09:30:00'),

-- Bob sends some of that money to Charlie
(102, 103, 20.00, '2026-03-18 10:00:00'),

-- Diana sends a large amount to Alice
(104, 101, 150.00, '2026-03-18 11:00:00'),

-- Charlie sends money to Diana
(103, 104, 10.00, '2026-03-18 12:00:00');