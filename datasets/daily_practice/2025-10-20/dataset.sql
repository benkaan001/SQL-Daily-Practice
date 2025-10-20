CREATE DATABASE IF NOT EXISTS daily_practice_20251020_schema;
USE daily_practice_20251020_schema;

-- This table logs financial transactions and their subsequent chargeback events.
-- A single original transaction can have multiple chargeback-related events.
CREATE TABLE card_transaction_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    original_transaction_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('TRANSACTION_COMPLETED', 'CHARGEBACK_INITIATED', 'CHARGEBACK_DISPUTE_WON'),
    card_id VARCHAR(50),
    amount DECIMAL(10, 2)
);

INSERT INTO card_transaction_events (original_transaction_id, event_timestamp, event_type, card_id, amount) VALUES
-- Card A: Normal transaction, no chargeback
('txn_A01', '2023-11-01 10:00:00.000', 'TRANSACTION_COMPLETED', 'card_A', 150.00),

-- Card B: Transaction with a single, undisputed chargeback
('txn_B01', '2023-11-02 11:00:00.000', 'TRANSACTION_COMPLETED', 'card_B', 200.00),
('txn_B01', '2023-11-10 14:00:00.000', 'CHARGEBACK_INITIATED', 'card_B', 200.00),

-- Card C: "Chargeback Abuse" - customer charges back, merchant wins dispute, customer charges back again.
('txn_C01', '2023-11-03 12:00:00.000', 'TRANSACTION_COMPLETED', 'card_C', 500.00),
('txn_C01', '2023-11-12 15:00:00.000', 'CHARGEBACK_INITIATED', 'card_C', 500.00), -- First chargeback
('txn_C01', '2023-11-20 16:00:00.000', 'CHARGEBACK_DISPUTE_WON', 'card_C', 500.00), -- Merchant reverses it
('txn_C01', '2023-11-25 17:00:00.000', 'CHARGEBACK_INITIATED', 'card_C', 500.00), -- Second chargeback (abuse)

-- Card D: Merchant wins the dispute, and the issue is resolved.
('txn_D01', '2023-11-04 13:00:00.000', 'TRANSACTION_COMPLETED', 'card_D', 75.50),
('txn_D01', '2023-11-14 18:00:00.000', 'CHARGEBACK_INITIATED', 'card_D', 75.50),
('txn_D01', '2023-11-22 10:00:00.000', 'CHARGEBACK_DISPUTE_WON', 'card_D', 75.50);
