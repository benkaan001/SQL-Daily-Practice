CREATE DATABASE IF NOT EXISTS daily_practice_20250908_schema;
USE daily_practice_20250908_schema;

-- This table logs credit card transaction events, from initial authorization to final settlement.
CREATE TABLE card_transaction_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_id VARCHAR(50),
    card_id VARCHAR(50),
    merchant_id VARCHAR(50),
    amount DECIMAL(10, 2),
    event_timestamp DATETIME(3),
    event_type ENUM('AUTH_REQUEST', 'AUTH_SUCCESS', 'AUTH_DECLINE', 'CAPTURE', 'REFUND')
);

INSERT INTO card_transaction_events (transaction_id, card_id, merchant_id, amount, event_timestamp, event_type) VALUES
-- Transaction 101: Standard, successful authorization and capture
('txn_101', 'card_A', 'merchant_1', 50.00, '2023-12-01 10:00:00.000', 'AUTH_SUCCESS'),
('txn_101', 'card_A', 'merchant_1', 50.00, '2023-12-01 10:05:00.000', 'CAPTURE'),

-- Transaction 102: Authorized, but never captured (expires)
('txn_102', 'card_B', 'merchant_2', 75.00, '2023-12-02 11:00:00.000', 'AUTH_SUCCESS'),

-- Transaction 103: Captured and then fully refunded
('txn_103', 'card_A', 'merchant_3', 120.00, '2023-12-03 14:00:00.000', 'AUTH_SUCCESS'),
('txn_103', 'card_A', 'merchant_3', 120.00, '2023-12-03 14:10:00.000', 'CAPTURE'),
('txn_103', 'card_A', 'merchant_3', 120.00, '2023-12-05 09:00:00.000', 'REFUND'),

-- Transaction 104: Authorized, then captured for a different amount (e.g., tip adjustment)
('txn_104', 'card_C', 'merchant_1', 25.00, '2023-12-04 18:00:00.000', 'AUTH_SUCCESS'),
('txn_104', 'card_C', 'merchant_1', 30.00, '2023-12-04 18:30:00.000', 'CAPTURE'),

-- Transaction 105: Declined authorization
('txn_105', 'card_D', 'merchant_4', 200.00, '2023-12-05 15:00:00.000', 'AUTH_DECLINE'),

-- Transaction 106: Another expired authorization, close to the 7-day cutoff
('txn_106', 'card_B', 'merchant_3', 500.00, '2023-11-25 12:00:00.000', 'AUTH_SUCCESS');
