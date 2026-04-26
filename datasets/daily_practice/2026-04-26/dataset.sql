CREATE DATABASE IF NOT EXISTS daily_practice_20260426_schema;
USE daily_practice_20260426_schema;

-- This table logs user actions within an online grocery store cart.
CREATE TABLE cart_activity (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    event_timestamp DATETIME(3),
    action ENUM('ADD', 'REMOVE'),
    product_name VARCHAR(100)
);

INSERT INTO cart_activity (session_id, event_timestamp, action, product_name) VALUES
-- Session A: Substitutes Organic Eggs for Standard Eggs
('sess_A', '2026-04-26 10:00:00.000', 'ADD', 'Organic Eggs'),
('sess_A', '2026-04-26 10:05:00.000', 'REMOVE', 'Organic Eggs'),
('sess_A', '2026-04-26 10:06:00.000', 'ADD', 'Standard Eggs'), -- Valid substitution (1 min)

-- Session B: Also substitutes Organic Eggs for Standard Eggs
('sess_B', '2026-04-26 10:15:00.000', 'REMOVE', 'Organic Eggs'),
('sess_B', '2026-04-26 10:16:30.000', 'ADD', 'Standard Eggs'), -- Valid substitution (1.5 min)

-- Session C: Substitutes Organic Eggs for Egg Whites
('sess_C', '2026-04-26 10:30:00.000', 'REMOVE', 'Organic Eggs'),
('sess_C', '2026-04-26 10:32:00.000', 'ADD', 'Egg Whites'), -- Valid substitution (2 min)

-- Session D: Substitutes Whole Milk for Oat Milk
('sess_D', '2026-04-26 11:00:00.000', 'REMOVE', 'Whole Milk'),
('sess_D', '2026-04-26 11:02:00.000', 'ADD', 'Oat Milk'), -- Valid substitution

-- Session E: Substitutes Whole Milk for Almond Milk
('sess_E', '2026-04-26 11:15:00.000', 'REMOVE', 'Whole Milk'),
('sess_E', '2026-04-26 11:16:00.000', 'ADD', 'Almond Milk'), -- Valid substitution

-- Session F: Substitutes Whole Milk for Oat Milk again
('sess_F', '2026-04-26 11:30:00.000', 'REMOVE', 'Whole Milk'),
('sess_F', '2026-04-26 11:31:00.000', 'ADD', 'Oat Milk'), -- Valid substitution

-- Session G: Removes an item, but adds a new one too late (Not a substitution)
('sess_G', '2026-04-26 12:00:00.000', 'REMOVE', 'Avocado'),
('sess_G', '2026-04-26 12:05:00.000', 'ADD', 'Guacamole'), -- Invalid (5 mins > 3 mins)

-- Session H: Removes two items in a row (The first removal has no immediate ADD)
('sess_H', '2026-04-26 13:00:00.000', 'REMOVE', 'Apples'),
('sess_H', '2026-04-26 13:00:30.000', 'REMOVE', 'Oranges'),
('sess_H', '2026-04-26 13:01:00.000', 'ADD', 'Banana'); -- Valid sub for Oranges, not Apples