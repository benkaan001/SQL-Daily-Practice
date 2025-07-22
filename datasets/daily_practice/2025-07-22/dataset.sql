CREATE DATABASE IF NOT EXISTS daily_practice_20250722_schema;
USE daily_practice_20250722_schema;

CREATE TABLE financial_transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    account_id INT,
    transaction_date DATETIME,
    transaction_type ENUM('deposit', 'withdrawal', 'fee', 'interest'),
    amount DECIMAL(10, 2),
    merchant_category VARCHAR(50)
);

INSERT INTO financial_transactions (transaction_id, account_id, transaction_date, transaction_type, amount, merchant_category) VALUES
('TXN001', 101, '2023-05-01 09:15:00', 'deposit', 2500.00, 'Salary'),
('TXN002', 102, '2023-05-01 10:00:00', 'deposit', 1500.00, 'Salary'),
('TXN003', 101, '2023-05-03 12:30:00', 'withdrawal', 150.00, 'Groceries'),
('TXN004', 102, '2023-05-04 18:00:00', 'withdrawal', 250.00, 'Utilities'),
('TXN005', 101, '2023-05-05 08:45:00', 'withdrawal', 1200.00, 'Rent'),
('TXN006', 101, '2023-05-06 19:00:00', 'deposit', 1500.00, 'Consulting Gig'),
('TXN007', 103, '2023-05-07 11:00:00', 'deposit', 5000.00, 'Initial Deposit'),
('TXN008', 102, '2023-05-10 14:20:00', 'withdrawal', 50.00, 'Restaurants'),
('TXN009', 103, '2023-05-12 20:00:00', 'withdrawal', 2500.00, 'Investment'),
('TXN010', 101, '2023-05-15 13:00:00', 'fee', 5.00, 'Bank Fee'),
('TXN011', 103, '2023-05-13 10:00:00', 'deposit', 3000.00, 'Bonus'),
('TXN012', 102, '2023-06-01 09:16:00', 'deposit', 1500.00, 'Salary'),
('TXN013', 101, '2023-06-01 09:18:00', 'deposit', 2500.00, 'Salary'),
('TXN014', 101, '2023-06-02 11:00:00', 'withdrawal', 1200.00, 'Rent'),
('TXN015', 102, '2023-06-05 17:30:00', 'withdrawal', 75.00, 'Entertainment'),
('TXN016', 103, '2023-06-08 16:00:00', 'withdrawal', 150.00, 'Travel'),
('TXN017', 101, '2023-06-10 10:00:00', 'withdrawal', 200.00, 'Shopping'),
('TXN018', 102, '2023-06-15 14:00:00', 'deposit', 25.00, 'Interest'),
('TXN019', 101, '2023-06-15 14:05:00', 'deposit', 35.00, 'Interest'),
('TXN020', 103, '2023-06-20 19:45:00', 'withdrawal', 300.00, 'Restaurants'),
('TXN021', 102, '2023-06-25 12:00:00', 'withdrawal', 1100.00, 'Car Payment'),
('TXN022', 102, '2023-06-26 15:00:00', 'deposit', 1200.00, 'Refund');
