CREATE DATABASE IF NOT EXISTS daily_practice_20251216_schema;
USE daily_practice_20251216_schema;

-- Logs status changes for support tickets.
CREATE TABLE ticket_status_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    status ENUM('OPEN', 'PENDING_CUSTOMER', 'RESOLVED'),
    change_timestamp DATETIME
);

INSERT INTO ticket_status_logs (ticket_id, status, change_timestamp) VALUES
-- Ticket 101: Simple resolution
(101, 'OPEN',             '2023-12-16 09:00:00'),
(101, 'PENDING_CUSTOMER', '2023-12-16 09:30:00'),
(101, 'RESOLVED',         '2023-12-16 10:00:00'),

-- Ticket 102: The Ping-Pong (Back and forth)
(102, 'OPEN',             '2023-12-16 12:00:00'),
(102, 'PENDING_CUSTOMER', '2023-12-16 12:10:00'), -- 1st switch
(102, 'OPEN',             '2023-12-16 12:20:00'), -- Back to Open
(102, 'PENDING_CUSTOMER', '2023-12-16 12:30:00'), -- 2nd switch
(102, 'OPEN',             '2023-12-16 12:40:00'), -- Back to Open
(102, 'PENDING_CUSTOMER', '2023-12-16 12:50:00'), -- 3rd switch (Flag this ticket)
(102, 'RESOLVED',         '2023-12-16 13:00:00');