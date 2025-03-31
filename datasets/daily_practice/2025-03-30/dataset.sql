-- Create the database and table for a loans dataset
CREATE DATABASE IF NOT EXISTS daily_practice_20250330_schema;
USE daily_practice_20250330_schema;

-- Loans table with basic loan details
CREATE TABLE loans (
    id INT PRIMARY KEY,
    balance DECIMAL(10,2),
    interest_rate DECIMAL(4,2),
    rate_type VARCHAR(20),
    loan_id INT
);

-- Insert sample loan data
INSERT INTO loans (id, balance, interest_rate, rate_type, loan_id) VALUES
(1, 5229.12, 8.75, 'variable', 2),
(2, 12727.52, 11.37, 'fixed', 4),
(3, 14996.58, 8.25, 'fixed', 9),
(4, 21149.00, 4.75, 'variable', 7),
(5, 14379.00, 3.75, 'variable', 5),
(6, 6221.12, 6.75, 'variable', 11);