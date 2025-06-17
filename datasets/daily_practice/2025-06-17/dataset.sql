CREATE DATABASE IF NOT EXISTS delivery_platform_schema;
USE delivery_platform_schema;


-- Table for delivery agent information
CREATE TABLE delivery_agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(255),
    join_date DATE,
    city VARCHAR(100),
    rating DECIMAL(3, 2)
);

-- Table for order and delivery details
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    agent_id INT,
    order_time DATETIME,
    delivery_time DATETIME,
    order_value DECIMAL(10, 2),
    delivery_fee DECIMAL(5, 2),
    tip DECIMAL(5, 2),
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id)
);

-- Inserting sample data
INSERT INTO delivery_agents (agent_id, agent_name, join_date, city, rating) VALUES
(1, 'Leo Martinez', '2023-01-10', 'Metroville', 4.85),
(2, 'Sophia Chen', '2022-11-20', 'Metroville', 4.92),
(3, 'Ethan Rodriguez', '2023-02-05', 'Star City', 4.70),
(4, 'Olivia Kim', '2023-03-15', 'Star City', 4.88),
(5, 'Noah Patel', '2022-12-01', 'Metroville', 4.75);

INSERT INTO orders (order_id, agent_id, order_time, delivery_time, order_value, delivery_fee, tip) VALUES
(1001, 1, '2023-03-01 12:05:00', '2023-03-01 12:35:00', 25.50, 5.00, 3.00),
(1002, 2, '2023-03-01 12:10:00', '2023-03-01 12:28:00', 40.00, 5.00, 5.00),
(1003, 3, '2023-03-01 18:30:00', '2023-03-01 19:10:00', 32.00, 4.50, 4.00),
(1004, 1, '2023-03-02 19:00:00', '2023-03-02 19:25:00', 18.75, 4.00, 2.50),
(1005, 4, '2023-03-02 20:05:00', '2023-03-02 20:30:00', 55.20, 6.00, 7.00),
(1006, 2, '2023-03-03 13:00:00', '2023-03-03 13:15:00', 22.00, 3.50, 3.00),
(1007, 5, '2023-03-03 13:15:00', '2023-03-03 13:55:00', 28.50, 4.00, 0.00),
(1008, 1, '2023-04-05 12:00:00', '2023-04-05 12:32:00', 30.00, 5.00, 4.00),
(1009, 3, '2023-04-05 12:02:00', '2023-04-05 12:45:00', 45.00, 5.50, 5.00),
(1010, 2, '2023-04-06 18:30:00', '2023-04-06 18:48:00', 33.00, 4.00, 4.50),
(1011, 4, '2023-04-06 18:45:00', '2023-04-06 19:10:00', 29.50, 4.00, 3.00),
(1012, 1, '2023-04-07 19:10:00', '2023-04-07 19:33:00', 15.00, 3.00, 2.00),
(1013, 5, '2023-04-07 19:15:00', '2023-04-07 20:00:00', 60.00, 7.00, 8.00);