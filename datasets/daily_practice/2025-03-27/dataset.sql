-- Create the database and tables for a customer orders system
CREATE DATABASE IF NOT EXISTS daily_practice_20250327_schema;
USE daily_practice_20250327_schema;

-- Customers table: contains basic customer information
CREATE TABLE customers (
    id BIGINT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    city TEXT,
    address TEXT,
    phone_number TEXT
);

-- Orders table: captures orders placed by customers
CREATE TABLE orders (
    id BIGINT PRIMARY KEY,
    cust_id BIGINT,
    order_date DATETIME,
    order_details TEXT,
    total_order_cost BIGINT,
    FOREIGN KEY (cust_id) REFERENCES customers(id)
);

-- Insert sample customers
INSERT INTO customers (id, first_name, last_name, city, address, phone_number) VALUES
(1, 'Alice', 'Johnson', 'New York', '123 A Street', '555-0101'),
(2, 'Bob', 'Smith', 'Los Angeles', '456 B Avenue', '555-0202'),
(3, 'Charlie', 'Brown', 'Chicago', '789 C Road', '555-0303'),
(4, 'Diana', 'Prince', 'New York', '321 D Blvd', '555-0404'),
(5, 'Edward', 'Norton', 'Los Angeles', '654 E Lane', '555-0505');

-- Insert sample orders
INSERT INTO orders (id, cust_id, order_date, order_details, total_order_cost) VALUES
(101, 1, '2025-01-05 10:15:00', 'Electronics order - TV and speakers', 1200),
(102, 1, '2025-01-05 15:30:00', 'Accessory order - HDMI cable', 50),
(103, 2, '2025-01-06 11:00:00', 'Furniture order - sofa', 800),
(104, 2, '2025-01-06 13:45:00', 'Electronics order - smartphone', 700),
(105, 3, '2025-02-10 09:20:00', 'Book order - novels and magazines', 150),
(106, 4, '2025-02-10 16:00:00', 'Clothing order - jackets', 300),
(107, 5, '2025-02-15 12:30:00', 'Electronics order - laptop', 1500),
(108, 5, '2025-02-15 18:10:00', 'Accessory order - laptop bag', 80),
(109, 1, '2025-02-20 14:00:00', 'Furniture order - dining table', 950),
(110, 3, '2025-03-01 10:05:00', 'Electronics order - headphones', 200);