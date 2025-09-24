CREATE DATABASE IF NOT EXISTS daily_practice_20250924_schema;
USE daily_practice_20250924_schema;

-- This table logs every time a specific item's stock level changes in a warehouse.
CREATE TABLE warehouse_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    product_sku VARCHAR(50),
    warehouse_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('RECEIVED', 'SHIPPED', 'LOST'),
    quantity INT
);

INSERT INTO warehouse_events (product_sku, warehouse_id, event_timestamp, event_type, quantity) VALUES
-- Product A-123 in Warehouse 1: A typical day
('A-123', 1, '2023-11-01 09:00:00.000', 'RECEIVED', 100),
('A-123', 1, '2023-11-01 11:30:00.000', 'SHIPPED', 10),
('A-123', 1, '2023-11-01 14:00:00.000', 'SHIPPED', 5),
('A-123', 1, '2023-11-01 16:45:00.000', 'RECEIVED', 50),

-- Product A-123 in Warehouse 1: Next day
('A-123', 1, '2023-11-02 10:00:00.000', 'SHIPPED', 20),
('A-123', 1, '2023-11-02 10:05:00.000', 'LOST', 2), -- A small loss
('A-123', 1, '2023-11-02 15:00:00.000', 'SHIPPED', 30),

-- Product B-456 in Warehouse 1: Multiple events on one day
('B-456', 1, '2023-11-05 08:00:00.000', 'RECEIVED', 200),
('B-456', 1, '2023-11-05 12:00:00.000', 'SHIPPED', 75),
('B-456', 1, '2023-11-05 12:01:00.000', 'SHIPPED', 25),

-- Product A-123 in Warehouse 2: Separate inventory
('A-123', 2, '2023-11-03 09:30:00.000', 'RECEIVED', 75),
('A-123', 2, '2023-11-03 13:00:00.000', 'SHIPPED', 15),

-- Product C-789 in Warehouse 1: Simple case
('C-789', 1, '2023-11-04 11:00:00.000', 'RECEIVED', 30),
('C-789', 1, '2023-11-04 11:30:00.000', 'SHIPPED', 10);
