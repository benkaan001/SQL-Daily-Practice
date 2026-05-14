CREATE DATABASE IF NOT EXISTS daily_practice_20260515_schema;
USE daily_practice_20260515_schema;

-- This table logs individual trades executed on a crypto exchange.
CREATE TABLE trade_ledger (
    trade_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    asset_id VARCHAR(10), -- e.g., 'BTC', 'ETH'
    trade_timestamp DATETIME(3),
    trade_type ENUM('BUY', 'SELL'),
    quantity DECIMAL(18, 8),
    price_usd DECIMAL(18, 2)
);

INSERT INTO trade_ledger (user_id, asset_id, trade_timestamp, trade_type, quantity, price_usd) VALUES
-- User 101: A clear wash trade pattern (Sell then Buy back immediately)
(101, 'BTC', '2026-05-15 10:00:00.000', 'SELL', 0.50000000, 65000.00),
(101, 'BTC', '2026-05-15 10:02:30.000', 'BUY',  0.50100000, 65050.00), -- Within 5 mins, quantity matches within 10%

-- User 101: Another wash trade (Buy then Sell)
(101, 'ETH', '2026-05-15 11:00:00.000', 'BUY',  10.00000000, 3500.00),
(101, 'ETH', '2026-05-15 11:04:59.000', 'SELL', 9.95000000, 3495.00), -- Within 5 mins, quantity matches

-- User 102: Normal trading (Sell, then Buy much later)
(102, 'BTC', '2026-05-15 09:00:00.000', 'SELL', 1.00000000, 64000.00),
(102, 'BTC', '2026-05-15 12:00:00.000', 'BUY',  1.00000000, 66000.00), -- 3 hours later (Not a wash trade)

-- User 103: Quantity mismatch
(103, 'SOL', '2026-05-15 14:00:00.000', 'SELL', 100.00000000, 150.00),
(103, 'SOL', '2026-05-15 14:01:00.000', 'BUY',  10.00000000, 151.00), -- Within 5 mins, but quantities don't match (100 vs 10)

-- User 104: High frequency wash trading
(104, 'ETH', '2026-05-15 15:00:00.000', 'SELL', 5.00000000, 3500.00),
(104, 'ETH', '2026-05-15 15:01:00.000', 'BUY',  5.00000000, 3500.00), -- Wash 1
(104, 'ETH', '2026-05-15 15:10:00.000', 'SELL', 2.00000000, 3510.00),
(104, 'ETH', '2026-05-15 15:12:00.000', 'BUY',  2.10000000, 3510.00); -- Wash 2