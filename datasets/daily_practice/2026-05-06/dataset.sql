CREATE DATABASE IF NOT EXISTS daily_practice_20260506_schema;
USE daily_practice_20260506_schema;

-- This table stores the current on-hand inventory and the required safety thresholds.
CREATE TABLE inventory_levels (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    current_stock INT,
    safety_stock_threshold INT
);

-- This table logs future, scheduled orders that will deduct from the inventory.
CREATE TABLE scheduled_dispatches (
    dispatch_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    dispatch_date DATE,
    quantity INT
);

INSERT INTO inventory_levels (product_id, product_name, current_stock, safety_stock_threshold) VALUES
(101, 'Ergonomic Keyboard', 150, 30),
(102, 'Wireless Mouse', 80, 15),
(103, 'HD Monitor', 50, 10),
(104, 'Laptop Stand', 200, 50);

INSERT INTO scheduled_dispatches (product_id, dispatch_date, quantity) VALUES
-- Keyboard orders: Will breach safety stock on the 3rd order
(101, '2026-05-07', 40),
(101, '2026-05-09', 50),
(101, '2026-05-11', 40),

-- Mouse orders: Will breach safety stock on the 2nd order, continues dropping after
(102, '2026-05-08', 30),
(102, '2026-05-10', 40), 
(102, '2026-05-12', 20), 

-- Monitor orders: Demand never pushes stock below the safety threshold of 10
(103, '2026-05-07', 15),
(103, '2026-05-10', 10),
(103, '2026-05-15', 5), 

-- Laptop Stand orders: Huge order breaches safety stock immediately
(104, '2026-05-06', 160);