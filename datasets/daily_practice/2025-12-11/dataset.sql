CREATE DATABASE IF NOT EXISTS daily_practice_20251211_schema;
USE daily_practice_20251211_schema;

-- This table logs individual items included in customer orders.
CREATE TABLE order_items (
    line_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT
);

INSERT INTO order_items (order_id, product_name, category, quantity) VALUES
-- Order 1: The "Breakfast" Bundle
(101, 'Organic Coffee', 'Beverage', 1),
(101, 'Almond Milk', 'Dairy', 1),
(101, 'Oatmeal', 'Pantry', 1),

-- Order 2: Tech accessories
(102, 'Wireless Mouse', 'Electronics', 1),
(102, 'Mechanical Keyboard', 'Electronics', 1),
(102, 'USB-C Hub', 'Electronics', 1),

-- Order 3: Another Breakfast Bundle
(103, 'Organic Coffee', 'Beverage', 1),
(103, 'Almond Milk', 'Dairy', 2),
(103, 'Croissant', 'Bakery', 2),

-- Order 4: Mixed bag
(104, 'Wireless Mouse', 'Electronics', 1),
(104, 'AA Batteries', 'Household', 1),

-- Order 5: Breakfast again (Coffee + Milk is a pattern)
(105, 'Organic Coffee', 'Beverage', 1),
(105, 'Almond Milk', 'Dairy', 1),
(105, 'Banana', 'Produce', 5),

-- Order 6: The "Gamer" Bundle
(106, 'Mechanical Keyboard', 'Electronics', 1),
(106, 'Wireless Mouse', 'Electronics', 1),
(106, 'Monitor Stand', 'Electronics', 1),

-- Order 7: Just Coffee
(107, 'Organic Coffee', 'Beverage', 1);