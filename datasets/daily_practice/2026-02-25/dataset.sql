CREATE DATABASE IF NOT EXISTS daily_practice_20260225_schema;
USE daily_practice_20260225_schema;

-- This table stores the monthly sales quotas for each sales representative.
CREATE TABLE sales_quotas (
    rep_id INT,
    target_month DATE, -- Always the first of the month
    quota_amount DECIMAL(10, 2)
);

-- This table logs individual sales transactions.
CREATE TABLE sales_transactions (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    rep_id INT,
    sale_date DATE,
    sale_amount DECIMAL(10, 2)
);

INSERT INTO sales_quotas (rep_id, target_month, quota_amount) VALUES
(101, '2026-02-01', 5000.00),
(102, '2026-02-01', 8000.00),
(103, '2026-02-01', 10000.00),
(104, '2026-02-01', 2000.00);

INSERT INTO sales_transactions (rep_id, sale_date, sale_amount) VALUES
-- Rep 101: Hits 5000 on Feb 15
(101, '2026-02-05', 2000.00),
(101, '2026-02-10', 2500.00), -- Running Total: 4500
(101, '2026-02-15', 1000.00), -- Running Total: 5500 (Hits target!)
(101, '2026-02-20', 500.00),  -- Running Total: 6000

-- Rep 102: Hits 8000 on Feb 25
(102, '2026-02-01', 3000.00),
(102, '2026-02-14', 4000.00), -- Running Total: 7000
(102, '2026-02-25', 1500.00), -- Running Total: 8500 (Hits target!)

-- Rep 103: Never hits the 10000 quota
(103, '2026-02-10', 5000.00),
(103, '2026-02-28', 4000.00), -- Running Total: 9000 (Missed target)

-- Rep 104: Hits the 2000 target on their very first sale
(104, '2026-02-02', 2500.00); -- Running Total: 2500 (Hits target!)