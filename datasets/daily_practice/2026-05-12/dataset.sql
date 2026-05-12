CREATE DATABASE IF NOT EXISTS daily_practice_20260512_schema;
USE daily_practice_20260512_schema;

-- Table 1: Inventory Batches
-- Tracks the acquisition of goods into specific warehouses.
CREATE TABLE inventory_batches (
    batch_id VARCHAR(50) PRIMARY KEY, -- Pattern: REGION_WHID_LOT# (e.g., US_NY01_1001)
    product_name VARCHAR(100),
    category VARCHAR(50),
    received_date DATE,
    received_qty INT,
    unit_cost DECIMAL(10, 2)
);

-- Table 2: Fulfillment Logs
-- Tracks the outflow of goods (Sales or Waste).
CREATE TABLE fulfillment_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    batch_id VARCHAR(50),
    transaction_type ENUM('SALE', 'WASTE'),
    qty INT,
    log_time DATETIME,
    reason_code VARCHAR(50), -- Can be NULL for SALES
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(batch_id)
);

INSERT INTO inventory_batches (batch_id, product_name, category, received_date, received_qty, unit_cost) VALUES
('US_NY01_1001', 'Organic Avocado', 'Produce', '2026-05-01', 500, 1.20),
('US_NY01_1002', 'Organic Avocado', 'Produce', '2026-05-05', 300, 1.35),
('US_CA02_2005', 'Almond Milk', 'Dairy', '2026-05-01', 1000, 2.50),
('US_TX03_3009', 'Sourdough Bread', 'Bakery', '2026-05-02', 200, 3.00),
('EU_FR01_4001', 'Brie Cheese', 'Dairy', '2026-05-01', 150, 5.50),
('US_CA02_2010', 'Almond Milk', 'Dairy', '2026-05-10', 500, 2.75);

INSERT INTO fulfillment_logs (batch_id, transaction_type, qty, log_time, reason_code) VALUES
('US_NY01_1001', 'SALE', 450, '2026-05-02 10:00:00', NULL),
('US_NY01_1001', 'WASTE', 50, '2026-05-04 18:00:00', 'Expired'),
('US_NY01_1002', 'SALE', 100, '2026-05-06 12:00:00', NULL),
('US_CA02_2005', 'SALE', 800, '2026-05-03 09:00:00', NULL),
('US_CA02_2005', 'WASTE', 100, '2026-05-08 17:00:00', 'Damaged'),
('US_TX03_3009', 'SALE', 190, '2026-05-04 11:00:00', NULL),
('US_TX03_3009', 'WASTE', 10, '2026-05-05 08:00:00', 'Quality Control'),
('EU_FR01_4001', 'SALE', 120, '2026-05-05 14:00:00', NULL),
('US_CA02_2010', 'SALE', 100, '2026-05-11 10:00:00', NULL);