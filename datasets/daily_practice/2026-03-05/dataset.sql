CREATE DATABASE IF NOT EXISTS daily_practice_20260305_schema;
USE daily_practice_20260305_schema;

-- This table logs user events tracking their journey through an e-commerce platform.
CREATE TABLE event_log (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    user_id INT,
    event_time DATETIME,
    event_name ENUM('PAGE_VIEW', 'ADD_TO_CART', 'CHECKOUT', 'PURCHASE')
);

INSERT INTO event_log (session_id, user_id, event_time, event_name) VALUES
-- Session s1: Completes the entire funnel
('s1', 101, '2026-03-05 10:00:00', 'PAGE_VIEW'),
('s1', 101, '2026-03-05 10:05:00', 'ADD_TO_CART'),
('s1', 101, '2026-03-05 10:10:00', 'CHECKOUT'),
('s1', 101, '2026-03-05 10:15:00', 'PURCHASE'),

-- Session s2: Drops off after adding to cart
('s2', 102, '2026-03-05 11:00:00', 'PAGE_VIEW'),
('s2', 102, '2026-03-05 11:05:00', 'ADD_TO_CART'),

-- Session s3: Drops off during checkout
('s3', 103, '2026-03-05 12:00:00', 'PAGE_VIEW'),
('s3', 103, '2026-03-05 12:05:00', 'ADD_TO_CART'),
('s3', 103, '2026-03-05 12:10:00', 'CHECKOUT'),

-- Session s4: Bounces immediately (only page view)
('s4', 104, '2026-03-05 13:00:00', 'PAGE_VIEW'),

-- Session s5: Completes the entire funnel
('s5', 105, '2026-03-05 14:00:00', 'PAGE_VIEW'),
('s5', 105, '2026-03-05 14:05:00', 'ADD_TO_CART'),
('s5', 105, '2026-03-05 14:10:00', 'CHECKOUT'),
('s5', 105, '2026-03-05 14:15:00', 'PURCHASE'),

-- Session s6: Drops off after adding to cart
('s6', 106, '2026-03-05 15:00:00', 'PAGE_VIEW'),
('s6', 106, '2026-03-05 15:05:00', 'ADD_TO_CART');