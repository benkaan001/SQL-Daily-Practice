CREATE DATABASE IF NOT EXISTS daily_practice_20260308_schema;
USE daily_practice_20260308_schema;

-- This table stores issued invoices. 
-- By company policy, invoice numbers must be strictly sequential with no gaps.
CREATE TABLE issued_invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_number INT UNIQUE,
    client_name VARCHAR(50),
    issue_date DATE
);

INSERT INTO issued_invoices (invoice_number, client_name, issue_date) VALUES
(1001, 'Acme Corp', '2026-03-01'),
(1002, 'Beta LLC', '2026-03-01'),
(1003, 'Gamma Inc', '2026-03-02'),
-- Alert: Invoices 1004 and 1005 are missing! (Deleted or system error)
(1006, 'Delta Co', '2026-03-03'),
(1007, 'Epsilon Ltd', '2026-03-04'),
-- Alert: Invoice 1008 is missing!
(1009, 'Zeta PLC', '2026-03-05'),
(1010, 'Eta Group', '2026-03-06'),
(1011, 'Theta LLC', '2026-03-06'),
-- Alert: Invoices 1012, 1013, and 1014 are missing!
(1015, 'Iota Inc', '2026-03-08'),
(1016, 'Kappa Corp', '2026-03-08');