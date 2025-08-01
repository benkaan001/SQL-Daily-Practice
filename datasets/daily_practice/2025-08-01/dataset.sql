CREATE DATABASE IF NOT EXISTS daily_practice_20250801_schema;
USE daily_practice_20250801_schema;

-- This table contains tick-by-tick stock trade data for several fictional companies.
CREATE TABLE stock_trades (
    trade_id INT PRIMARY KEY AUTO_INCREMENT,
    ticker_symbol VARCHAR(10),
    trade_timestamp DATETIME(3), -- Millisecond precision
    price DECIMAL(10, 4),
    volume INT
);

INSERT INTO stock_trades (ticker_symbol, trade_timestamp, price, volume) VALUES
-- Ticker 'ALPHA' - Stable with one volatile day
('ALPHA', '2023-11-01 09:30:00.123', 150.00, 1000),
('ALPHA', '2023-11-01 10:45:15.456', 150.50, 500),
('ALPHA', '2023-11-01 15:59:59.987', 151.00, 1200),
('ALPHA', '2023-11-02 09:31:00.000', 151.20, 800),
('ALPHA', '2023-11-02 11:00:00.000', 151.50, 900),
('ALPHA', '2023-11-02 15:58:00.000', 151.30, 1100),
('ALPHA', '2023-11-03 09:30:00.000', 152.00, 2000), -- Start of volatile day
('ALPHA', '2023-11-03 10:00:00.000', 155.00, 5000),
('ALPHA', '2023-11-03 12:00:00.000', 148.50, 7000),
('ALPHA', '2023-11-03 15:59:00.000', 149.00, 3000), -- End of volatile day
('ALPHA', '2023-11-04 09:30:00.000', 149.50, 1000),
('ALPHA', '2023-11-04 15:59:00.000', 150.00, 1300),

-- Ticker 'BETA' - Experiences a pump and dump
('BETA', '2023-11-01 10:00:00.000', 20.00, 5000),
('BETA', '2023-11-01 14:00:00.000', 20.50, 6000),
('BETA', '2023-11-02 10:00:00.000', 21.00, 10000), -- Pump starts
('BETA', '2023-11-02 10:05:00.000', 25.00, 25000),
('BETA', '2023-11-02 10:10:00.000', 30.00, 30000), -- Peak of pump
('BETA', '2023-11-02 10:30:00.000', 18.00, 50000), -- Dump
('BETA', '2023-11-02 11:00:00.000', 19.00, 15000),
('BETA', '2023-11-03 13:00:00.000', 19.50, 8000),

-- Ticker 'GAMMA' - Gradual decline leading to a drawdown
('GAMMA', '2023-11-01 09:30:00.000', 300.00, 500), -- Peak price
('GAMMA', '2023-11-01 12:00:00.000', 298.50, 400),
('GAMMA', '2023-11-02 10:00:00.000', 299.00, 600),
('GAMMA', '2023-11-02 14:00:00.000', 295.00, 700),
('GAMMA', '2023-11-03 11:00:00.000', 290.00, 800),
('GAMMA', '2023-11-04 10:00:00.000', 280.00, 1200),
('GAMMA', '2023-11-05 13:00:00.000', 250.00, 2000), -- Trough price
('GAMMA', '2023-11-05 15:00:00.000', 260.00, 1500),
('GAMMA', '2023-11-06 09:45:00.000', 265.00, 900),

-- Ticker 'DELTA' - Another pump and dump example
('DELTA', '2023-11-05 10:00:00.000', 50.00, 20000),
('DELTA', '2023-11-06 10:00:00.000', 52.00, 30000), -- Pump starts
('DELTA', '2023-11-06 10:02:00.000', 60.00, 50000),
('DELTA', '2023-11-06 10:03:00.000', 65.00, 60000), -- Peak
('DELTA', '2023-11-06 10:15:00.000', 45.00, 80000), -- Dump
('DELTA', '2023-11-06 11:00:00.000', 48.00, 40000);
