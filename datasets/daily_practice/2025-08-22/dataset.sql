CREATE DATABASE IF NOT EXISTS daily_practice_20250822_schema;
USE daily_practice_20250822_schema;

-- This table logs the lifecycle of individual items from sale to potential return and restocking.
CREATE TABLE item_lifecycle_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    item_sku VARCHAR(50), -- A unique identifier for a specific physical item
    product_id INT,
    event_type ENUM('SALE', 'RETURN_REQUEST', 'RETURN_PROCESSED'),
    event_timestamp DATETIME,
    order_id VARCHAR(50),
    details JSON
);

INSERT INTO item_lifecycle_events (item_sku, product_id, event_type, event_timestamp, order_id, details) VALUES
-- Item A: Sold and never returned
('SKU-A-001', 101, 'SALE', '2023-11-01 10:00:00', 'ORD-001', '{"price": 50.00}'),

-- Item B: Sold, returned for 'Wrong Size', successfully restocked
('SKU-B-001', 102, 'SALE', '2023-11-02 11:00:00', 'ORD-002', '{"price": 75.00}'),
('SKU-B-001', 102, 'RETURN_REQUEST', '2023-11-05 14:00:00', 'ORD-002', '{"reason": "Wrong Size"}'),
('SKU-B-001', 102, 'RETURN_PROCESSED', '2023-11-10 16:00:00', 'ORD-002', '{"resolution": "Restock"}'),
('SKU-B-001', 102, 'SALE', '2023-11-15 18:00:00', 'ORD-008', '{"price": 70.00}'), -- Resold at a discount

-- Item C: Sold, returned as 'Defective', not restocked
('SKU-C-001', 101, 'SALE', '2023-11-03 12:00:00', 'ORD-003', '{"price": 50.00}'),
('SKU-C-001', 101, 'RETURN_REQUEST', '2023-11-06 09:00:00', 'ORD-003', '{"reason": "Defective"}'),
('SKU-C-001', 101, 'RETURN_PROCESSED', '2023-11-12 11:00:00', 'ORD-003', '{"resolution": "Dispose"}'),

-- Item D: Sold, returned, restocked, but not yet resold
('SKU-D-001', 103, 'SALE', '2023-11-04 13:00:00', 'ORD-004', '{"price": 120.00}'),
('SKU-D-001', 103, 'RETURN_REQUEST', '2023-11-08 10:00:00', 'ORD-004', '{"reason": "Changed Mind"}'),
('SKU-D-001', 103, 'RETURN_PROCESSED', '2023-11-14 12:00:00', 'ORD-004', '{"resolution": "Restock"}'),

-- Item E: Sold, return requested but never processed (lost in transit?)
('SKU-E-001', 102, 'SALE', '2023-11-05 15:00:00', 'ORD-005', '{"price": 75.00}'),
('SKU-E-001', 102, 'RETURN_REQUEST', '2023-11-09 11:00:00', 'ORD-005', '{"reason": "Wrong Size"}'),

-- Item F and G: Part of the same order, one returned
('SKU-F-001', 101, 'SALE', '2023-11-06 16:00:00', 'ORD-006', '{"price": 50.00}'),
('SKU-G-001', 103, 'SALE', '2023-11-06 16:00:00', 'ORD-006', '{"price": 120.00}'),
('SKU-F-001', 101, 'RETURN_REQUEST', '2023-11-10 18:00:00', 'ORD-006', '{"reason": "Defective"}'),
('SKU-F-001', 101, 'RETURN_PROCESSED', '2023-11-16 19:00:00', 'ORD-006', '{"resolution": "Dispose"}'),

-- Item H: Sold twice, returned once
('SKU-H-001', 104, 'SALE', '2023-11-07 17:00:00', 'ORD-007', '{"price": 200.00}'),
('SKU-H-001', 104, 'RETURN_REQUEST', '2023-11-11 13:00:00', 'ORD-007', '{"reason": "Changed Mind"}'),
('SKU-H-001', 104, 'RETURN_PROCESSED', '2023-11-18 15:00:00', 'ORD-007', '{"resolution": "Restock"}'),
('SKU-H-001', 104, 'SALE', '2023-11-25 10:00:00', 'ORD-009', '{"price": 180.00}');
