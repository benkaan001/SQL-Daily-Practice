-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250711_schema;
USE daily_practice_20250711_schema;


-- Create Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_fee DECIMAL(10, 2) DEFAULT 0.00
);

-- Insert Data into Orders Table
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, shipping_fee) VALUES
(101, 1, '2024-01-01', 150.00, 5.00), -- Item A
(102, 1, '2024-01-10', 200.00, 7.50), -- Item B
(103, 2, '2024-01-05', 300.00, 10.00), -- Item C
(104, 3, '2024-02-01', 50.00, 2.50), -- Item D
(105, 1, '2024-02-15', 100.00, 5.00), -- Item E
(106, 2, '2024-03-01', 400.00, 12.00), -- Item F
(107, 4, '2024-03-10', 75.00, 3.00), -- Item G
(108, 1, '2024-04-01', 120.00, 6.00), -- Item H
(109, 3, '2024-04-05', 80.00, 4.00), -- Item I
(110, 5, '2024-05-01', 600.00, 15.00); -- Item J

-- Create Returns Table
CREATE TABLE Returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    return_date DATE NOT NULL,
    returned_amount DECIMAL(10, 2) NOT NULL, -- Amount refunded for the returned items
    reason VARCHAR(255), -- Can be NULL
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert Data into Returns Table
INSERT INTO Returns (order_id, return_date, returned_amount, reason) VALUES
(101, '2024-01-15', 150.00, 'Defective product'), -- Full return
(102, '2024-01-20', 100.00, 'Changed mind'), -- Partial return
(103, '2024-02-01', 300.00, NULL), -- Full return, no reason
(105, '2024-03-01', 50.00, 'Wrong size'), -- Partial return
(106, '2024-03-15', 400.00, 'Product not as described'), -- Full return
(108, '2024-04-10', 120.00, 'Damaged in transit'), -- Full return
(109, '2024-04-20', 40.00, 'Duplicate order'); -- Partial return
