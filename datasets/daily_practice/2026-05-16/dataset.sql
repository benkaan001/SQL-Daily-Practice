CREATE DATABASE IF NOT EXISTS daily_practice_20260516_schema;
USE daily_practice_20260516_schema;

-- Tracks every time a product's price was updated in the master catalog.
CREATE TABLE price_ledger (
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    new_price DECIMAL(10, 2),
    change_timestamp DATETIME(3)
);

-- Logs actual customer purchases.
CREATE TABLE sales_transactions (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    price_paid DECIMAL(10, 2),
    txn_timestamp DATETIME(3)
);

INSERT INTO price_ledger (product_id, new_price, change_timestamp) VALUES
(101, 10.00, '2026-05-16 00:00:00.000'),
(101, 12.50, '2026-05-16 10:00:00.000'), -- Price hike at 10 AM
(101, 11.00, '2026-05-16 14:00:00.000'), -- Sale price at 2 PM
(102, 50.00, '2026-05-16 00:00:00.000'),
(102, 45.00, '2026-05-16 12:00:00.000'); -- Discount at Noon

INSERT INTO sales_transactions (product_id, price_paid, txn_timestamp) VALUES
-- Product 101: 
(101, 10.00, '2026-05-16 09:55:00.000'), -- Correct (Pre-hike)
(101, 10.00, '2026-05-16 10:02:00.000'), -- Mismatch (Within 5m grace period)
(101, 10.00, '2026-05-16 10:06:00.000'), -- Mismatch (Critical - after 5m)
(101, 12.50, '2026-05-16 10:30:00.000'), -- Correct
(101, 12.50, '2026-05-16 14:01:00.000'), -- Mismatch (Within 5m grace period)
(101, 11.00, '2026-05-16 15:00:00.000'), -- Correct

-- Product 102:
(102, 50.00, '2026-05-16 11:59:00.000'), -- Correct
(102, 50.00, '2026-05-16 12:04:00.000'), -- Mismatch (Within 5m grace period)
(102, 50.00, '2026-05-16 12:10:00.000'), -- Mismatch (Critical - after 5m)
(102, 45.00, '2026-05-16 13:00:00.000'); -- Correct