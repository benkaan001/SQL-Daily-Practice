CREATE DATABASE IF NOT EXISTS daily_practice_20250919_schema;
USE daily_practice_20250919_schema;

-- This table logs user sessions and the features they interact with.
-- A session is defined by a unique session_id.
CREATE TABLE feature_sessions (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    user_id INT,
    feature_name VARCHAR(50),
    event_timestamp DATETIME(3)
);

INSERT INTO feature_sessions (session_id, user_id, feature_name, event_timestamp) VALUES
-- User 101: First adopts 'dashboard', then uses other features.
('sess_A', 101, 'login', '2023-11-01 09:00:00.000'),
('sess_A', 101, 'dashboard', '2023-11-01 09:01:00.000'),
('sess_A', 101, 'reporting', '2023-11-01 09:10:00.000'),
('sess_A', 101, 'logout', '2023-11-01 09:30:00.000'),

-- User 102: First adopts 'reporting', has a shorter second session.
('sess_B', 102, 'login', '2023-11-01 10:00:00.000'),
('sess_B', 102, 'reporting', '2023-11-01 10:02:00.000'),
('sess_B', 102, 'dashboard', '2023-11-01 10:15:00.000'),
('sess_B', 102, 'logout', '2023-11-01 10:30:00.000'),
('sess_C', 102, 'login', '2023-11-02 11:00:00.000'), -- Second session
('sess_C', 102, 'reporting', '2023-11-02 11:01:00.000'),
('sess_C', 102, 'logout', '2023-11-02 11:15:00.000'),

-- User 103: First adopts 'dashboard', has one long session.
('sess_D', 103, 'login', '2023-11-02 14:00:00.000'),
('sess_D', 103, 'dashboard', '2023-11-02 14:01:00.000'),
('sess_D', 103, 'logout', '2023-11-02 14:45:00.000'),

-- User 104: Adopts 'settings' first, has multiple sessions.
('sess_E', 104, 'login', '2023-11-03 08:00:00.000'),
('sess_E', 104, 'settings', '2023-11-03 08:01:00.000'),
('sess_E', 104, 'dashboard', '2023-11-03 08:05:00.000'),
('sess_E', 104, 'logout', '2023-11-03 08:10:00.000'),
('sess_F', 104, 'login', '2023-11-04 09:00:00.000'),
('sess_F', 104, 'dashboard', '2023-11-04 09:02:00.000'),
('sess_F', 104, 'logout', '2023-11-04 09:22:00.000'),

-- User 101: Second session, already adopted 'dashboard' so this doesn't count as a first adoption.
('sess_G', 101, 'login', '2023-11-03 12:00:00.000'),
('sess_G', 101, 'reporting', '2023-11-03 12:05:00.000'),
('sess_G', 101, 'logout', '2023-11-03 12:45:00.000');
