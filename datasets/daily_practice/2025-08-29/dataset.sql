CREATE DATABASE IF NOT EXISTS daily_practice_20250829_schema;
USE daily_practice_20250829_schema;

-- This table logs financial transactions, including their status and type.
CREATE TABLE financial_ledger (
    transaction_id VARCHAR(50) PRIMARY KEY,
    account_id INT,
    transaction_timestamp DATETIME(3),
    transaction_type ENUM('DEPOSIT', 'WITHDRAWAL', 'TRANSFER_OUT', 'TRANSFER_IN'),
    amount DECIMAL(12, 4),
    currency CHAR(3),
    status ENUM('COMPLETED', 'PENDING', 'FAILED'),
    details JSON
);

INSERT INTO financial_ledger (transaction_id, account_id, transaction_timestamp, transaction_type, amount, currency, status, details) VALUES
-- Account 101: Running balance with pending transactions
('txn_01', 101, '2023-10-01 10:00:00.000', 'DEPOSIT', 1000.00, 'USD', 'COMPLETED', NULL),
('txn_02', 101, '2023-10-02 11:00:00.000', 'WITHDRAWAL', 100.00, 'USD', 'COMPLETED', NULL),
('txn_03', 101, '2023-10-03 12:00:00.000', 'DEPOSIT', 500.00, 'USD', 'PENDING', NULL), -- Pending deposit
('txn_04', 101, '2023-10-04 13:00:00.000', 'WITHDRAWAL', 200.00, 'USD', 'COMPLETED', NULL),
('txn_05', 101, '2023-10-05 14:00:00.000', 'DEPOSIT', 500.00, 'USD', 'COMPLETED', '{"source_txn_id": "txn_03"}'), -- Completion of the pending deposit

-- Account 201 & 202: Money laundering pattern (structuring)
('txn_06', 201, '2023-10-10 09:00:00.000', 'DEPOSIT', 9500.00, 'USD', 'COMPLETED', NULL), -- Large initial deposit
('txn_07', 201, '2023-10-10 09:05:00.000', 'TRANSFER_OUT', 3000.00, 'USD', 'COMPLETED', '{"destination_account": 202}'),
('txn_08', 201, '2023-10-10 09:10:00.000', 'TRANSFER_OUT', 3000.00, 'USD', 'COMPLETED', '{"destination_account": 203}'),
('txn_09', 201, '2023-10-10 09:15:00.000', 'TRANSFER_OUT', 3500.00, 'USD', 'COMPLETED', '{"destination_account": 204}'),
('txn_10', 202, '2023-10-11 10:00:00.000', 'DEPOSIT', 5000.00, 'USD', 'COMPLETED', NULL), -- Unrelated deposit
('txn_11', 202, '2023-10-11 10:05:00.000', 'TRANSFER_OUT', 2000.00, 'USD', 'COMPLETED', '{"destination_account": 205}'),
('txn_12', 202, '2023-10-11 10:10:00.000', 'TRANSFER_OUT', 3000.00, 'USD', 'COMPLETED', '{"destination_account": 206}'),

-- Accounts 301, 302, 303: Currency arbitrage opportunity
('txn_13', 301, '2023-10-15 10:00:00.000', 'TRANSFER_OUT', 1000.00, 'USD', 'COMPLETED', '{"destination_account": 302, "destination_currency": "EUR"}'),
('txn_14', 302, '2023-10-15 10:00:00.000', 'TRANSFER_IN', 920.00, 'EUR', 'COMPLETED', '{"source_account": 301, "source_currency": "USD"}'),
('txn_15', 302, '2023-10-15 11:00:00.000', 'TRANSFER_OUT', 920.00, 'EUR', 'COMPLETED', '{"destination_account": 303, "destination_currency": "GBP"}'),
('txn_16', 303, '2023-10-15 11:00:00.000', 'TRANSFER_IN', 782.00, 'GBP', 'COMPLETED', '{"source_account": 302, "source_currency": "EUR"}'),
('txn_17', 303, '2023-10-15 12:00:00.000', 'TRANSFER_OUT', 782.00, 'GBP', 'COMPLETED', '{"destination_account": 301, "destination_currency": "USD"}'),
('txn_18', 301, '2023-10-15 12:00:00.000', 'TRANSFER_IN', 1016.60, 'USD', 'COMPLETED', '{"source_account": 303, "source_currency": "GBP"}'); -- 1016.60 > 1000, arbitrage!
