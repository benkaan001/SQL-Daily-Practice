CREATE DATABASE IF NOT EXISTS daily_practice_20251129_schema;
USE daily_practice_20251129_schema;

-- This table logs the lifecycle events of customer support tickets.
CREATE TABLE ticket_lifecycle_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('CREATED', 'CLOSED', 'REOPENED'),
    actor_id INT, -- ID of the Agent for 'CLOSED', or Customer for 'CREATED'/'REOPENED'
    role ENUM('AGENT', 'CUSTOMER')
);

INSERT INTO ticket_lifecycle_events (ticket_id, event_timestamp, event_type, actor_id, role) VALUES
-- Ticket 101: Agent closes it, customer reopens quickly (Premature Closure)
(101, '2023-11-10 09:00:00.000', 'CREATED', 501, 'CUSTOMER'),
(101, '2023-11-10 10:00:00.000', 'CLOSED', 201, 'AGENT'),
(101, '2023-11-10 12:00:00.000', 'REOPENED', 501, 'CUSTOMER'), -- Reopened 2 hours later
(101, '2023-11-11 09:00:00.000', 'CLOSED', 202, 'AGENT'), -- Closed properly by a different agent

-- Ticket 102: Closed and stays closed (Success)
(102, '2023-11-10 11:00:00.000', 'CREATED', 502, 'CUSTOMER'),
(102, '2023-11-10 11:30:00.000', 'CLOSED', 201, 'AGENT'),

-- Ticket 103: Agent closes, user reopens days later (New issue, not premature)
(103, '2023-11-10 13:00:00.000', 'CREATED', 503, 'CUSTOMER'),
(103, '2023-11-10 13:45:00.000', 'CLOSED', 203, 'AGENT'),
(103, '2023-11-15 09:00:00.000', 'REOPENED', 503, 'CUSTOMER'), -- 5 days later
(103, '2023-11-15 10:00:00.000', 'CLOSED', 203, 'AGENT'),

-- Ticket 104: The "Ping Pong" - Multiple premature closures by the same agent
(104, '2023-11-12 08:00:00.000', 'CREATED', 504, 'CUSTOMER'),
(104, '2023-11-12 08:30:00.000', 'CLOSED', 204, 'AGENT'),
(104, '2023-11-12 09:00:00.000', 'REOPENED', 504, 'CUSTOMER'), -- Reopen #1 (30 mins later)
(104, '2023-11-12 09:30:00.000', 'CLOSED', 204, 'AGENT'), -- Agent closes again
(104, '2023-11-12 10:00:00.000', 'REOPENED', 504, 'CUSTOMER'), -- Reopen #2 (30 mins later)
(104, '2023-11-12 12:00:00.000', 'CLOSED', 205, 'AGENT'); -- Finally closed by someone else