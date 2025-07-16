-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250716_schema;
USE daily_practice_20250716_schema;


-- Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Insert Data into Customers Table
INSERT INTO Customers (customer_id, customer_name, registration_date, email) VALUES
(101, 'Alice Smith', '2023-01-01', 'alice.s@example.com'),
(102, 'Bob Johnson', '2023-01-15', 'bob.j@example.com'),
(103, 'Charlie Brown', '2023-02-01', 'charlie.b@example.com'),
(104, 'Diana Miller', '2023-02-10', 'diana.m@example.com'),
(105, 'Ethan Green', '2023-03-01', 'ethan.g@example.com'),
(106, 'Fiona Hall', '2023-03-05', 'fiona.h@example.com');

-- Create Tickets Table
CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    created_date DATE NOT NULL,
    resolved_date DATE, -- NULL if not resolved yet
    status ENUM('Open', 'In Progress', 'Resolved', 'Closed') NOT NULL,
    priority ENUM('Low', 'Medium', 'High') NOT NULL,
    category VARCHAR(50) NOT NULL, -- e.g., 'Technical', 'Billing', 'General'
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert Data into Tickets Table
-- Alice Smith (ID 101)
INSERT INTO Tickets (customer_id, created_date, resolved_date, status, priority, category) VALUES
(101, '2024-01-05', '2024-01-07', 'Resolved', 'High', 'Technical'),
(101, '2024-01-10', '2024-01-10', 'Resolved', 'Low', 'General'),
(101, '2024-02-01', NULL, 'Open', 'High', 'Technical'), -- Still Open
(101, '2024-02-15', '2024-02-16', 'Resolved', 'Medium', 'Billing'),
(101, '2024-03-01', '2024-03-01', 'Resolved', 'Low', 'General');

-- Bob Johnson (ID 102)
INSERT INTO Tickets (customer_id, created_date, resolved_date, status, priority, category) VALUES
(102, '2024-01-20', '2024-01-25', 'Resolved', 'Medium', 'Billing'),
(102, '2024-02-10', NULL, 'In Progress', 'High', 'Technical'), -- In Progress
(102, '2024-03-05', '2024-03-05', 'Resolved', 'Low', 'General'),
(102, '2024-04-01', '2024-04-03', 'Resolved', 'Medium', 'Technical');

-- Charlie Brown (ID 103)
INSERT INTO Tickets (customer_id, created_date, resolved_date, status, priority, category) VALUES
(103, '2024-01-25', '2024-01-28', 'Resolved', 'Low', 'General'),
(103, '2024-02-20', '2024-02-20', 'Resolved', 'High', 'Technical'),
(103, '2024-03-10', NULL, 'Open', 'Medium', 'Billing'); -- Still Open

-- Diana Miller (ID 104)
INSERT INTO Tickets (customer_id, created_date, resolved_date, status, priority, category) VALUES
(104, '2024-02-05', '2024-02-06', 'Resolved', 'Low', 'General'),
(104, '2024-03-15', '2024-03-15', 'Resolved', 'Medium', 'Technical');

-- Ethan Green (ID 105) - Few tickets
INSERT INTO Tickets (customer_id, created_date, resolved_date, status, priority, category) VALUES
(105, '2024-03-20', '2024-03-22', 'Resolved', 'Low', 'General');

-- Fiona Hall (ID 106) - One unresolved, one resolved
INSERT INTO Tickets (customer_id, created_date, resolved_date, status, priority, category) VALUES
(106, '2024-04-05', NULL, 'Open', 'High', 'Technical'), -- Still Open
(106, '2024-04-10', '2024-04-12', 'Resolved', 'Medium', 'Billing');

-- Add some tickets that are closed without being resolved (e.g., duplicate, user closed)
INSERT INTO Tickets (customer_id, created_date, resolved_date, status, priority, category) VALUES
(101, '2024-04-10', '2024-04-10', 'Closed', 'Low', 'General'), -- Alice closed a ticket
(102, '2024-04-15', '2024-04-15', 'Closed', 'Medium', 'Billing'); -- Bob closed a ticket
