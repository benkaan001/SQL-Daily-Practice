CREATE DATABASE IF NOT EXISTS daily_practice_20251126_schema;
USE daily_practice_20251126_schema;

-- This table logs sequential actions for users, tracking score changes and time order.
CREATE TABLE user_action_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME(3),
    action_type VARCHAR(50),
    current_score INT
);

INSERT INTO user_action_log (user_id, event_timestamp, action_type, current_score) VALUES
-- User 101: Normal sequence
(101, '2023-12-01 10:00:00.000', 'Start Level', 10),
(101, '2023-12-01 10:01:00.000', 'Checkpoint', 50),
(101, '2023-12-01 10:02:00.000', 'Checkpoint', 80),
(101, '2023-12-01 10:03:00.000', 'End Level', 100),

-- User 102: Time Reversal (Fraudulent activity)
(102, '2023-12-01 11:00:00.000', 'Start Level', 5),
(102, '2023-12-01 11:01:00.000', 'Checkpoint', 15),
(102, '2023-12-01 10:59:00.000', 'Checkpoint', 20), -- Time Travel Violation (Event happened 2 minutes BEFORE the last log)
(102, '2023-12-01 11:03:00.000', 'End Level', 30),

-- User 103: Impossible Score Jump (Game exploit)
(103, '2023-12-02 12:00:00.000', 'Start Level', 10),
(103, '2023-12-02 12:01:00.000', 'Checkpoint', 50),
(103, '2023-12-02 12:02:00.000', 'Checkpoint', 200), -- Impossible Jump Violation (150 points gained in one step)
(103, '2023-12-02 12:03:00.000', 'End Level', 210),

-- User 104: Score Reversal (Game integrity violation)
(104, '2023-12-02 14:00:00.000', 'Start Level', 50),
(104, '2023-12-02 14:01:00.000', 'Checkpoint', 75),
(104, '2023-12-02 14:02:00.000', 'Checkpoint', 60), -- Score Reversal Violation (Score dropped)
(104, '2023-12-02 14:03:00.000', 'End Level', 80);