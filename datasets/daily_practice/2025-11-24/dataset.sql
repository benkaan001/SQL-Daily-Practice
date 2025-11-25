CREATE DATABASE IF NOT EXISTS daily_practice_20251124_schema;
USE daily_practice_20251124_schema;

-- This table logs key events in the checkout process, including the time taken for certain actions.
CREATE TABLE checkout_funnel_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    user_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('VIEW_CART', 'START_CHECKOUT', 'ENTER_SHIPPING', 'ENTER_PAYMENT', 'PURCHASE_COMPLETE')
);

INSERT INTO checkout_funnel_events (session_id, user_id, event_timestamp, event_type) VALUES
-- Session A: Successful, but slow shipping entry
('sess_A', 101, '2023-12-05 10:00:00.000', 'VIEW_CART'),
('sess_A', 101, '2023-12-05 10:01:00.000', 'START_CHECKOUT'),
('sess_A', 101, '2023-12-05 10:05:00.000', 'ENTER_SHIPPING'), -- 4 minutes in this stage
('sess_A', 101, '2023-12-05 10:05:30.000', 'ENTER_PAYMENT'),
('sess_A', 101, '2023-12-05 10:06:00.000', 'PURCHASE_COMPLETE'),

-- Session B: Very fast, successful checkout
('sess_B', 102, '2023-12-05 11:00:00.000', 'VIEW_CART'),
('sess_B', 102, '2023-12-05 11:00:15.000', 'START_CHECKOUT'),
('sess_B', 102, '2023-12-05 11:00:25.000', 'ENTER_SHIPPING'),
('sess_B', 102, '2023-12-05 11:00:35.000', 'ENTER_PAYMENT'),
('sess_B', 102, '2023-12-05 11:00:45.000', 'PURCHASE_COMPLETE'),

-- Session C: Slow payment entry, but successful
('sess_C', 103, '2023-12-05 12:00:00.000', 'VIEW_CART'),
('sess_C', 103, '2023-12-05 12:00:30.000', 'START_CHECKOUT'),
('sess_C', 103, '2023-12-05 12:01:00.000', 'ENTER_SHIPPING'),
('sess_C', 103, '2023-12-05 12:04:00.000', 'ENTER_PAYMENT'), -- 3 minutes in this stage
('sess_C', 103, '2023-12-05 12:04:30.000', 'PURCHASE_COMPLETE'),

-- Session D: Abandons after entering shipping (final stage is ENTER_SHIPPING)
('sess_D', 104, '2023-12-06 09:00:00.000', 'VIEW_CART'),
('sess_D', 104, '2023-12-06 09:00:30.000', 'START_CHECKOUT'),
('sess_D', 104, '2023-12-06 09:01:00.000', 'ENTER_SHIPPING'),

-- Session E: Abandons after payment entry (final stage is ENTER_PAYMENT)
('sess_E', 105, '2023-12-06 10:00:00.000', 'VIEW_CART'),
('sess_E', 105, '2023-12-06 10:01:00.000', 'START_CHECKOUT'),
('sess_E', 105, '2023-12-06 10:02:00.000', 'ENTER_SHIPPING'),
('sess_E', 105, '2023-12-06 10:02:30.000', 'ENTER_PAYMENT');