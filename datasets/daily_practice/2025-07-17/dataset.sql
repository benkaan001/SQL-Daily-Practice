-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250717_schema;
USE daily_practice_20250717_schema;


-- Create CustomerEvents Table
CREATE TABLE CustomerEvents (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(50) NOT NULL, -- e.g., 'Login', 'Purchase', 'Subscription_Renewal', 'Cancellation'
    value DECIMAL(10, 2), -- Relevant for purchase/renewal, NULL otherwise
    details TEXT -- Optional details, can be NULL
);

-- Insert Data into CustomerEvents Table
-- Customer 1 (Active, consistent purchases, one cancellation attempt)
INSERT INTO CustomerEvents (customer_id, event_date, event_type, value, details) VALUES
(1, '2024-01-01', 'Login', NULL, NULL),
(1, '2024-01-05', 'Purchase', 50.00, 'Item A'),
(1, '2024-01-10', 'Login', NULL, NULL),
(1, '2024-02-01', 'Subscription_Renewal', 10.00, NULL),
(1, '2024-02-15', 'Purchase', 75.00, 'Item B'),
(1, '2024-03-01', 'Login', NULL, NULL),
(1, '2024-03-05', 'Cancellation', NULL, 'Decided not to cancel'), -- Cancellation event, but not actual churn
(1, '2024-03-10', 'Login', NULL, NULL),
(1, '2024-03-15', 'Purchase', 20.00, 'Item C');

-- Customer 2 (Churned after a period of inactivity)
INSERT INTO CustomerEvents (customer_id, event_date, event_type, value, details) VALUES
(2, '2024-01-01', 'Login', NULL, NULL),
(2, '2024-01-15', 'Purchase', 120.00, 'Item X'),
(2, '2024-02-01', 'Login', NULL, NULL),
(2, '2024-03-01', 'Login', NULL, NULL),
(2, '2024-04-10', 'Cancellation', NULL, 'Account closed'); -- Actual churn

-- Customer 3 (Sporadic activity, no churn)
INSERT INTO CustomerEvents (customer_id, event_date, event_type, value, details) VALUES
(3, '2024-01-01', 'Login', NULL, NULL),
(3, '2024-01-20', 'Purchase', 30.00, 'Item Y'),
(3, '2024-03-01', 'Login', NULL, NULL),
(3, '2024-05-10', 'Purchase', 45.00, 'Item Z');

-- Customer 4 (New customer, few events)
INSERT INTO CustomerEvents (customer_id, event_date, event_type, value, details) VALUES
(4, '2024-04-01', 'Login', NULL, NULL),
(4, '2024-04-05', 'Purchase', 10.00, 'Item D');

-- Customer 5 (Active, but no purchases)
INSERT INTO CustomerEvents (customer_id, event_date, event_type, value, details) VALUES
(5, '2024-01-01', 'Login', NULL, NULL),
(5, '2024-01-10', 'Login', NULL, NULL),
(5, '2024-02-01', 'Login', NULL, NULL),
(5, '2024-03-01', 'Login', NULL, NULL),
(5, '2024-04-01', 'Login', NULL, NULL);

-- Customer 6 (No events) - for testing customers who never appeared
