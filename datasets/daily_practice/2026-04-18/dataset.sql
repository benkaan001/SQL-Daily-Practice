CREATE DATABASE IF NOT EXISTS daily_practice_20260418_schema;
USE daily_practice_20260418_schema;

-- This table logs individual credit card transactions for users.
CREATE TABLE user_transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    transaction_timestamp DATETIME,
    amount DECIMAL(10, 2),
    merchant_name VARCHAR(50)
);

INSERT INTO user_transactions (user_id, transaction_timestamp, amount, merchant_name) VALUES
-- User 101: Steady small purchases, followed by a massive spike (Clear Anomaly)
(101, '2026-04-01 08:00:00', 10.00, 'Coffee Shop'),
(101, '2026-04-02 08:30:00', 12.50, 'Coffee Shop'),
(101, '2026-04-03 08:15:00', 11.00, 'Coffee Shop'),
(101, '2026-04-04 09:00:00', 9.50, 'Coffee Shop'),
(101, '2026-04-05 08:45:00', 10.50, 'Coffee Shop'),
(101, '2026-04-06 08:20:00', 13.00, 'Coffee Shop'),
(101, '2026-04-18 14:00:00', 450.00, 'Electronics Store'), -- Anomaly!

-- User 102: High variance naturally, so a $220 purchase is mathematically normal for them
(102, '2026-04-01 10:00:00', 50.00, 'Grocery'),
(102, '2026-04-03 12:00:00', 150.00, 'Steakhouse'),
(102, '2026-04-06 15:00:00', 25.00, 'Gas Station'),
(102, '2026-04-08 18:00:00', 200.00, 'Hardware Store'),
(102, '2026-04-10 09:00:00', 80.00, 'Grocery'),
(102, '2026-04-18 16:00:00', 220.00, 'Online Retailer'), -- Not an anomaly (within 2 stddev)

-- User 103: Huge spike, but not enough history yet to establish a statistical baseline
(103, '2026-04-10 11:00:00', 15.00, 'Bookstore'),
(103, '2026-04-12 12:00:00', 15.50, 'Bookstore'),
(103, '2026-04-14 13:00:00', 14.50, 'Bookstore'),
(103, '2026-04-16 14:00:00', 16.00, 'Bookstore'),
(103, '2026-04-18 10:00:00', 200.00, 'Jewelry Store'), -- Spike, but ignored (only 4 prior txns)

-- User 104: Steady medium purchases, then a huge spike
(104, '2026-04-05 09:00:00', 100.00, 'Utility Bill'),
(104, '2026-04-06 09:00:00', 105.00, 'Phone Bill'),
(104, '2026-04-07 09:00:00', 95.00, 'Internet Bill'),
(104, '2026-04-08 09:00:00', 100.00, 'Insurance'),
(104, '2026-04-09 09:00:00', 98.00, 'Subscription'),
(104, '2026-04-18 11:00:00', 1500.00, 'Luxury Travel'); -- Anomaly!