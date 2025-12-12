CREATE DATABASE IF NOT EXISTS daily_practice_20251204_schema;
USE daily_practice_20251204_schema;

-- This table logs the movement of inventory batches in a warehouse.
CREATE TABLE inventory_movements (
    movement_id INT PRIMARY KEY AUTO_INCREMENT,
    batch_id VARCHAR(50),
    product_id INT,
    movement_date DATE,
    quantity INT, -- Positive for IN, Negative for OUT
    reason ENUM('PURCHASE', 'SALE', 'RETURN', 'DAMAGE', 'AUDIT_ADJUSTMENT')
);

INSERT INTO inventory_movements (batch_id, product_id, movement_date, quantity, reason) VALUES
-- Product 101: Healthy flow
('BATCH-001', 101, '2023-11-01', 100, 'PURCHASE'),
('BATCH-001', 101, '2023-11-05', -20, 'SALE'),
('BATCH-001', 101, '2023-11-10', -30, 'SALE'),

-- Product 102: Phantom Inventory Scenario (System thinks 0, but Audit found some)
('BATCH-002', 102, '2023-11-01', 50, 'PURCHASE'),
('BATCH-002', 102, '2023-11-02', -50, 'SALE'), -- Stock hits 0
('BATCH-002', 102, '2023-11-15', 5, 'AUDIT_ADJUSTMENT'), -- Found 5 more

-- Product 103: Negative Inventory Leak (Sold more than received without adjustment)
('BATCH-003', 103, '2023-11-01', 20, 'PURCHASE'),
('BATCH-003', 103, '2023-11-05', -10, 'SALE'),
('BATCH-003', 103, '2023-11-06', -15, 'SALE'), -- Stock hits -5

-- Product 104: Damaged goods logic
('BATCH-004', 104, '2023-11-01', 10, 'PURCHASE'),
('BATCH-004', 104, '2023-11-02', -10, 'DAMAGE');