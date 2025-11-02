CREATE DATABASE IF NOT EXISTS daily_practice_20251101_schema;
USE daily_practice_20251101_schema;

-- This table logs individual forex (foreign exchange) trades made by users.
-- 'BUY' means buying the base currency (e.g., EUR in 'EUR/USD')
-- 'SELL' means selling the base currency.
CREATE TABLE forex_trades (
    trade_id INT PRIMARY KEY AUTO_INCREMENT,
    trader_id INT,
    trade_timestamp DATETIME(3),
    currency_pair VARCHAR(10), -- e.g., 'EUR/USD'
    trade_type ENUM('BUY', 'SELL'),
    amount DECIMAL(12, 2), -- The amount of the base currency
    rate DECIMAL(10, 5) -- The exchange rate (e.g., USD per EUR)
);

INSERT INTO forex_trades (trader_id, trade_timestamp, currency_pair, trade_type, amount, rate) VALUES
-- Trader 101: A quick profitable flip on EUR/USD
(101, '2023-11-20 09:00:15.000', 'EUR/USD', 'BUY', 10000.00, 1.08500),
(101, '2023-11-20 09:30:45.000', 'EUR/USD', 'SELL', 10000.00, 1.08750),

-- Trader 102: Buys, but sells for a loss
(102, '2023-11-20 10:00:00.000', 'GBP/JPY', 'BUY', 5000.00, 182.50000),
(102, '2023-11-20 10:45:00.000', 'GBP/JPY', 'SELL', 5000.00, 182.20000),

-- Trader 103: Buys, but holds for longer than 60 minutes
(103, '2023-11-20 11:00:00.000', 'AUD/USD', 'BUY', 20000.00, 0.65100),
(103, '2023-11-20 12:05:00.000', 'AUD/USD', 'SELL', 20000.00, 0.65500),

-- Trader 101: A quick flip on a different pair (GBP/USD)
(101, '2023-11-21 08:15:00.000', 'GBP/USD', 'BUY', 8000.00, 1.25200),
(101, '2023-11-21 08:30:00.000', 'GBP/USD', 'SELL', 8000.00, 1.25450),

-- Trader 104: Buys, but sells a different amount (not a matching flip)
(104, '2023-11-21 09:00:00.000', 'EUR/JPY', 'BUY', 10000.00, 160.00000),
(104, '2023-11-21 09:10:00.000', 'EUR/JPY', 'SELL', 5000.00, 160.50000),

-- Trader 102: Buys, sells part, then sells the rest (only first sell is a match)
(102, '2023-11-22 14:00:00.000', 'USD/CAD', 'BUY', 5000.00, 1.37000),
(102, '2023-11-22 14:10:00.000', 'USD/CAD', 'SELL', 5000.00, 1.37500),
(102, '2023-11-22 14:20:00.000', 'USD/CAD', 'SELL', 5000.00, 1.37800), -- 2nd sell for the same buy

-- Trader 101: A sell followed by a buy (not the pattern we're looking for)
(101, '2023-11-22 15:00:00.000', 'EUR/USD', 'SELL', 10000.00, 1.09000),
(101, '2023-11-22 15:10:00.000', 'EUR/USD', 'BUY', 10000.00, 1.08800);
