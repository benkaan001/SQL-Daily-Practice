CREATE DATABASE IF NOT EXISTS daily_practice_20251031_schema;
USE daily_practice_20251031_schema;

-- This table logs VPN (Virtual Private Network) sessions for users.
-- A session is considered active if session_end is NULL.
CREATE TABLE vpn_sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    server_id VARCHAR(50),
    session_start DATETIME(3),
    session_end DATETIME(3),
    data_transferred_gb DECIMAL(10, 2),
    client_version VARCHAR(20)
);

INSERT INTO vpn_sessions (session_id, user_id, server_id, session_start, session_end, data_transferred_gb, client_version) VALUES
-- User 101: A normal past session, a zombie session, and a new session
(1, 101, 'srv-A', '2023-11-17 08:00:00.000', '2023-11-17 18:00:00.000', 5.1, '1.1.0'),
(2, 101, 'srv-B', '2023-11-18 10:00:00.000', NULL, 15.5, '1.2.0'), -- Zombie session
(3, 101, 'srv-C', '2023-11-19 12:00:00.000', '2023-11-19 20:00:00.000', 6.7, '1.2.0'), -- Newer session

-- User 102: Normal past session
(4, 102, 'srv-B', '2023-11-19 09:00:00.000', '2023-11-19 17:00:00.000', 8.2, '1.2.0'),

-- User 103: A very old zombie session, no other activity
(5, 103, 'srv-C', '2023-11-15 08:00:00.000', NULL, 22.0, '1.1.0'), -- Zombie session

-- User 104: A session that is active but not yet a zombie
(6, 104, 'srv-B', '2023-11-20 08:00:00.000', NULL, 2.5, '1.2.0'), -- Only 4 hours open as of cutoff

-- User 105: Zombie session with an old client
(7, 105, 'srv-A', '2023-11-16 10:00:00.000', NULL, 30.0, '1.0.0'), -- Zombie session

-- User 102: Another recent, normal session
(8, 102, 'srv-A', '2023-11-20 10:00:00.000', '2023-11-20 11:00:00.000', 1.5, '1.2.0');
