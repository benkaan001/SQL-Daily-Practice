CREATE DATABASE IF NOT EXISTS daily_practice_20250927_schema;
USE daily_practice_20250927_schema;

-- This table logs the various stages an e-commerce order goes through from placement to fulfillment.
CREATE TABLE order_fulfillment_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM(
        'ORDER_PLACED',
        'PAYMENT_CONFIRMED',
        'SENT_TO_WAREHOUSE',
        'PICKING_STARTED',
        'PACKING_COMPLETED',
        'SHIPPED',
        'DELIVERED',
        'CANCELLED'
    ),
    warehouse_id INT,
    shipping_partner VARCHAR(50)
);

INSERT INTO order_fulfillment_events (order_id, event_timestamp, event_type, warehouse_id, shipping_partner) VALUES
-- Order 101: Smooth and fast fulfillment
(101, '2023-11-20 09:00:00.000', 'ORDER_PLACED', NULL, NULL),
(101, '2023-11-20 09:01:00.000', 'PAYMENT_CONFIRMED', NULL, NULL),
(101, '2023-11-20 09:02:00.000', 'SENT_TO_WAREHOUSE', 1, NULL),
(101, '2023-11-20 10:00:00.000', 'PICKING_STARTED', 1, NULL),
(101, '2023-11-20 10:30:00.000', 'PACKING_COMPLETED', 1, NULL),
(101, '2023-11-20 11:00:00.000', 'SHIPPED', 1, 'FastShip'),
(101, '2023-11-22 14:00:00.000', 'DELIVERED', 1, 'FastShip'),

-- Order 102: Stuck in the picking stage for a long time
(102, '2023-11-21 14:00:00.000', 'ORDER_PLACED', NULL, NULL),
(102, '2023-11-21 14:05:00.000', 'PAYMENT_CONFIRMED', NULL, NULL),
(102, '2023-11-21 14:06:00.000', 'SENT_TO_WAREHOUSE', 2, NULL),
(102, '2023-11-21 18:00:00.000', 'PICKING_STARTED', 2, NULL),
-- This order is still in the 'PICKING_STARTED' stage as of the cutoff date.

-- Order 103: Cancelled by user before fulfillment
(103, '2023-11-22 11:00:00.000', 'ORDER_PLACED', NULL, NULL),
(103, '2023-11-22 11:02:00.000', 'PAYMENT_CONFIRMED', NULL, NULL),
(103, '2023-11-22 15:00:00.000', 'CANCELLED', NULL, NULL),

-- Order 104: Stuck after payment confirmation, not yet sent to warehouse
(104, '2023-11-23 09:30:00.000', 'ORDER_PLACED', NULL, NULL),
(104, '2023-11-23 09:31:00.000', 'PAYMENT_CONFIRMED', NULL, NULL),
-- This order is still in the 'PAYMENT_CONFIRMED' stage.

-- Order 105: Fulfilled correctly but took a while to ship after packing
(105, '2023-11-23 16:00:00.000', 'ORDER_PLACED', NULL, NULL),
(105, '2023-11-23 16:01:00.000', 'PAYMENT_CONFIRMED', NULL, NULL),
(105, '2023-11-23 16:02:00.000', 'SENT_TO_WAREHOUSE', 1, NULL),
(105, '2023-11-23 17:00:00.000', 'PICKING_STARTED', 1, NULL),
(105, '2023-11-23 17:45:00.000', 'PACKING_COMPLETED', 1, NULL),
(105, '2023-11-25 10:00:00.000', 'SHIPPED', 1, 'GroundEx');
