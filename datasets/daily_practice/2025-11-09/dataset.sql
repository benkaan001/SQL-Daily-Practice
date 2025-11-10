CREATE DATABASE IF NOT EXISTS daily_practice_20251109_schema;
USE daily_practice_20251109_schema;

-- This table logs the billing cycle status for user subscriptions.
CREATE TABLE subscription_billing_cycles (
    cycle_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    subscription_id VARCHAR(50),
    billing_cycle_start DATE,
    billing_cycle_end DATE,
    status ENUM('PAID', 'FAILED', 'PENDING'),
    amount DECIMAL(10, 2)
);

INSERT INTO subscription_billing_cycles (user_id, subscription_id, billing_cycle_start, billing_cycle_end, status, amount) VALUES
-- User 101: All payments successful
(101, 'sub_A', '2023-09-01', '2023-09-30', 'PAID', 15.00),
(101, 'sub_A', '2023-10-01', '2023-10-31', 'PAID', 15.00),
(101, 'sub_A', '2023-11-01', '2023-11-30', 'PAID', 15.00),

-- User 102: Fails a payment, but recovers and pays the next cycle
(102, 'sub_B', '2023-09-15', '2023-10-14', 'PAID', 50.00),
(102, 'sub_B', '2023-10-15', '2023-11-14', 'FAILED', 50.00),
(102, 'sub_B', '2023-11-15', '2023-12-14', 'PAID', 50.00), -- Recovered

-- User 103: Fails their most recent payment (At-Risk)
(103, 'sub_C', '2023-10-01', '2023-10-31', 'PAID', 25.00),
(103, 'sub_C', '2023-11-01', '2023-11-30', 'PAID', 25.00),
(103, 'sub_C', '2023-12-01', '2023-12-31', 'FAILED', 25.00), -- At-Risk

-- User 104: Fails their most recent payment (At-Risk)
(104, 'sub_D', '2023-10-15', '2023-11-14', 'PAID', 10.00),
(104, 'sub_D', '2023-11-15', '2023-12-14', 'FAILED', 10.00), -- At-Risk

-- User 105: Pending payment, not yet failed
(105, 'sub_E', '2023-11-01', '2023-11-30', 'PAID', 20.00),
(105, 'sub_E', '2023-12-01', '2023-12-31', 'PENDING', 20.00), -- Pending, not FAILED

-- User 103: A different subscription that is fine
(103, 'sub_F', '2023-11-20', '2023-12-19', 'PAID', 5.00);