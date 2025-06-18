-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250628_schema;
USE daily_practice_20250628_schema;


-- Create Parts Table
CREATE TABLE Parts (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    current_stock INT NOT NULL,
    reorder_level INT NOT NULL, -- Minimum stock quantity before reordering
    cost_per_unit DECIMAL(10, 2) NOT NULL
);

-- Insert Data into Parts Table
INSERT INTO Parts (part_id, part_name, category, current_stock, reorder_level, cost_per_unit) VALUES
(1001, 'Processor X', 'Electronics', 150, 100, 250.00),
(1002, 'RAM 8GB', 'Electronics', 200, 150, 50.00),
(1003, 'Chassis A', 'Hardware', 80, 50, 75.00),
(1004, 'Power Supply 500W', 'Electronics', 90, 80, 40.00),
(1005, 'Fan Cooler', 'Hardware', 300, 200, 15.00),
(1006, 'SSD 512GB', 'Electronics', 120, 100, 60.00),
(1007, 'Graphics Card Y', 'Electronics', 40, 50, 300.00), -- Below reorder level
(1008, 'Cable Kit', 'Accessories', 500, 100, 5.00),
(1009, 'Keyboard Module', 'Peripherals', 70, 70, 30.00), -- At reorder level
(1010, 'Mouse Module', 'Peripherals', 110, 100, 20.00);


-- Create Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    delivery_date DATE, -- NULL if not delivered yet
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending'
);

-- Insert Data into Orders Table
INSERT INTO Orders (order_id, order_date, customer_name, delivery_date, order_status) VALUES
(1, '2025-01-01', 'Tech Solutions Inc.', '2025-01-05', 'Delivered'),
(2, '2025-01-10', 'Global Systems Ltd.', '2025-01-15', 'Delivered'),
(3, '2025-02-01', 'Innovate Corp.', '2025-02-05', 'Delivered'),
(4, '2025-02-15', 'Tech Solutions Inc.', '2025-02-20', 'Delivered'),
(5, '2025-03-01', 'Future Tech Co.', NULL, 'Pending'), -- Pending
(6, '2025-03-10', 'Global Systems Ltd.', '2025-03-15', 'Shipped'), -- Shipped but not delivered
(7, '2025-04-01', 'Innovate Corp.', NULL, 'Pending'), -- Pending, due to part shortage later
(8, '2025-04-15', 'Gadget Emporium', '2025-04-20', 'Delivered'),
(9, '2025-05-01', 'Future Tech Co.', NULL, 'Pending'), -- Pending, later delivery
(10, '2025-05-10', 'New Ventures LLC', '2025-05-15', 'Delivered'),
(11, '2025-06-01', 'Tech Solutions Inc.', NULL, 'Pending'), -- Current month pending
(12, '2025-06-05', 'Global Systems Ltd.', NULL, 'Pending'); -- Current month pending


-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    part_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (part_id) REFERENCES Parts(part_id)
);

-- Insert Data into OrderDetails Table
-- Order 1
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(1, 1001, 10), (1, 1002, 20), (1, 1003, 5);
-- Order 2
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(2, 1004, 15), (2, 1005, 30);
-- Order 3
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(3, 1001, 5), (3, 1002, 10), (3, 1006, 8);
-- Order 4
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(4, 1007, 20), (4, 1008, 50); -- Graphics Card Y (1007) ordered
-- Order 5 (Pending)
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(5, 1003, 10), (5, 1009, 20);
-- Order 6 (Shipped)
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(6, 1001, 12), (6, 1010, 15);
-- Order 7 (Pending, due to 1007 shortage)
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(7, 1007, 25), (7, 1002, 10); -- More Graphics Card Y (1007) ordered
-- Order 8
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(8, 1004, 10), (8, 1005, 20);
-- Order 9 (Pending)
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(9, 1001, 15), (9, 1006, 10);
-- Order 10
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(10, 1009, 10), (10, 1010, 5);
-- Order 11 (Current month pending)
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(11, 1001, 5), (11, 1002, 5);
-- Order 12 (Current month pending)
INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES
(12, 1003, 5), (12, 1005, 5);

-- Part 1000 (Non-existent part to test joins)
-- INSERT INTO OrderDetails (order_id, part_id, quantity) VALUES (1, 1000, 1);
