CREATE DATABASE IF NOT EXISTS daily_practice_20260321_schema;
USE daily_practice_20260321_schema;

-- This table stores current market prices for various assets.
CREATE TABLE stock_prices (
    ticker VARCHAR(10) PRIMARY KEY,
    price DECIMAL(10, 2)
);

-- This table logs the current number of shares each investor holds.
CREATE TABLE portfolio_holdings (
    investor_id INT,
    ticker VARCHAR(10),
    shares INT,
    PRIMARY KEY (investor_id, ticker)
);

-- This table stores the target percentage allocation an investor wants for their portfolio.
CREATE TABLE target_allocations (
    investor_id INT,
    ticker VARCHAR(10),
    target_pct DECIMAL(5, 2), -- 0 to 100
    PRIMARY KEY (investor_id, ticker)
);

INSERT INTO stock_prices (ticker, price) VALUES
('AAPL', 100.00),
('MSFT', 200.00),
('AMZN', 150.00),
('GOOG', 250.00),
('TSLA', 300.00);

INSERT INTO portfolio_holdings (investor_id, ticker, shares) VALUES
-- Investor 101: Holds 50 AAPL ($5k) and 25 MSFT ($5k). Total Value: $10,000.
(101, 'AAPL', 50),
(101, 'MSFT', 25),

-- Investor 102: Holds only GOOG (48 shares = $12,000). Total Value: $12,000.
(102, 'GOOG', 48),

-- Investor 103: Holds only TSLA (30 shares = $9,000). Total Value: $9,000.
(103, 'TSLA', 30);


INSERT INTO target_allocations (investor_id, ticker, target_pct) VALUES
-- Investor 101 wants to rebalance their existing assets to 40% AAPL / 60% MSFT.
(101, 'AAPL', 40.00),
(101, 'MSFT', 60.00),

-- Investor 102 wants to diversify into a new asset: 50% GOOG / 50% AMZN.
(102, 'GOOG', 50.00),
(102, 'AMZN', 50.00),

-- Investor 103 wants to completely liquidate their TSLA and go 100% into AAPL.
(103, 'AAPL', 100.00);