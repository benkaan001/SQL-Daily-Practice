-- Create the database and table for a delivery system
CREATE DATABASE IF NOT EXISTS daily_practice_20250328_schema;
USE daily_practice_20250328_schema;

-- Deliveries table captures order-placed time, predicted and actual delivery times, etc.
CREATE TABLE deliveries (
    delivery_id TEXT PRIMARY KEY,
    consumer_id TEXT,
    driver_id TEXT,
    restaurant_id TEXT,
    order_placed_time TIMESTAMP,
    predicted_delivery_time TIMESTAMP,
    actual_delivery_time TIMESTAMP,
    delivery_rating DOUBLE
);

-- Insert sample data
INSERT INTO deliveries (delivery_id, consumer_id, driver_id, restaurant_id, order_placed_time, predicted_delivery_time, actual_delivery_time, delivery_rating) VALUES
('D1', 'C1', 'DR1', 'R1', '2025-01-10 09:00:00', '2025-01-10 09:30:00', '2025-01-10 09:52:00', 4.5),  -- 22 min late (extremely late)
('D2', 'C2', 'DR2', 'R2', '2025-01-15 12:00:00', '2025-01-15 12:45:00', '2025-01-15 12:59:00', 4.0),  -- 14 min late
('D3', 'C3', 'DR1', 'R3', '2025-02-05 18:00:00', '2025-02-05 18:30:00', '2025-02-05 18:55:00', 3.5),  -- 25 min late
('D4', 'C4', 'DR3', 'R2', '2025-02-20 13:00:00', '2025-02-20 13:40:00', '2025-02-20 13:45:00', 4.2),  -- 5 min late
('D5', 'C1', 'DR2', 'R1', '2025-02-28 20:00:00', '2025-02-28 20:30:00', '2025-02-28 20:51:00', 3.8),  -- 21 min late
('D6', 'C2', 'DR3', 'R3', '2025-03-03 17:30:00', '2025-03-03 18:00:00', '2025-03-03 18:10:00', 4.7),  -- 10 min late
('D7', 'C5', 'DR2', 'R1', '2025-03-10 11:00:00', '2025-03-10 11:30:00', '2025-03-10 11:55:00', 4.1),  -- 25 min late
('D8', 'C4', 'DR1', 'R2', '2025-03-15 14:00:00', '2025-03-15 14:50:00', '2025-03-15 15:05:00', 4.3),  -- 15 min late
('D9', 'C2', 'DR2', 'R3', '2025-03-20 19:00:00', '2025-03-20 19:30:00', '2025-03-20 19:55:00', 3.9),  -- 25 min late
('D10', 'C3', 'DR3', 'R2', '2025-03-25 20:00:00', '2025-03-25 20:30:00', '2025-03-25 20:50:00', 4.6); -- exactly 20 min late, not extremely late