CREATE SCHEMA IF NOT EXISTS daily_practice_20250526_schema;
USE daily_practice_20250526_schema;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    join_date DATE,
    country VARCHAR(50),
    segment VARCHAR(20)
);

INSERT INTO customers VALUES
(1, 'John', 'Smith', 'john@email.com', '2022-01-15', 'USA', 'Regular'),
(2, 'Emma', 'Johnson', 'emma@email.com', '2022-02-20', 'UK', 'Premium'),
(3, 'Michael', 'Brown', 'michael@email.com', '2022-01-30', 'Canada', 'VIP'),
(4, 'Sarah', 'Wilson', 'sarah@email.com', '2022-03-10', 'USA', 'Regular'),
(5, 'James', 'Taylor', 'james@email.com', '2022-02-05', 'UK', 'Premium');

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    base_price DECIMAL(10,2),
    launch_date DATE
);

INSERT INTO products VALUES
(1, 'Gaming Laptop', 'Electronics', 'Computers', 1200.00, '2022-01-01'),
(2, 'Wireless Earbuds', 'Electronics', 'Audio', 150.00, '2022-01-15'),
(3, 'Running Shoes', 'Sports', 'Footwear', 80.00, '2022-02-01'),
(4, 'Coffee Maker', 'Home', 'Appliances', 200.00, '2022-02-15'),
(5, 'Protein Powder', 'Health', 'Supplements', 40.00, '2022-03-01');

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(1001, 1, '2022-03-01', 'Delivered'),
(1002, 2, '2022-03-05', 'Delivered'),
(1003, 3, '2022-03-10', 'Shipped'),
(1004, 1, '2022-03-15', 'Pending'),
(1005, 4, '2022-03-20', 'Delivered'),
(1006, 2, '2022-03-25', 'Cancelled'),
(1007, 5, '2022-03-30', 'Delivered');

-- Order Items table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
(1, 1001, 1, 1, 1200.00, 10.00),
(2, 1001, 2, 2, 150.00, 0.00),
(3, 1002, 3, 1, 80.00, 5.00),
(4, 1003, 4, 1, 200.00, 0.00),
(5, 1004, 5, 3, 40.00, 15.00),
(6, 1005, 2, 1, 150.00, 0.00),
(7, 1006, 3, 2, 80.00, 10.00),
(8, 1007, 1, 1, 1200.00, 20.00);

-- Marketing Campaigns table
CREATE TABLE marketing_campaigns (
    campaign_id INT PRIMARY KEY,
    campaign_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    channel VARCHAR(50),
    budget DECIMAL(10,2)
);

INSERT INTO marketing_campaigns VALUES
(1, 'Spring Sale', '2022-03-01', '2022-03-15', 'Email', 5000.00),
(2, 'New Customer', '2022-03-10', '2022-03-25', 'Social', 7500.00),
(3, 'Flash Sale', '2022-03-20', '2022-03-22', 'Display', 3000.00);

-- Campaign Performance table
CREATE TABLE campaign_performance (
    performance_id INT PRIMARY KEY,
    campaign_id INT,
    date DATE,
    impressions INT,
    clicks INT,
    conversions INT,
    spend DECIMAL(10,2),
    FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns(campaign_id)
);

INSERT INTO campaign_performance VALUES
(1, 1, '2022-03-01', 10000, 500, 50, 1000.00),
(2, 1, '2022-03-02', 12000, 600, 60, 1200.00),
(3, 2, '2022-03-10', 15000, 750, 75, 1500.00),
(4, 2, '2022-03-11', 14000, 700, 70, 1400.00),
(5, 3, '2022-03-20', 8000, 400, 40, 800.00);

-- Customer Support Tickets
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    order_id INT,
    created_date DATE,
    resolved_date DATE,
    status VARCHAR(20),
    category VARCHAR(50),
    priority VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO support_tickets VALUES
(1, 1, 1001, '2022-03-02', '2022-03-03', 'Resolved', 'Shipping', 'Low'),
(2, 2, 1002, '2022-03-06', NULL, 'Open', 'Payment', 'High'),
(3, 3, 1003, '2022-03-11', '2022-03-12', 'Closed', 'Product', 'Medium'),
(4, 4, 1005, '2022-03-21', NULL, 'In Progress', 'Other', 'Low');
