CREATE DATABASE IF NOT EXISTS daily_practice_20260228_schema;
USE daily_practice_20260228_schema;

-- This table stores unpaid invoices for customers.
CREATE TABLE unpaid_invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    invoice_date DATE,
    invoice_amount DECIMAL(10, 2)
);

-- This table logs lump-sum payments made by customers.
CREATE TABLE lump_sum_payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10, 2)
);

-- Customer 101 owes $1800 total across 4 invoices.
-- Customer 102 owes $700 total across 2 invoices.
INSERT INTO unpaid_invoices (customer_id, invoice_date, invoice_amount) VALUES
(101, '2026-01-01', 300.00),  
(101, '2026-01-15', 500.00),  
(101, '2026-02-01', 400.00),  
(101, '2026-02-15', 600.00),  
(102, '2026-01-10', 500.00),  
(102, '2026-02-10', 200.00);  

-- Customer 101 makes a $1000 payment.
-- Customer 102 makes an exact $500 payment.
INSERT INTO lump_sum_payments (customer_id, payment_date, payment_amount) VALUES
(101, '2026-02-28', 1000.00),
(102, '2026-02-28', 500.00);