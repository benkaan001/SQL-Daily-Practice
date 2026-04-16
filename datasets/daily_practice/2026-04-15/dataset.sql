CREATE DATABASE IF NOT EXISTS daily_practice_20260415_schema;
USE daily_practice_20260415_schema;

-- This table defines the progressive commission tiers.
-- Like tax brackets, a rep only earns the higher rate on the amount that falls WITHIN that specific bracket.
CREATE TABLE commission_brackets (
    bracket_id INT PRIMARY KEY,
    tier_start DECIMAL(10, 2),
    tier_end DECIMAL(10, 2),
    commission_rate DECIMAL(4, 2)
);

-- This table holds the sales team and their total quarterly sales.
CREATE TABLE sales_team (
    rep_id INT PRIMARY KEY,
    rep_name VARCHAR(50),
    total_q1_sales DECIMAL(10, 2)
);

INSERT INTO commission_brackets (bracket_id, tier_start, tier_end, commission_rate) VALUES
(1, 0.00, 50000.00, 0.05),       -- 5% on the first $50k
(2, 50000.00, 100000.00, 0.08),  -- 8% on the next $50k
(3, 100000.00, 250000.00, 0.12), -- 12% on the next $150k
(4, 250000.00, 9999999.99, 0.15); -- 15% on everything above $250k

INSERT INTO sales_team (rep_id, rep_name, total_q1_sales) VALUES
-- Alice: Fits entirely in Bracket 1 ($40k * 0.05)
(101, 'Alice', 40000.00), 

-- Bob: Spills into Bracket 2 ($50k @ 5%) + ($30k @ 8%)
(102, 'Bob', 80000.00),   

-- Charlie: Reaches Bracket 3 ($50k @ 5%) + ($50k @ 8%) + ($50k @ 12%)
(103, 'Charlie', 150000.00), 

-- Diana: Had a rough quarter, zero sales
(104, 'Diana', 0.00),     

-- Evan: Top performer, hits Bracket 4
(105, 'Evan', 300000.00);