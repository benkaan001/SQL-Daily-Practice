-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250713_schema;
USE daily_practice_20250713_schema;


-- Create Shipments Table
CREATE TABLE Shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE, -- Unique ID for the original customer order
    origin_warehouse VARCHAR(50) NOT NULL,
    destination_city VARCHAR(50) NOT NULL,
    planned_delivery_date DATE NOT NULL,
    actual_delivery_date DATE, -- NULL if not delivered yet
    carrier VARCHAR(50) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL
);

-- Insert Data into Shipments Table
INSERT INTO Shipments (shipment_id, order_id, origin_warehouse, destination_city, planned_delivery_date, actual_delivery_date, carrier, shipping_cost) VALUES
(1001, 1, 'Warehouse A', 'New York', '2024-01-10', '2024-01-09', 'FedEx', 25.00), -- Early
(1002, 2, 'Warehouse B', 'Los Angeles', '2024-01-15', '2024-01-15', 'UPS', 30.00), -- On time
(1003, 3, 'Warehouse A', 'Chicago', '2024-01-20', '2024-01-22', 'DHL', 28.00), -- Late
(1004, 4, 'Warehouse C', 'Houston', '2024-02-01', '2024-02-01', 'FedEx', 20.00), -- On time
(1005, 5, 'Warehouse B', 'Miami', '2024-02-10', NULL, 'UPS', 35.00), -- Pending, overdue
(1006, 6, 'Warehouse A', 'Seattle', '2024-03-01', '2024-02-28', 'DHL', 22.00), -- Early
(1007, 7, 'Warehouse C', 'Denver', '2024-03-05', NULL, 'FedEx', 27.00), -- Pending, overdue
(1008, 8, 'Warehouse B', 'Phoenix', '2024-03-10', '2024-03-10', 'UPS', 32.00), -- On time
(1009, 9, 'Warehouse A', 'New York', '2024-04-01', NULL, 'FedEx', 26.00), -- Pending, future planned delivery
(1010, 10, 'Warehouse C', 'Boston', '2024-04-05', '2024-04-04', 'DHL', 29.00); -- Early

-- Create DeliveryEvents Table
CREATE TABLE DeliveryEvents (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    shipment_id INT NOT NULL,
    event_timestamp DATETIME NOT NULL,
    event_type VARCHAR(50) NOT NULL, -- e.g., 'Picked Up', 'In Transit', 'Out for Delivery', 'Delivered', 'Attempted Delivery', 'Exception'
    location VARCHAR(100), -- City or hub where event occurred
    details TEXT, -- Additional details, can be NULL
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id)
);

-- Insert Data into DeliveryEvents Table
-- Shipment 1001 (Delivered Early)
INSERT INTO DeliveryEvents (shipment_id, event_timestamp, event_type, location, details) VALUES
(1001, '2024-01-05 10:00:00', 'Picked Up', 'Warehouse A', NULL),
(1001, '2024-01-06 15:00:00', 'In Transit', 'Chicago Hub', 'Departed'),
(1001, '2024-01-09 08:00:00', 'Out for Delivery', 'New York', NULL),
(1001, '2024-01-09 11:30:00', 'Delivered', 'New York', 'Signed by recipient');

-- Shipment 1002 (Delivered On Time)
INSERT INTO DeliveryEvents (shipment_id, event_timestamp, event_type, location, details) VALUES
(1002, '2024-01-10 11:00:00', 'Picked Up', 'Warehouse B', NULL),
(1002, '2024-01-12 09:00:00', 'In Transit', 'Phoenix Hub', 'Arrived'),
(1002, '2024-01-15 09:00:00', 'Out for Delivery', 'Los Angeles', NULL),
(1002, '2024-01-15 14:00:00', 'Delivered', 'Los Angeles', NULL);

-- Shipment 1003 (Delivered Late)
INSERT INTO DeliveryEvents (shipment_id, event_timestamp, event_type, location, details) VALUES
(1003, '2024-01-16 14:00:00', 'Picked Up', 'Warehouse A', NULL),
(1003, '2024-01-18 10:00:00', 'In Transit', 'St. Louis Hub', NULL),
(1003, '2024-01-20 07:00:00', 'Exception', 'Chicago', 'Weather delay'),
(1003, '2024-01-22 10:00:00', 'Delivered', 'Chicago', NULL);

-- Shipment 1005 (Pending, Overdue)
INSERT INTO DeliveryEvents (shipment_id, event_timestamp, event_type, location, details) VALUES
(1005, '2024-02-05 09:00:00', 'Picked Up', 'Warehouse B', NULL),
(1005, '2024-02-07 18:00:00', 'In Transit', 'Atlanta Hub', 'Departed'),
(1005, '2024-02-10 07:00:00', 'Attempted Delivery', 'Miami', 'Recipient not available'),
(1005, '2024-02-10 10:00:00', 'In Transit', 'Miami', 'Returning to facility');

-- Shipment 1007 (Pending, Overdue)
INSERT INTO DeliveryEvents (shipment_id, event_timestamp, event_type, location, details) VALUES
(1007, '2024-03-01 13:00:00', 'Picked Up', 'Warehouse C', NULL),
(1007, '2024-03-03 09:00:00', 'In Transit', 'Kansas City Hub', NULL),
(1007, '2024-03-05 08:00:00', 'Exception', 'Denver', 'Customs hold');

-- Shipment 1009 (Pending, Future Planned Delivery)
INSERT INTO DeliveryEvents (shipment_id, event_timestamp, event_type, location, details) VALUES
(1009, '2024-03-28 10:00:00', 'Picked Up', 'Warehouse A', NULL),
(1009, '2024-03-29 16:00:00', 'In Transit', 'Philadelphia Hub', NULL);
