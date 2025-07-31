CREATE DATABASE IF NOT EXISTS daily_practice_20250731_schema;
USE daily_practice_20250731_schema;

CREATE TABLE customer_support_tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    agent_id INT,
    product_category VARCHAR(50),
    issue_type VARCHAR(100),
    date_opened DATETIME,
    date_closed DATETIME,
    priority ENUM('Low', 'Medium', 'High', 'Critical'),
    resolution TEXT,
    satisfaction_rating INT
);

INSERT INTO customer_support_tickets (ticket_id, customer_id, agent_id, product_category, issue_type, date_opened, date_closed, priority, resolution, satisfaction_rating) VALUES
(1, 101, 501, 'Electronics', 'Product Defect', '2023-01-15 10:30:00', '2023-01-18 11:00:00', 'High', 'Replacement issued', 5),
(2, 102, 502, 'Software', 'Login Issue', '2023-01-16 11:05:00', '2023-01-16 11:45:00', 'Medium', 'Password reset instructions sent', 4),
(3, 103, 501, 'Home Goods', 'Shipping Delay', '2023-01-17 14:00:00', '2023-01-20 16:30:00', 'Low', 'Provided tracking update and shipping refund', 3),
(4, 101, 503, 'Software', 'Feature Request', '2023-01-18 09:00:00', NULL, 'Low', NULL, NULL),
(5, 104, 502, 'Electronics', 'Billing Inquiry', '2023-01-19 16:20:00', '2023-01-19 17:00:00', 'Medium', 'Corrected invoice and resent', 4),
(6, 105, NULL, 'Apparel', 'Return Request', '2023-01-20 13:15:00', '2023-01-21 10:00:00', 'Medium', 'Return label sent', 5),
(7, 102, 501, 'Software', 'Performance Issue', '2023-01-21 18:00:00', '2023-01-23 12:30:00', 'High', 'Escalated to engineering team', 2),
(8, 106, 504, 'Home Goods', 'Damaged Item', '2023-01-22 11:50:00', '2023-01-25 15:00:00', 'High', 'Full refund processed', 5),
(9, 107, 503, 'Electronics', 'Compatibility Question', '2023-01-23 10:00:00', '2023-01-23 10:30:00', 'Low', 'Provided compatibility chart', 5),
(10, 101, 502, 'Software', 'Installation Error', '2023-01-24 15:00:00', '2023-01-25 17:00:00', 'Critical', 'Remote session with technician', 5),
(11, 108, 505, 'Books', 'Order Cancellation', '2023-01-25 09:45:00', '2023-01-25 09:55:00', 'Medium', 'Order successfully cancelled', 4),
(12, 109, 504, 'Home Goods', 'Wrong Item Received', '2023-01-26 12:10:00', NULL, 'High', NULL, NULL),
(13, 103, 501, 'Electronics', 'Warranty Inquiry', '2023-01-27 16:00:00', '2023-01-28 18:00:00', 'Medium', 'Clarified warranty terms', 3),
(14, 110, NULL, 'Software', 'Subscription Inquiry', '2023-01-28 11:30:00', '2023-01-28 11:50:00', 'Low', 'Provided subscription plan details', 4),
(15, 104, 502, 'Electronics', 'Product Defect', '2023-01-29 14:20:00', '2023-02-02 11:00:00', 'Critical', 'Replacement issued', 5),
(16, 102, 503, 'Software', 'Login Issue', '2023-01-30 09:00:00', '2023-01-30 09:15:00', 'Medium', 'Password reset instructions sent', 5),
(17, 111, 505, 'Apparel', 'Size Exchange', '2023-02-01 10:00:00', '2023-02-03 14:00:00', 'Medium', 'Exchange processed and new item shipped', 4),
(18, 105, 501, 'Home Goods', 'Shipping Delay', '2023-02-02 13:00:00', '2023-02-05 17:30:00', 'Low', 'Provided tracking update', 2),
(19, 107, 504, 'Electronics', 'Billing Inquiry', '2023-02-03 15:00:00', '2023-02-03 15:45:00', 'Medium', 'Explained charges', 3),
(20, 101, 502, 'Software', 'Feature Request', '2023-02-04 11:00:00', NULL, 'Low', NULL, NULL),
(21, 112, NULL, 'Home Goods', 'Damaged Item', '2023-02-05 16:00:00', '2023-02-08 18:00:00', 'High', 'Replacement shipped', 5),
(22, 104, 503, 'Electronics', 'Product Defect', '2023-02-06 17:30:00', '2023-02-10 12:00:00', 'High', 'Full refund processed', 4),
(23, 113, 501, 'Software', 'Performance Issue', '2023-02-07 09:20:00', '2023-02-09 11:00:00', 'Critical', 'Patch deployed', 3),
(24, 106, 504, 'Home Goods', 'Return Request', '2023-02-08 14:00:00', '2023-02-09 10:30:00', 'Medium', 'Return label sent', 5),
(25, 108, 505, 'Books', 'Shipping Inquiry', '2023-02-09 18:00:00', '2023-02-10 18:30:00', 'Low', 'Provided tracking number', 4);
