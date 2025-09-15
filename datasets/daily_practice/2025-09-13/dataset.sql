CREATE DATABASE IF NOT EXISTS daily_practice_20250913_schema;
USE daily_practice_20250913_schema;

-- This table stores periodic snapshots of inventory levels for various SKUs in a warehouse.
-- Instead of an event log, we only have the state (quantity) at a specific time.
CREATE TABLE inventory_snapshots (
    snapshot_id INT PRIMARY KEY AUTO_INCREMENT,
    sku_id VARCHAR(50),
    snapshot_timestamp DATETIME(3),
    quantity_on_hand INT
);

INSERT INTO inventory_snapshots (sku_id, snapshot_timestamp, quantity_on_hand) VALUES
-- SKU-101: Receives stock, has a shipment, receives more, then a large shipment clears it out.
('SKU-101', '2023-11-01 09:00:00.000', 100),
('SKU-101', '2023-11-01 10:00:00.000', 80),
('SKU-101', '2023-11-02 11:00:00.000', 130),
('SKU-101', '2023-11-02 12:00:00.000', 130), -- No change in quantity
('SKU-101', '2023-11-03 14:00:00.000', 0),

-- SKU-202: Receives stock twice, then no changes.
('SKU-202', '2023-11-01 09:05:00.000', 200),
('SKU-202', '2023-11-02 09:10:00.000', 250),
('SKU-202', '2023-11-02 15:00:00.000', 250), -- No change

-- SKU-303: A "fast mover" with several small shipments in a row.
('SKU-303', '2023-11-04 10:00:00.000', 50),
('SKU-303', '2023-11-04 10:05:00.000', 40),
('SKU-303', '2023-11-04 10:10:00.000', 30),
('SKU-303', '2023-11-04 10:15:00.000', 20);
