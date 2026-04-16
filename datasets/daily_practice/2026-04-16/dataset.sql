CREATE DATABASE IF NOT EXISTS daily_practice_20260416_schema;
USE daily_practice_20260416_schema;

-- This table logs every transaction at a busy local coffee shop.
CREATE TABLE cafe_transactions (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    txn_time DATETIME,
    amount DECIMAL(5, 2)
);

INSERT INTO cafe_transactions (txn_time, amount) VALUES
-- The 08:00 to 08:15 block (3 orders, total $15.00)
('2026-04-16 08:02:15', 4.50),
('2026-04-16 08:05:30', 5.00),
('2026-04-16 08:14:59', 5.50),

-- The 08:15 to 08:30 block (2 orders, total $9.00)
('2026-04-16 08:15:00', 3.00),
('2026-04-16 08:29:10', 6.00),

-- The 08:30 to 08:45 block (4 orders, total $22.50) - The peak rush!
('2026-04-16 08:32:00', 4.00),
('2026-04-16 08:35:45', 7.50),
('2026-04-16 08:42:20', 6.50),
('2026-04-16 08:44:00', 4.50),

-- The 09:00 to 09:15 block (1 order, total $5.00) - Note the gap from 8:45 to 9:00
('2026-04-16 09:05:00', 5.00);