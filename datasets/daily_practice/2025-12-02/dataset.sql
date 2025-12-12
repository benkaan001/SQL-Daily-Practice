CREATE DATABASE IF NOT EXISTS daily_practice_20251202_schema;
USE daily_practice_20251202_schema;

-- This table logs the assignment history of customer support tickets to different support tiers.
CREATE TABLE ticket_assignments (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    change_timestamp DATETIME(3),
    assigned_tier ENUM('Tier 1', 'Tier 2', 'Tier 3'),
    agent_id INT
);

INSERT INTO ticket_assignments (ticket_id, change_timestamp, assigned_tier, agent_id) VALUES
-- Ticket 101: The classic "Boomerang" (T1 -> T2 -> T1 within a short time)
(101, '2023-12-01 09:00:00.000', 'Tier 1', 101),
(101, '2023-12-01 09:30:00.000', 'Tier 2', 201), -- Escalated
(101, '2023-12-01 10:15:00.000', 'Tier 1', 102), -- Sent back 45 mins later

-- Ticket 102: Successful escalation (T1 -> T2 -> T3)
(102, '2023-12-01 10:00:00.000', 'Tier 1', 103),
(102, '2023-12-01 10:45:00.000', 'Tier 2', 202),
(102, '2023-12-01 12:00:00.000', 'Tier 3', 301),

-- Ticket 103: Boomerang, but takes too long (Total time > 4 hours)
(103, '2023-12-01 08:00:00.000', 'Tier 1', 101),
(103, '2023-12-01 11:00:00.000', 'Tier 2', 203),
(103, '2023-12-01 13:00:00.000', 'Tier 1', 101), -- Sent back 5 hours after start

-- Ticket 104: Ping-ponging multiple times
(104, '2023-12-02 14:00:00.000', 'Tier 1', 104),
(104, '2023-12-02 14:10:00.000', 'Tier 2', 201), -- Boomerang Start
(104, '2023-12-02 14:20:00.000', 'Tier 1', 104), -- Boomerang End
(104, '2023-12-02 14:30:00.000', 'Tier 2', 202),
(104, '2023-12-02 15:00:00.000', 'Tier 3', 302),

-- Ticket 105: Starts at T2, goes to T1 (De-escalation, not a boomerang)
(105, '2023-12-02 09:00:00.000', 'Tier 2', 205),
(105, '2023-12-02 09:30:00.000', 'Tier 1', 105);