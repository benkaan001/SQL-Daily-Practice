CREATE DATABASE IF NOT EXISTS daily_practice_20250918_schema;
USE daily_practice_20250918_schema;

-- This table logs stock market transactions for various users.
-- The FIFO (First-In, First-Out) accounting principle should be applied for calculating gains/losses.
CREATE TABLE stock_trades (
    trade_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    ticker_symbol VARCHAR(10),
    trade_type ENUM('BUY', 'SELL'),
    quantity INT,
    price_per_share DECIMAL(10, 2),
    trade_timestamp DATETIME(3)
);

INSERT INTO stock_trades (user_id, ticker_symbol, trade_type, quantity, price_per_share, trade_timestamp) VALUES
-- User 101: Simple FIFO case for stock 'AAPL'
(101, 'AAPL', 'BUY', 10, 150.00, '2023-01-10 09:30:00.000'),
(101, 'AAPL', 'BUY', 5, 155.00, '2023-01-15 10:00:00.000'),
(101, 'AAPL', 'SELL', 12, 160.00, '2023-02-01 11:00:00.000'), -- Sells the first 10 shares and 2 from the second buy

-- User 102: Sells all shares, then buys more of the same stock 'GOOG'
(102, 'GOOG', 'BUY', 20, 100.00, '2023-02-05 14:00:00.000'),
(102, 'GOOG', 'SELL', 20, 110.00, '2023-03-01 15:00:00.000'),
(102, 'GOOG', 'BUY', 10, 105.00, '2023-03-10 09:00:00.000'), -- This buy is not part of any realized gain yet

-- User 101: A second, separate stock 'TSLA'
(101, 'TSLA', 'BUY', 5, 200.00, '2023-03-01 12:00:00.000'),
(101, 'TSLA', 'SELL', 3, 220.00, '2023-03-20 13:00:00.000'),

-- User 103: A more complex FIFO case for 'MSFT'
(103, 'MSFT', 'BUY', 50, 300.00, '2023-04-01 10:00:00.000'),
(103, 'MSFT', 'BUY', 30, 310.00, '2023-04-05 11:00:00.000'),
(103, 'MSFT', 'SELL', 60, 320.00, '2023-05-01 14:00:00.000'), -- Sells the first 50 shares and 10 from the second buy
(103, 'MSFT', 'SELL', 10, 325.00, '2023-05-10 15:00:00.000'), -- Sells 10 more from the second buy

-- User 104: No sales, so no realized gains
(104, 'AMZN', 'BUY', 10, 130.00, '2023-06-01 09:00:00.000');
