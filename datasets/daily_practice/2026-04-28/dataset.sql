CREATE DATABASE IF NOT EXISTS daily_practice_20260428_schema;
USE daily_practice_20260428_schema;

-- This table logs inventory purchases and sales.
-- Notice that SELL transactions do not have a unit_price, as their cost 
-- must be derived from the moving average of the inventory on hand at that time.
CREATE TABLE inventory_transactions (
    txn_id INT PRIMARY KEY AUTO_INCREMENT,
    item_sku VARCHAR(20),
    txn_date DATE,
    txn_type ENUM('BUY', 'SELL'),
    quantity INT,
    unit_price DECIMAL(10, 2) -- Only populated for 'BUY' events
);

INSERT INTO inventory_transactions (item_sku, txn_date, txn_type, quantity, unit_price) VALUES
-- Day 1: Initial purchase of 100 units at $10.00 each.
-- WAC is $10.00. Total value is $1000.00.
('WIDGET-X', '2026-04-01', 'BUY', 100, 10.00),

-- Day 5: Buy 50 more units, but the price went up to $16.00 each.
-- Total value is now $1000 + $800 = $1800.
-- New WAC is $1800 / 150 units = $12.00.
('WIDGET-X', '2026-04-05', 'BUY', 50, 16.00),

-- Day 10: Sell 60 units.
-- Cost of Goods Sold is 60 units * $12.00 (current WAC) = $720.00.
-- Remaining value is $1800 - $720 = $1080.00.
-- WAC remains $12.00.
('WIDGET-X', '2026-04-10', 'SELL', 60, NULL),

-- Day 15: Buy 110 units at $14.00 each.
-- New total value is $1080 + $1540 = $2620.00.
-- New WAC is $2620 / 200 units = $13.10.
('WIDGET-X', '2026-04-15', 'BUY', 110, 14.00),

-- Day 20: Sell 50 units.
('WIDGET-X', '2026-04-20', 'SELL', 50, NULL),

-- Day 25: Sell 20 units.
('WIDGET-X', '2026-04-25', 'SELL', 20, NULL);