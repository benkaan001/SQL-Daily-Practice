CREATE DATABASE IF NOT EXISTS daily_practice_20260430_schema;
USE daily_practice_20260430_schema;

-- This table stores the daily closing prices for various assets.
-- Note: Weekends, holidays, and system outages mean there are gaps in the dates.
-- A month may not always start on the 1st or end on the 30th/31st!
CREATE TABLE daily_asset_prices (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    asset_id VARCHAR(10),
    price_date DATE,
    price DECIMAL(10, 2)
);

INSERT INTO daily_asset_prices (asset_id, price_date, price) VALUES
-- Bitcoin (BTC) in March
('BTC', '2026-03-02', 55000.00), -- First available day in March (Open)
('BTC', '2026-03-10', 54000.00), -- (Low)
('BTC', '2026-03-20', 61000.00), -- (High)
('BTC', '2026-03-28', 59000.00), -- Last available day in March (Close)

-- Ethereum (ETH) in March
('ETH', '2026-03-01', 2800.00),  -- (Open & Low)
('ETH', '2026-03-15', 3200.00),  -- (High)
('ETH', '2026-03-31', 3100.00),  -- (Close)

-- Bitcoin (BTC) in April
('BTC', '2026-04-03', 60000.00), -- First available day in April (Open)
('BTC', '2026-04-12', 65000.00), -- (High)
('BTC', '2026-04-22', 58000.00), -- (Low)
('BTC', '2026-04-29', 62000.00), -- Last available day in April (Close)

-- Ethereum (ETH) in April
('ETH', '2026-04-01', 3000.00),  -- (Open & Low)
('ETH', '2026-04-14', 3500.00),  -- (High)
('ETH', '2026-04-30', 3200.00);  -- (Close)