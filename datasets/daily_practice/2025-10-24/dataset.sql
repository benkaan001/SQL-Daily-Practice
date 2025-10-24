CREATE DATABASE IF NOT EXISTS daily_practice_20251024_schema;
USE daily_practice_20251024_schema;

-- This table logs all user transactions and promotion redemptions in an e-commerce system.
CREATE TABLE user_transactions_and_promos (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME(3),
    -- 'APPLY_PROMO' logs the promo code. 'PURCHASE' logs the final cart value.
    event_type ENUM('APPLY_PROMO', 'PURCHASE'),
    promo_code VARCHAR(50), -- NULL for PURCHASE events
    purchase_value DECIMAL(10, 2) -- NULL for APPLY_PROMO events
);

INSERT INTO user_transactions_and_promos (user_id, event_timestamp, event_type, promo_code, purchase_value) VALUES
-- User 101: Applies a promo and purchases immediately.
(101, '2023-10-24 10:00:00.000', 'APPLY_PROMO', 'FALL20', NULL),
(101, '2023-10-24 10:01:00.000', 'PURCHASE', NULL, 80.00),

-- User 102: Applies a promo, browses, then purchases.
(102, '2023-10-24 11:00:00.000', 'APPLY_PROMO', 'NEWUSER15', NULL),
(102, '2023-10-24 11:30:00.000', 'PURCHASE', NULL, 120.00),

-- User 103: Applies a promo but never purchases (abandons cart).
(103, '2023-10-24 12:00:00.000', 'APPLY_PROMO', 'FALL20', NULL),

-- User 104: Makes a purchase without a promo.
(104, '2023-10-24 13:00:00.000', 'PURCHASE', NULL, 75.50),

-- User 101: Applies a second promo, then a third, and purchases. (Promo Stacking)
(101, '2023-10-25 14:00:00.000', 'APPLY_PROMO', 'VIP_ONLY', NULL),
(101, '2023-10-25 14:02:00.000', 'APPLY_PROMO', 'FREESHIP', NULL),
(101, '2023-10-25 14:05:00.000', 'PURCHASE', NULL, 210.00),

-- User 105: Applies a promo but it expires (no purchase within 1 hour).
(105, '2023-10-25 16:00:00.000', 'APPLY_PROMO', 'FLASH10', NULL),

-- User 102: Purchases again, no promo this time.
(102, '2023-10-25 17:00:00.000', 'PURCHASE', NULL, 45.00),

-- User 103: Finally returns and purchases, but applies a new promo.
(103, '2023-10-26 10:00:00.000', 'APPLY_PROMO', 'COMEBACK5', NULL),
(103, '2023-10-26 10:01:00.000', 'PURCHASE', NULL, 50.00);
