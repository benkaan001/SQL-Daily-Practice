CREATE DATABASE IF NOT EXISTS daily_practice_20251116_schema;
USE daily_practice_20251116_schema;

-- This table logs inventory changes for products in a warehouse.
-- A positive quantity means stock was added (RESTOCK or RETURN).
-- A negative quantity means stock was removed (SALE).
CREATE TABLE inventory_ledger (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('RESTOCK', 'SALE', 'RETURN'),
    quantity INT
);

INSERT INTO inventory_ledger (product_id, event_timestamp, event_type, quantity) VALUES
-- Product A-101: Sells out and goes negative
('A-101', '2023-11-01 09:00:00.000', 'RESTOCK', 100),
('A-101', '2023-11-02 10:00:00.000', 'SALE', -50),
('A-101', '2023-11-03 11:00:00.000', 'SALE', -30),
('A-101', '2023-11-04 14:00:00.000', 'SALE', -25), -- Stock is now -5 (Stockout!)

-- Product B-202: Sells, but doesn't go negative
('B-202', '2023-11-01 10:00:00.000', 'RESTOCK', 50),
('B-202', '2023-11-02 11:00:00.000', 'SALE', -20),
('B-202', '2023-11-03 12:00:00.000', 'RETURN', 5), -- A return (adds stock)
('B-202', '2023-11-04 15:00:00.000', 'SALE', -30), -- Stock is now 5

-- Product C-303: Goes negative, restocks, goes negative again
('C-303', '2023-11-05 09:00:00.000', 'RESTOCK', 20),
('C-303', '2023-11-05 10:00:00.000', 'SALE', -30), -- Stock is now -10 (Stockout!)
('C-303', '2023-11-06 11:00:00.000', 'RESTOCK', 50), -- Stock is now 40
('C-303', '2023-11-07 14:00:00.000', 'SALE', -20),
('C-303', '2023-11-08 15:00:00.000', 'SALE', -30), -- Stock is now -10 (Stockout!)

-- Product D-404: Never restocked, just sales (data error)
('D-404', '2023-11-06 10:00:00.000', 'SALE', -5); -- Stock is now -5 (Stockout!)