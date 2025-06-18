-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250629_schema;
USE daily_practice_20250629_schema;


-- Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL
);

-- Insert Data into Customers Table
INSERT INTO Customers (customer_id, customer_name, region, registration_date) VALUES
(1, 'Alice Johnson', 'North', '2023-01-01'),
(2, 'Bob Williams', 'South', '2023-01-15'),
(3, 'Charlie Davis', 'East', '2023-02-01'),
(4, 'Diana Miller', 'West', '2023-02-10'),
(5, 'Ethan Green', 'North', '2023-03-01'),
(6, 'Fiona Hall', 'South', '2023-03-05'),
(7, 'George King', 'East', '2023-04-01');

-- Create Sales Table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    discount_applied DECIMAL(5, 2) DEFAULT 0.00, -- Can be NULL for no discount
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert Data into Sales Table
-- Alice Johnson (ID 1, North)
INSERT INTO Sales (customer_id, product_name, sale_date, quantity, price_per_unit, discount_applied) VALUES
(1, 'Laptop', '2024-01-05', 1, 1000.00, 50.00),
(1, 'Mouse', '2024-01-05', 1, 25.00, NULL),
(1, 'Keyboard', '2024-02-10', 1, 75.00, NULL),
(1, 'Monitor', '2024-03-01', 1, 300.00, 10.00),
(1, 'Laptop', '2024-06-15', 1, 950.00, NULL); -- Repeat purchase of laptop

-- Bob Williams (ID 2, South)
INSERT INTO Sales (customer_id, product_name, sale_date, quantity, price_per_unit, discount_applied) VALUES
(2, 'Tablet', '2024-01-10', 1, 500.00, 20.00),
(2, 'Case', '2024-01-10', 1, 30.00, NULL),
(2, 'Headphones', '2024-04-01', 1, 150.00, 15.00);

-- Charlie Davis (ID 3, East)
INSERT INTO Sales (customer_id, product_name, sale_date, quantity, price_per_unit, discount_applied) VALUES
(3, 'Smartphone', '2024-02-05', 1, 700.00, 30.00),
(3, 'Charger', '2024-02-05', 1, 20.00, NULL),
(3, 'Smartphone', '2024-05-20', 1, 680.00, NULL); -- Repeat purchase

-- Diana Miller (ID 4, West)
INSERT INTO Sales (customer_id, product_name, sale_date, quantity, price_per_unit, discount_applied) VALUES
(4, 'Desk', '2024-02-15', 1, 250.00, NULL),
(4, 'Chair', '2024-02-15', 1, 100.00, NULL);

-- Ethan Green (ID 5, North)
INSERT INTO Sales (customer_id, product_name, sale_date, quantity, price_per_unit, discount_applied) VALUES
(5, 'Smart TV', '2024-03-05', 1, 800.00, 40.00),
(5, 'Soundbar', '2024-03-05', 1, 120.00, NULL);

-- Fiona Hall (ID 6, South) - Less active
INSERT INTO Sales (customer_id, product_name, sale_date, quantity, price_per_unit, discount_applied) VALUES
(6, 'Webcam', '2024-03-10', 1, 60.00, NULL);

-- George King (ID 7, East) - Recent customer, one purchase
INSERT INTO Sales (customer_id, product_name, sale_date, quantity, price_per_unit, discount_applied) VALUES
(7, 'Projector', '2024-04-05', 1, 400.00, NULL);

-- Add some sales for products without initial discount (NULL discount_applied explicitly)
INSERT INTO Sales (customer_id, product_name, sale_date, quantity, price_per_unit, discount_applied) VALUES
(1, 'External SSD', '2024-04-10', 1, 120.00, NULL),
(2, 'Stylus Pen', '2024-05-01', 1, 20.00, NULL),
(5, 'Gaming Console', '2024-06-01', 1, 450.00, NULL);

-- Add a transaction for a customer with no prior sales to test outer joins for churn
-- (Customer ID 8 does not exist in Customers table, this is for join testing if a customer_id is in sales but not customer master)
-- (No, this is wrong, customer_id in sales must refer to existing customer_id from customers table. This isn't for join testing like this.
-- The problem can ask for customers who have not made any purchases.)
