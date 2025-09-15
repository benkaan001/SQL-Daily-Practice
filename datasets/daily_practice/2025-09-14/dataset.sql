CREATE DATABASE IF NOT EXISTS daily_practice_20250914_schema;
USE daily_practice_20250914_schema;

-- This table logs every user interaction in a multi-step online ordering process.
-- A single conceptual "order" is tied together by the session_id.
CREATE TABLE order_funnel_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    user_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('VIEW_ITEM', 'ADD_TO_CART', 'BEGIN_CHECKOUT', 'PAYMENT_SUCCESS', 'PAYMENT_FAILURE'),
    item_id INT,
    -- The price is only relevant for ADD_TO_CART events
    price DECIMAL(10, 2)
);

INSERT INTO order_funnel_events (session_id, user_id, event_timestamp, event_type, item_id, price) VALUES
-- User 101: Successful end-to-end purchase
('sess_A', 101, '2023-12-15 10:00:00.000', 'VIEW_ITEM', 1001, NULL),
('sess_A', 101, '2023-12-15 10:01:00.000', 'ADD_TO_CART', 1001, 25.50),
('sess_A', 101, '2023-12-15 10:02:30.000', 'BEGIN_CHECKOUT', NULL, NULL),
('sess_A', 101, '2023-12-15 10:03:00.000', 'PAYMENT_SUCCESS', NULL, NULL),

-- User 102: Adds to cart, but abandons before checkout
('sess_B', 102, '2023-12-15 11:30:00.000', 'VIEW_ITEM', 1002, NULL),
('sess_B', 102, '2023-12-15 11:30:30.000', 'ADD_TO_CART', 1002, 15.00),

-- User 103: Begins checkout, but payment fails
('sess_C', 103, '2023-12-15 14:00:00.000', 'VIEW_ITEM', 1003, NULL),
('sess_C', 103, '2023-12-15 14:00:15.000', 'ADD_TO_CART', 1003, 50.00),
('sess_C', 103, '2023-12-15 14:02:00.000', 'BEGIN_CHECKOUT', NULL, NULL),
('sess_C', 103, '2023-12-15 14:02:45.000', 'PAYMENT_FAILURE', NULL, NULL),

-- User 104: Another successful purchase, different timing
('sess_D', 104, '2023-12-16 09:00:00.000', 'VIEW_ITEM', 1001, NULL),
('sess_D', 104, '2023-12-16 09:00:20.000', 'ADD_TO_CART', 1001, 25.50),
('sess_D', 104, '2023-12-16 09:05:00.000', 'BEGIN_CHECKOUT', NULL, NULL),
('sess_D', 104, '2023-12-16 09:06:00.000', 'PAYMENT_SUCCESS', NULL, NULL),

-- User 102: Second session, abandons after viewing
('sess_E', 102, '2023-12-16 10:00:00.000', 'VIEW_ITEM', 1004, NULL),

-- User 103: Second session, successful purchase
('sess_F', 103, '2023-12-17 11:00:00.000', 'VIEW_ITEM', 1005, NULL),
('sess_F', 103, '2023-12-17 11:00:10.000', 'ADD_TO_CART', 1005, 10.00),
('sess_F', 103, '2023-12-17 11:01:00.000', 'BEGIN_CHECKOUT', NULL, NULL),
('sess_F', 103, '2023-12-17 11:01:20.000', 'PAYMENT_SUCCESS', NULL, NULL);
