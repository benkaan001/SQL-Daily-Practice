-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250620_schema;
USE daily_practice_20250620_schema;


-- Create Accounts Table
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type VARCHAR(50) NOT NULL, -- e.g., 'Checking', 'Savings', 'Credit Card'
    balance DECIMAL(10, 2) NOT NULL,
    open_date DATE NOT NULL
);

-- Insert Data into Accounts Table
INSERT INTO Accounts (account_id, customer_id, account_type, balance, open_date) VALUES
(101, 1, 'Checking', 5000.00, '2022-01-01'),
(102, 1, 'Savings', 12000.00, '2022-01-01'),
(103, 2, 'Checking', 3500.00, '2022-03-15'),
(104, 3, 'Savings', 8000.00, '2022-05-20'),
(105, 4, 'Checking', 1000.00, '2023-01-10'),
(106, 5, 'Savings', 25000.00, '2023-02-01'),
(107, 2, 'Savings', 7000.00, '2023-06-01'),
(108, 6, 'Checking', 1500.00, '2023-07-01'),
(109, 1, 'Credit Card', -500.00, '2023-08-01'); -- Negative balance for credit card

-- Create Transactions Table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_type VARCHAR(50) NOT NULL, -- 'deposit', 'withdrawal', 'transfer', 'payment'
    transaction_description VARCHAR(255), -- Can be NULL
    recipient_account_id INT, -- NULL for deposits/withdrawals, used for transfers
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (recipient_account_id) REFERENCES Accounts(account_id)
);

-- Insert Data into Transactions Table
-- Account 101 (Customer 1, Checking)
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(101, '2024-01-05', 1000.00, 'deposit', 'Salary Deposit', NULL),
(101, '2024-01-10', 150.00, 'withdrawal', 'Grocery Shopping', NULL),
(101, '2024-01-12', 500.00, 'transfer', 'Transfer to Savings', 102),
(101, '2024-01-15', 75.00, 'withdrawal', 'Restaurant Bill', NULL),
(101, '2024-02-01', 200.00, 'payment', 'Credit Card Payment', 109), -- Payment to own credit card
(101, '2024-02-05', 1000.00, 'deposit', 'Bonus', NULL),
(101, '2024-03-01', 50.00, 'withdrawal', 'Coffee', NULL),
(101, '2024-03-10', 300.00, 'transfer', 'Rent Payment', NULL), -- Example of transfer to external, hence NULL recipient_account_id
(101, '2024-04-01', 120.00, 'withdrawal', 'Online Purchase', NULL);

-- Account 102 (Customer 1, Savings)
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(102, '2024-01-12', 500.00, 'deposit', 'From Checking', 101),
(102, '2024-02-20', 100.00, 'withdrawal', 'Emergency Fund', 101), -- Transfer back to checking
(102, '2024-03-01', 20.00, 'deposit', 'Interest Income', NULL);

-- Account 103 (Customer 2, Checking)
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(103, '2024-01-20', 800.00, 'deposit', 'Freelance Work', NULL),
(103, '2024-02-10', 200.00, 'withdrawal', 'Utility Bill', NULL),
(103, '2024-03-05', 100.00, 'transfer', 'Donation', NULL);

-- Account 104 (Customer 3, Savings)
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(104, '2024-01-01', 1500.00, 'deposit', 'Investment Return', NULL),
(104, '2024-04-15', 500.00, 'withdrawal', 'Home Improvement', NULL);

-- Account 105 (Customer 4, Checking) - lower activity
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(105, '2024-02-28', 300.00, 'deposit', NULL, NULL), -- NULL description
(105, '2024-03-15', 50.00, 'withdrawal', 'Parking Fee', NULL);

-- Account 106 (Customer 5, Savings)
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(106, '2024-01-01', 5000.00, 'deposit', 'Large Deposit', NULL),
(106, '2024-05-10', 1000.00, 'transfer', 'To external investment', NULL);

-- Account 107 (Customer 2, Savings) - newly opened
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(107, '2024-06-01', 100.00, 'deposit', 'Birthday Gift', NULL);

-- Account 108 (Customer 6, Checking)
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(108, '2024-07-01', 500.00, 'deposit', 'Initial Deposit', NULL),
(108, '2024-07-05', 20.00, 'withdrawal', 'Snacks', NULL);

-- Account 109 (Customer 1, Credit Card)
INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type, transaction_description, recipient_account_id) VALUES
(109, '2024-01-25', 100.00, 'payment', 'Online Subscription', NULL), -- Credit card charges are usually withdrawals (negative balance)
(109, '2024-02-01', 200.00, 'deposit', 'Payment Received', 101), -- Credit card payment from checking is a deposit on credit card account
(109, '2024-02-15', 75.00, 'payment', 'Utility Bill', NULL); -- Another charge
