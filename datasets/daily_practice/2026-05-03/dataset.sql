CREATE DATABASE IF NOT EXISTS daily_practice_20260503_schema;
USE daily_practice_20260503_schema;

-- This table acts as a distance lookup matrix.
-- To save space and prevent data anomalies (like A->B being 100km but B->A being 120km),
-- the system ONLY stores one row per pair of cities. 
-- The rule is: location_a is ALWAYS alphabetically before location_b.
CREATE TABLE distance_matrix (
    location_a VARCHAR(50),
    location_b VARCHAR(50),
    distance_km INT,
    PRIMARY KEY (location_a, location_b)
);

-- This table logs the sequence of stops for delivery drivers.
CREATE TABLE route_stops (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT,
    sequence_num INT,
    stop_name VARCHAR(50)
);

-- Populate the distance matrix (Notice alphabetical ordering enforced)
INSERT INTO distance_matrix (location_a, location_b, distance_km) VALUES
('Austin', 'Seattle', 3000),
('Portland', 'Seattle', 280),
('Austin', 'Portland', 3100),
('Denver', 'Seattle', 2100),
('Austin', 'Denver', 1450),
('Denver', 'Portland', 1900);

-- Populate the route logs
INSERT INTO route_stops (driver_id, sequence_num, stop_name) VALUES
-- Driver 101 (The Pacific Northwest Run): Seattle -> Portland -> Seattle
(101, 1, 'Seattle'),
(101, 2, 'Portland'),
(101, 3, 'Seattle'),

-- Driver 102 (The Long Haul): Seattle -> Denver -> Austin -> Portland
(102, 1, 'Seattle'),
(102, 2, 'Denver'),
(102, 3, 'Austin'),
(102, 4, 'Portland'),

-- Driver 103 (Single stop, vehicle broke down before departing)
(103, 1, 'Austin'),

-- Driver 104 (One-way delivery)
(104, 1, 'Denver'),
(104, 2, 'Austin');