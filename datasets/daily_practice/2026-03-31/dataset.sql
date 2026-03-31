CREATE DATABASE IF NOT EXISTS daily_practice_20260331_schema;
USE daily_practice_20260331_schema;

-- This table defines the registered accounts.
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(50)
);

-- This table logs financial transactions for the accounts.
CREATE TABLE transactions (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    txn_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO accounts (account_id, account_name) VALUES
(101, 'Alice'),
(102, 'Bob'),
(103, 'Charlie');

INSERT INTO transactions (account_id, txn_date, amount) VALUES
-- Alice: Active in Jan and Feb, silent in March
(101, '2026-01-10', 500.00),
(101, '2026-02-15', -100.00),

-- Bob: Silent in Jan, active in Feb and March
(102, '2026-02-05', 200.00),
(102, '2026-03-20', 50.00),

-- Charlie: Active in Jan and March, silent in Feb
(103, '2026-01-25', 1000.00),
(103, '2026-03-10', -200.00);