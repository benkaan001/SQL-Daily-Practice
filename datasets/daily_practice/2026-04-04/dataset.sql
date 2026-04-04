CREATE DATABASE IF NOT EXISTS daily_practice_20260404_schema;
USE daily_practice_20260404_schema;

-- This table logs every daily session for users on a newly launched app.
CREATE TABLE user_sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_date DATE
);

INSERT INTO user_sessions (user_id, session_date) VALUES
-- Launch Day (April 1st): 3 brand new users
(101, '2026-04-01'),
(102, '2026-04-01'),
(103, '2026-04-01'),

-- Day 2: 1 new user, plus 1 returning user
(101, '2026-04-02'), -- Returning
(104, '2026-04-02'), -- New

-- Day 3: 0 new users, only returning users
(102, '2026-04-03'), -- Returning
(103, '2026-04-03'), -- Returning

-- Day 4: 2 new users, plus 1 returning user
(105, '2026-04-04'), -- New
(106, '2026-04-04'), -- New
(101, '2026-04-04'); -- Returning