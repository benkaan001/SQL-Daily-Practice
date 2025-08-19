CREATE DATABASE IF NOT EXISTS daily_practice_20250819_schema;
USE daily_practice_20250819_schema;

-- This table logs peer-to-peer payment transactions.
CREATE TABLE p2p_transactions (
    transaction_id VARCHAR(50) PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    transaction_timestamp DATETIME(3),
    amount DECIMAL(12, 4),
    currency CHAR(3),
    status ENUM('COMPLETED', 'PENDING', 'FAILED', 'FLAGGED_FOR_REVIEW')
);

INSERT INTO p2p_transactions (transaction_id, sender_id, receiver_id, transaction_timestamp, amount, currency, status) VALUES
-- User 101: Velocity check pattern
('txn_001', 101, 201, '2023-11-28 10:00:00.000', 10.00, 'USD', 'COMPLETED'),
('txn_002', 101, 202, '2023-11-28 10:01:00.000', 15.00, 'USD', 'COMPLETED'),
('txn_003', 101, 203, '2023-11-28 10:02:00.000', 20.00, 'USD', 'COMPLETED'),
('txn_004', 101, 204, '2023-11-28 10:02:30.000', 25.00, 'USD', 'COMPLETED'), -- 4th tx in 5 mins
('txn_005', 101, 205, '2023-11-28 10:05:30.000', 30.00, 'USD', 'FLAGGED_FOR_REVIEW'), -- This tx is now outside the 5 min window of the first one

-- Circular transaction pattern: 301 -> 302 -> 303 -> 301
('txn_006', 301, 302, '2023-11-28 14:00:00.000', 500.00, 'EUR', 'COMPLETED'),
('txn_007', 302, 303, '2023-11-28 15:00:00.000', 490.00, 'EUR', 'COMPLETED'), -- 10 EUR fee
('txn_008', 303, 301, '2023-11-28 16:00:00.000', 480.00, 'EUR', 'COMPLETED'), -- Another 10 EUR fee
('txn_009', 302, 301, '2023-11-29 10:00:00.000', 100.00, 'EUR', 'COMPLETED'), -- Breaks the circular pattern (wrong direction)

-- Cross-currency transactions
('txn_010', 401, 501, '2023-11-29 11:00:00.000', 1000.00, 'USD', 'COMPLETED'), -- US to UK
('txn_011', 501, 401, '2023-11-29 12:00:00.000', 750.00, 'GBP', 'COMPLETED'), -- UK to US
('txn_012', 401, 601, '2023-11-29 13:00:00.000', 10000.00, 'USD', 'COMPLETED'), -- US to JP
('txn_013', 601, 401, '2023-11-29 14:00:00.000', 150000.00, 'JPY', 'COMPLETED'), -- JP to US
('txn_014', 501, 601, '2023-11-29 15:00:00.000', 800.00, 'GBP', 'FAILED'), -- UK to JP, failed
('txn_015', 501, 601, '2023-11-29 15:05:00.000', 800.00, 'GBP', 'COMPLETED'), -- UK to JP, success

-- Another user for velocity check
('txn_016', 102, 206, '2023-11-28 18:00:00.000', 5.00, 'USD', 'COMPLETED'),
('txn_017', 102, 207, '2023-11-28 18:01:00.000', 5.00, 'USD', 'COMPLETED'),
('txn_018', 102, 208, '2023-11-28 18:02:00.000', 5.00, 'USD', 'COMPLETED'),
('txn_019', 102, 209, '2023-11-28 18:03:00.000', 5.00, 'USD', 'COMPLETED'); -- Does not hit the threshold of >3
