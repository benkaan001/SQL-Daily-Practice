CREATE DATABASE IF NOT EXISTS daily_practice_20260320_schema;
USE daily_practice_20260320_schema;

-- This table defines the maximum weight capacity for various cargo flights.
CREATE TABLE flights (
    flight_id VARCHAR(10) PRIMARY KEY,
    max_weight_kg INT
);

-- This table represents the loading manifest. Items MUST be loaded strictly 
-- in the order of their 'boarding_priority'.
CREATE TABLE cargo_manifest (
    manifest_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id VARCHAR(10),
    boarding_priority INT,
    item_name VARCHAR(50),
    weight_kg INT
);

INSERT INTO flights (flight_id, max_weight_kg) VALUES
('FL-001', 1000),
('FL-002', 1500),
('FL-003', 800);

INSERT INTO cargo_manifest (flight_id, boarding_priority, item_name, weight_kg) VALUES
-- Flight 001 (Capacity: 1000kg)
-- 300 + 400 + 200 = 900kg (Fits). Adding the last 300kg would exceed 1000kg.
('FL-001', 1, 'Mail Sacks', 300),
('FL-001', 2, 'Fresh Produce', 400),
('FL-001', 3, 'Medical Supplies', 200),
('FL-001', 4, 'Heavy Generators', 300),

-- Flight 002 (Capacity: 1500kg)
-- 500 + 500 + 500 = 1500kg. The entire manifest fits perfectly.
('FL-002', 1, 'Electronics', 500),
('FL-002', 2, 'Clothing', 500),
('FL-002', 3, 'Auto Parts', 500),

-- Flight 003 (Capacity: 800kg)
-- 700 fits. The next 200kg item brings it to 900kg, which exceeds capacity.
('FL-003', 1, 'Machine Tools', 700),
('FL-003', 2, 'Building Materials', 200);