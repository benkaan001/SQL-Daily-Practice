CREATE DATABASE IF NOT EXISTS daily_practice_20260411_schema;
USE daily_practice_20260411_schema;

-- This table represents the raw materials currently available in the bakery's pantry.
CREATE TABLE bakery_inventory (
    ingredient_name VARCHAR(50) PRIMARY KEY,
    stock_qty INT
);

-- This table represents the "Bill of Materials" (recipes) for the bakery's products.
CREATE TABLE recipe_requirements (
    recipe_name VARCHAR(50),
    ingredient_name VARCHAR(50),
    required_qty INT,
    PRIMARY KEY (recipe_name, ingredient_name)
);

-- Current stock in the pantry (in grams or individual units like eggs)
INSERT INTO bakery_inventory (ingredient_name, stock_qty) VALUES
('Flour', 3000),
('Sugar', 1500),
('Eggs', 12),
('Butter', 1000),
('Chocolate Chips', 400),
('Vanilla Extract', 50);

-- The recipes and their required quantities per batch
INSERT INTO recipe_requirements (recipe_name, ingredient_name, required_qty) VALUES
-- Chocolate Chip Cookies (Limited by Chocolate Chips)
('Chocolate Chip Cookies', 'Flour', 300),
('Chocolate Chip Cookies', 'Sugar', 150),
('Chocolate Chip Cookies', 'Eggs', 2),
('Chocolate Chip Cookies', 'Butter', 100),
('Chocolate Chip Cookies', 'Chocolate Chips', 200),

-- Pound Cake (Limited by Eggs)
('Pound Cake', 'Flour', 250),
('Pound Cake', 'Sugar', 250),
('Pound Cake', 'Eggs', 4),
('Pound Cake', 'Butter', 250),

-- Blueberry Muffin (Missing an ingredient entirely!)
('Blueberry Muffin', 'Flour', 400),
('Blueberry Muffin', 'Sugar', 200),
('Blueberry Muffin', 'Eggs', 2),
('Blueberry Muffin', 'Blueberries', 300),

-- Sugar Cookies (Plenty of ingredients available)
('Sugar Cookies', 'Flour', 200),
('Sugar Cookies', 'Sugar', 100),
('Sugar Cookies', 'Butter', 100);