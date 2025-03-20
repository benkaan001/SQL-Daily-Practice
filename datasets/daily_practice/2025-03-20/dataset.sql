-- Schema for the dataset
CREATE SCHEMA IF NOT EXISTS daily_practice_20250320_schema;
USE daily_practice_20250320_schema;

-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(8, 2)
);

-- OrderDetails table (to handle many-to-many relationship between Orders and Products)
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(8, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Inserting data into Customers table
INSERT INTO Customers (customer_id, name, city, country) VALUES
(1, 'Alice Smith', 'New York', 'USA'),
(2, 'Bob Johnson', 'London', 'UK'),
(3, 'Charlie Brown', 'Paris', 'France'),
(4, 'Diana Lee', 'Tokyo', 'Japan'),
(5, 'Eve Williams', 'Berlin', 'Germany'),
(6, 'Frank Miller', 'New York', 'USA'),
(7, 'Grace Davis', 'London', 'UK');

-- Inserting data into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2024-01-15', 150.00),
(102, 2, '2024-02-20', 220.50),
(103, 1, '2024-03-10', 75.25),
(104, 3, '2024-03-10', 310.00),
(105, 4, '2024-04-01', 95.75),
(106, 2, '2024-04-15', 180.00),
(107, 5, '2024-05-05', 115.50),
(108, 6, '2024-05-20', 255.00),
(109, 3, '2024-06-12', 60.00),
(110, 7, '2024-06-25', 195.00),
(111, 1, '2024-07-01', 35.00);

-- Inserting data into Products table
INSERT INTO Products (product_id, name, category, price) VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Mouse', 'Electronics', 25.00),
(3, 'Keyboard', 'Electronics', 75.00),
(4, 'T-Shirt', 'Apparel', 20.00),
(5, 'Jeans', 'Apparel', 60.00),
(6, 'Book', 'Books', 15.00),
(7, 'Pen', 'Stationery', 2.50),
(8, 'Notebook', 'Stationery', 5.00);

-- Inserting data into OrderDetails table
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 101, 1, 1, 1200.00),
(2, 101, 2, 2, 25.00),
(3, 101, 3, 1, 75.00),
(4, 102, 4, 3, 20.00),
(5, 102, 5, 2, 60.00),
(6, 103, 6, 5, 15.00),
(7, 104, 1, 1, 1200.00),
(8, 104, 3, 2, 75.00),
(9, 104, 5, 1, 60.00),
(10, 105, 7, 10, 2.50),
(11, 105, 8, 5, 5.00),
(12, 106, 4, 2, 20.00),
(13, 106, 5, 2, 60.00),
(14, 106, 2, 1, 25.00),
(15, 107, 6, 3, 15.00),
(16, 107, 8, 4, 5.00),
(17, 108, 1, 1, 1200.00),
(18, 108, 2, 1, 25.00),
(19, 108, 3, 1, 75.00),
(20, 108, 4, 2, 20.00),
(21, 109, 7, 12, 2.50),
(22, 110, 5, 3, 60.00),
(23, 110, 6, 1, 15.00),
(24, 111, 7, 14, 2.50);