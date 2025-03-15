-- Create and use the schema
CREATE SCHEMA IF NOT EXISTS ecommerce_20250314;
USE ecommerce_20250314;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    signup_date DATE NOT NULL,
    last_login_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    added_date DATE NOT NULL,
    discontinued BOOLEAN DEFAULT FALSE
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_address VARCHAR(200),
    status VARCHAR(20) NOT NULL,
    delivered_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order_items table (to create a many-to-many relationship between orders and products)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(5, 2) DEFAULT 0.00,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample data for customers
INSERT INTO customers (customer_id, first_name, last_name, email, signup_date, last_login_date, is_active) VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '2023-01-15', '2023-03-10', TRUE),
(2, 'Sarah', 'Johnson', 'sarah.j@email.com', '2023-02-20', '2023-03-15', TRUE),
(3, 'Michael', 'Williams', 'mike.w@email.com', '2023-01-05', NULL, FALSE),
(4, 'Emily', 'Brown', 'emily.b@email.com', '2023-02-10', '2023-03-12', TRUE),
(5, 'David', 'Jones', 'david.j@email.com', '2023-03-01', '2023-03-18', TRUE),
(6, 'Lisa', 'Garcia', 'lisa.g@email.com', '2023-01-25', NULL, TRUE),
(7, 'Robert', 'Miller', 'robert.m@email.com', '2023-02-15', '2023-02-28', FALSE),
(8, 'Jennifer', 'Davis', 'jennifer.d@email.com', '2023-03-05', '2023-03-16', TRUE);

-- Sample data for products
INSERT INTO products (product_id, product_name, category, price, stock_quantity, added_date, discontinued) VALUES
(101, 'Smartphone X', 'Electronics', 799.99, 50, '2023-01-10', FALSE),
(102, 'Laptop Pro', 'Electronics', 1299.99, 30, '2023-01-15', FALSE),
(103, 'Coffee Maker', 'Home Appliances', 89.99, 25, '2023-02-01', FALSE),
(104, 'Running Shoes', 'Apparel', 129.99, 100, '2023-01-20', FALSE),
(105, 'Wireless Earbuds', 'Electronics', 149.99, 75, '2023-02-10', FALSE),
(106, 'Blender', 'Home Appliances', 69.99, 40, '2023-01-05', TRUE),
(107, 'Winter Jacket', 'Apparel', 199.99, 60, '2023-02-15', FALSE),
(108, 'Gaming Mouse', 'Electronics', 49.99, 90, '2023-03-01', FALSE),
(109, 'Fitness Tracker', 'Electronics', 79.99, 120, '2023-02-20', FALSE),
(110, 'Toaster', 'Home Appliances', 39.99, 35, '2023-01-25', FALSE);

-- Sample data for orders
INSERT INTO orders (order_id, customer_id, order_date, total_amount, shipping_address, status, delivered_date) VALUES
(1001, 1, '2023-02-01', 849.98, '123 Main St, Anytown, USA', 'Delivered', '2023-02-05'),
(1002, 2, '2023-02-25', 89.99, '456 Oak Ave, Somewhere, USA', 'Delivered', '2023-03-01'),
(1003, 4, '2023-03-05', 1429.98, '789 Pine Rd, Nowhere, USA', 'Shipped', NULL),
(1004, 1, '2023-03-10', 229.98, '123 Main St, Anytown, USA', 'Processing', NULL),
(1005, 5, '2023-03-12', 149.99, '321 Cedar Ln, Everywhere, USA', 'Delivered', '2023-03-15'),
(1006, 3, '2023-02-10', 1299.99, '654 Maple Dr, Anywhere, USA', 'Cancelled', NULL),
(1007, 6, '2023-03-15', 169.98, '987 Elm St, Someplace, USA', 'Shipped', NULL),
(1008, 8, '2023-03-18', 279.98, '159 Willow Way, Othertown, USA', 'Processing', NULL),
(1009, 2, '2023-03-20', 329.98, '456 Oak Ave, Somewhere, USA', 'Processing', NULL);

-- Sample data for order_items
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(10001, 1001, 101, 1, 799.99, 10.00),
(10002, 1001, 108, 1, 49.99, 0.00),
(10003, 1002, 103, 1, 89.99, 0.00),
(10004, 1003, 102, 1, 1299.99, 0.00),
(10005, 1003, 109, 1, 79.99, 0.00),
(10006, 1003, 110, 1, 39.99, 15.00),
(10007, 1004, 104, 1, 129.99, 0.00),
(10008, 1004, 109, 1, 79.99, 0.00),
(10009, 1004, 108, 1, 49.99, 50.00),
(10010, 1005, 105, 1, 149.99, 0.00),
(10011, 1006, 102, 1, 1299.99, 0.00),
(10012, 1007, 108, 1, 49.99, 0.00),
(10013, 1007, 110, 1, 39.99, 0.00),
(10014, 1007, 109, 1, 79.99, 0.00),
(10015, 1008, 105, 1, 149.99, 20.00),
(10016, 1008, 109, 1, 79.99, 0.00),
(10017, 1008, 110, 1, 39.99, 5.00),
(10018, 1009, 104, 1, 129.99, 0.00),
(10019, 1009, 107, 1, 199.99, 15.00);