CREATE DATABASE IF NOT EXISTS daily_practice_20260324_schema;
USE daily_practice_20260324_schema;

-- This table tracks user signups and attributes them to the user who invited them.
CREATE TABLE user_referrals (
    user_id INT PRIMARY KEY,
    signup_date DATE,
    referred_by_id INT -- Contains the user_id of the referrer. NULL if organic.
);

INSERT INTO user_referrals (user_id, signup_date, referred_by_id) VALUES
-- The "Super Connector" (User 101) joins organically
(101, '2026-03-01', NULL),
(102, '2026-03-02', 101), -- Level 1 for User 101
(103, '2026-03-03', 101), -- Level 1 for User 101
(104, '2026-03-04', 101), -- Level 1 for User 101

-- User 102 invites their own friends (Level 2 for User 101)
(105, '2026-03-05', 102), 
(106, '2026-03-06', 102),

-- User 103 invites someone (Level 2 for User 101)
(107, '2026-03-07', 103),

-- User 105 invites someone (Level 3 for User 101, Level 2 for User 102)
(108, '2026-03-08', 105),

-- Normal users with smaller networks
(109, '2026-03-10', NULL),
(110, '2026-03-12', 109);