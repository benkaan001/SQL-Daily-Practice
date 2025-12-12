CREATE DATABASE IF NOT EXISTS daily_practice_20251209_schema;
USE daily_practice_20251209_schema;

-- Logs messages in a support ticket thread.
CREATE TABLE support_messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    sender_type ENUM('CUSTOMER', 'AGENT'),
    sent_at DATETIME
);

INSERT INTO support_messages (ticket_id, sender_type, sent_at) VALUES
-- Ticket 1: Fast response
(1, 'CUSTOMER', '2023-12-09 09:00:00'),
(1, 'AGENT',    '2023-12-09 09:15:00'), -- 15 mins

-- Ticket 2: Slow response (SLA Breach)
(2, 'CUSTOMER', '2023-12-09 10:00:00'),
(2, 'AGENT',    '2023-12-09 12:00:00'), -- 2 hours

-- Ticket 3: Multiple exchanges, finding the *first* response time
(3, 'CUSTOMER', '2023-12-09 14:00:00'),
(3, 'AGENT',    '2023-12-09 14:10:00'), -- 10 mins (First response)
(3, 'CUSTOMER', '2023-12-09 14:15:00'),
(3, 'AGENT',    '2023-12-09 15:00:00');