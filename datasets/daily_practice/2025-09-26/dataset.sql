CREATE DATABASE IF NOT EXISTS daily_practice_20250926_schema;
USE daily_practice_20250926_schema;

-- This table logs user interactions within a SaaS application.
CREATE TABLE saas_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('PAGE_VIEW', 'FEATURE_CLICK'),
    event_details VARCHAR(255) -- For PAGE_VIEW, it's a URL path. For FEATURE_CLICK, it's a feature name.
);

INSERT INTO saas_events (user_id, session_id, event_timestamp, event_type, event_details) VALUES
-- User 101, Session A: Follows the "golden path" perfectly.
('101', 'sess_A', '2023-11-15 09:00:00.000', 'PAGE_VIEW', '/dashboard'),
('101', 'sess_A', '2023-11-15 09:01:30.000', 'FEATURE_CLICK', 'Create Project'),
('101', 'sess_A', '2023-11-15 09:02:15.000', 'PAGE_VIEW', '/projects/new'),
('101', 'sess_A', '2023-11-15 09:04:00.000', 'FEATURE_CLICK', 'Save Project'),

-- User 102, Session B: Does the path out of order.
('102', 'sess_B', '2023-11-15 10:00:00.000', 'FEATURE_CLICK', 'Create Project'),
('102', 'sess_B', '2023-11-15 10:01:00.000', 'PAGE_VIEW', '/dashboard'),
('102', 'sess_B', '2023-11-15 10:03:00.000', 'FEATURE_CLICK', 'Save Project'),

-- User 101, Session C: Does part of the path, then gets distracted.
('101', 'sess_C', '2023-11-16 11:00:00.000', 'PAGE_VIEW', '/dashboard'),
('101', 'sess_C', '2023-11-16 11:01:00.000', 'FEATURE_CLICK', 'Create Project'),
('101', 'sess_C', '2023-11-16 11:05:00.000', 'PAGE_VIEW', '/settings'), -- Distraction
('101', 'sess_C', '2023-11-16 11:06:00.000', 'FEATURE_CLICK', 'Update Profile'),

-- User 103, Session D: Views dashboard but does nothing else from the path.
('103', 'sess_D', '2023-11-16 14:00:00.000', 'PAGE_VIEW', '/dashboard'),
('103', 'sess_D', '2023-11-16 14:02:00.000', 'PAGE_VIEW', '/billing'),

-- User 104, Session E: Does the path with other events in between.
('104', 'sess_E', '2023-11-17 08:30:00.000', 'PAGE_VIEW', '/dashboard'),
('104', 'sess_E', '2023-11-17 08:31:00.000', 'PAGE_VIEW', '/help'), -- Interruption
('104', 'sess_E', '2023-11-17 08:32:00.000', 'FEATURE_CLICK', 'Create Project'),
('104', 'sess_E', '2023-11-17 08:33:00.000', 'FEATURE_CLICK', 'Save Project'),

-- User 102, Session F: A session with none of the relevant events.
('102', 'sess_F', '2023-11-17 09:00:00.000', 'PAGE_VIEW', '/profile'),
('102', 'sess_F', '2023-11-17 09:01:00.000', 'FEATURE_CLICK', 'Change Password');
