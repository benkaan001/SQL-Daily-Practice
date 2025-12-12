CREATE DATABASE IF NOT EXISTS daily_practice_20251205_schema;
USE daily_practice_20251205_schema;

CREATE TABLE bank_transactions (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    amount DECIMAL(10, 2),
    txn_type ENUM('DEPOSIT', 'WITHDRAWAL'),
    txn_time DATETIME
);

INSERT INTO bank_transactions (account_id, amount, txn_type, txn_time) VALUES
-- Account 101: Normal
(101, 500.00, 'DEPOSIT', '2023-12-05 09:00:00'),

-- Account 102: Structuring (Smurfing) - Multiple deposits just under $10,000 threshold
(102, 9500.00, 'DEPOSIT', '2023-12-05 10:00:00'),
(102, 9800.00, 'DEPOSIT', '2023-12-05 12:00:00'),
(102, 9900.00, 'DEPOSIT', '2023-12-05 14:00:00'),

-- Account 103: One large deposit (Normal reporting)
(103, 15000.00, 'DEPOSIT', '2023-12-05 11:00:00');