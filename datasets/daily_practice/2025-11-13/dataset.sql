CREATE DATABASE IF NOT EXISTS daily_practice_20251113_schema;
USE daily_practice_20251113_schema;

-- This table logs user activity in a fitness application.
CREATE TABLE fitness_activity_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME,
    event_type ENUM('LOGIN', 'VIEW_WORKOUT', 'START_WORKOUT', 'COMPLETED_WORKOUT'),
    details JSON
);

INSERT INTO fitness_activity_logs (user_id, event_timestamp, event_type, details) VALUES
-- User 101: 3-day streak
(101, '2023-11-01 08:00:00', 'LOGIN', NULL),
(101, '2023-11-01 08:01:00', 'VIEW_WORKOUT', '{"workout_id": 101}'),
(101, '2023-11-01 08:05:00', 'START_WORKOUT', '{"workout_id": 101}'),
(101, '2023-11-01 08:35:00', 'COMPLETED_WORKOUT', '{"workout_id": 101, "duration_minutes": 30}'),
(101, '2023-11-02 09:00:00', 'LOGIN', NULL),
(101, '2023-11-02 09:05:00', 'START_WORKOUT', '{"workout_id": 102}'),
(101, '2023-11-02 09:50:00', 'COMPLETED_WORKOUT', '{"workout_id": 102, "duration_minutes": 45}'),
(101, '2023-11-03 08:30:00', 'LOGIN', NULL),
(101, '2023-11-03 08:35:00', 'START_WORKOUT', '{"workout_id": 101}'),
(101, '2023-11-03 09:05:00', 'COMPLETED_WORKOUT', '{"workout_id": 101, "duration_minutes": 30}'),
(101, '2023-11-04 10:00:00', 'LOGIN', NULL), -- Break day, just logs in
(101, '2023-11-04 10:01:00', 'VIEW_WORKOUT', '{"workout_id": 103}'),

-- User 102: 2-day streak, break, 4-day streak
(102, '2023-11-01 18:00:00', 'LOGIN', NULL),
(102, '2023-11-01 18:05:00', 'START_WORKOUT', '{"workout_id": 201}'),
(102, '2023-11-01 18:35:00', 'COMPLETED_WORKOUT', '{"workout_id": 201, "duration_minutes": 30}'),
(102, '2023-11-02 19:00:00', 'LOGIN', NULL),
(102, '2023-11-02 19:10:00', 'START_WORKOUT', '{"workout_id": 201}'),
(102, '2023-11-02 19:40:00', 'COMPLETED_WORKOUT', '{"workout_id": 201, "duration_minutes": 30}'), -- 2-day streak
(102, '2023-11-04 17:00:00', 'LOGIN', NULL), -- Break day
(102, '2023-11-05 18:00:00', 'LOGIN', NULL),
(102, '2023-11-05 18:05:00', 'START_WORKOUT', '{"workout_id": 202}'),
(102, '2023-11-05 18:50:00', 'COMPLETED_WORKOUT', '{"workout_id": 202, "duration_minutes": 45}'), -- Start 4-day streak
(102, '2023-11-06 18:00:00', 'LOGIN', NULL),
(102, '2023-11-06 18:05:00', 'START_WORKOUT', '{"workout_id": 202}'),
(102, '2023-11-06 18:50:00', 'COMPLETED_WORKOUT', '{"workout_id": 202, "duration_minutes": 45}'),
(102, '2023-11-07 18:00:00', 'LOGIN', NULL),
(102, '2023-11-07 18:05:00', 'START_WORKOUT', '{"workout_id": 203}'),
(102, '2023-11-07 19:05:00', 'COMPLETED_WORKOUT', '{"workout_id": 203, "duration_minutes": 60}'),
(102, '2023-11-08 18:00:00', 'LOGIN', NULL),
(102, '2023-11-08 18:05:00', 'START_WORKOUT', '{"workout_id": 203}'),
(102, '2023-11-08 19:05:00', 'COMPLETED_WORKOUT', '{"workout_id": 203, "duration_minutes": 60}'), -- End 4-day streak

-- User 103: Sporadic, no streak
(103, '2023-11-01 07:00:00', 'LOGIN', NULL),
(103, '2023-11-01 07:05:00', 'START_WORKOUT', '{"workout_id": 101}'),
(103, '2023-11-01 07:35:00', 'COMPLETED_WORKOUT', '{"workout_id": 101, "duration_minutes": 30}'),
(103, '2023-11-03 07:00:00', 'LOGIN', NULL),
(103, '2023-11-03 07:05:00', 'START_WORKOUT', '{"workout_id": 101}'),
(103, '2023-11-03 07:35:00', 'COMPLETED_WORKOUT', '{"workout_id": 101, "duration_minutes": 30}'),
(103, '2023-11-06 07:00:00', 'LOGIN', NULL),
(103, '2023-11-06 07:05:00', 'START_WORKOUT', '{"workout_id": 101}'),
(103, '2023-11-06 07:35:00', 'COMPLETED_WORKOUT', '{"workout_id": 101, "duration_minutes": 30}'),

-- User 101: Another 3-day streak
(101, '2023-11-10 09:00:00', 'LOGIN', NULL),
(101, '2023-11-10 09:10:00', 'START_WORKOUT', '{"workout_id": 101}'),
(101, '2023-11-10 09:40:00', 'COMPLETED_WORKOUT', '{"workout_id": 101, "duration_minutes": 30}'),
(101, '2023-11-11 09:00:00', 'LOGIN', NULL),
(101, '2023-11-11 09:15:00', 'START_WORKOUT', '{"workout_id": 102}'),
(101, '2023-11-11 10:00:00', 'COMPLETED_WORKOUT', '{"workout_id": 102, "duration_minutes": 45}'),
(101, '2023-11-12 10:00:00', 'LOGIN', NULL),
(101, '2023-11-12 10:05:00', 'START_WORKOUT', '{"workout_id": 101}'),
(101, '2023-11-12 10:35:00', 'COMPLETED_WORKOUT', '{"workout_id": 101, "duration_minutes": 30}');