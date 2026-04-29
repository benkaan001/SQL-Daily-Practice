CREATE DATABASE IF NOT EXISTS daily_practice_20260429_schema;
USE daily_practice_20260429_schema;

-- This table stores the daily closing prices for various stocks.
CREATE TABLE daily_stock_prices (
    trade_date DATE,
    ticker VARCHAR(10),
    closing_price DECIMAL(10, 2),
    PRIMARY KEY (ticker, trade_date)
);

INSERT INTO daily_stock_prices (trade_date, ticker, closing_price) VALUES
-- Ticker 'DATA': Experiences a dip, a surge, a correction, and another surge.
('2026-04-01', 'DATA', 100.00),
('2026-04-02', 'DATA', 98.00),
('2026-04-03', 'DATA', 95.00),
('2026-04-04', 'DATA', 92.00),
('2026-04-05', 'DATA', 90.00),
('2026-04-06', 'DATA', 88.00),
('2026-04-07', 'DATA', 85.00), -- End of first 7 days
('2026-04-08', 'DATA', 95.00),
('2026-04-09', 'DATA', 105.00), -- First surge pushes short-term avg up
('2026-04-10', 'DATA', 110.00),
('2026-04-11', 'DATA', 115.00),
('2026-04-12', 'DATA', 112.00),
('2026-04-13', 'DATA', 100.00),
('2026-04-14', 'DATA', 95.00),  -- Correction drags short-term avg down
('2026-04-15', 'DATA', 90.00),
('2026-04-16', 'DATA', 95.00),
('2026-04-17', 'DATA', 105.00),
('2026-04-18', 'DATA', 115.00), -- Second surge
('2026-04-19', 'DATA', 120.00),

-- Ticker 'BEAR': Consistently dropping, short-term average is always lower.
('2026-04-01', 'BEAR', 50.00),
('2026-04-02', 'BEAR', 48.00),
('2026-04-03', 'BEAR', 46.00),
('2026-04-04', 'BEAR', 44.00),
('2026-04-05', 'BEAR', 42.00),
('2026-04-06', 'BEAR', 40.00),
('2026-04-07', 'BEAR', 38.00),
('2026-04-08', 'BEAR', 36.00),
('2026-04-09', 'BEAR', 34.00),
('2026-04-10', 'BEAR', 32.00);