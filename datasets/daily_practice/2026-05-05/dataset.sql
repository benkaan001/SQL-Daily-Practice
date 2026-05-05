CREATE DATABASE IF NOT EXISTS daily_practice_20260505_schema;
USE daily_practice_20260505_schema;

-- This table stores all items in the factory: finished goods, sub-assemblies, and raw materials.
-- Only RAW_MATERIAL parts have an intrinsic cost.
CREATE TABLE parts (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(50),
    part_type ENUM('ASSEMBLY', 'RAW_MATERIAL'),
    cost DECIMAL(10, 2) 
);

-- This table defines the Bill of Materials (how parts fit together).
-- parent_part_id represents the item being built.
-- child_part_id represents the component needed to build it.
CREATE TABLE bill_of_materials (
    parent_part_id INT,
    child_part_id INT,
    quantity INT,
    PRIMARY KEY (parent_part_id, child_part_id)
);

INSERT INTO parts (part_id, part_name, part_type, cost) VALUES
(101, 'Mountain Bike', 'ASSEMBLY', 0.00),
(102, 'Road Bike', 'ASSEMBLY', 0.00),
(201, 'Wheel Assembly (Mountain)', 'ASSEMBLY', 0.00),
(202, 'Wheel Assembly (Road)', 'ASSEMBLY', 0.00),
(301, 'Mountain Tire', 'RAW_MATERIAL', 25.00),
(302, 'Road Tire', 'RAW_MATERIAL', 35.00),
(303, 'Heavy Rim', 'RAW_MATERIAL', 40.00),
(304, 'Light Rim', 'RAW_MATERIAL', 60.00),
(305, 'Standard Spoke', 'RAW_MATERIAL', 1.00),
(306, 'Aero Spoke', 'RAW_MATERIAL', 2.50),
(401, 'Mountain Frame', 'RAW_MATERIAL', 200.00),
(402, 'Road Frame', 'RAW_MATERIAL', 350.00),
(403, 'Gears & Chain', 'RAW_MATERIAL', 80.00),
(404, 'Handlebar', 'RAW_MATERIAL', 30.00);

INSERT INTO bill_of_materials (parent_part_id, child_part_id, quantity) VALUES
-- Recipe to build a Mountain Bike
(101, 201, 2), -- Requires 2 Mountain Wheels
(101, 401, 1), -- Requires 1 Mountain Frame
(101, 403, 1), -- Requires 1 Gears & Chain
(101, 404, 1), -- Requires 1 Handlebar

-- Recipe to build a Road Bike
(102, 202, 2), -- Requires 2 Road Wheels
(102, 402, 1), -- Requires 1 Road Frame
(102, 403, 1), -- Requires 1 Gears & Chain
(102, 404, 1), -- Requires 1 Handlebar

-- Recipe to build a Mountain Wheel Assembly
(201, 301, 1), -- Requires 1 Mountain Tire
(201, 303, 1), -- Requires 1 Heavy Rim
(201, 305, 32),-- Requires 32 Standard Spokes

-- Recipe to build a Road Wheel Assembly
(202, 302, 1), -- Requires 1 Road Tire
(202, 304, 1), -- Requires 1 Light Rim
(202, 306, 24);-- Requires 24 Aero Spokes