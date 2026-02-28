CREATE DATABASE IF NOT EXISTS daily_practice_20260301_schema;
USE daily_practice_20260301_schema;

-- This table stores the initial registration date of users.
CREATE TABLE app_users (
    user_id INT PRIMARY KEY,
    signup_date DATE
);

-- This table logs every time a user logs into the application.
CREATE TABLE app_logins (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    login_date DATE
);

INSERT INTO app_users (user_id, signup_date) VALUES
(101, '2026-01-05'),
(102, '2026-01-15'),
(103, '2026-01-20'),
(104, '2026-02-02'),
(105, '2026-02-10');

INSERT INTO app_logins (user_id, login_date) VALUES
-- User 101: Active in Month 0 (Jan), Month 1 (Feb), and Month 2 (Mar)
(101, '2026-01-05'), 
(101, '2026-01-28'),
(101, '2026-02-10'),
(101, '2026-03-05'),

-- User 102: Active in Month 0 (Jan), inactive Month 1 (Feb), returns Month 2 (Mar)
(102, '2026-01-15'),
(102, '2026-03-12'),

-- User 103: Churns immediately (Active only in Month 0)
(103, '2026-01-20'),

-- User 104: Active in Month 0 (Feb) and Month 1 (Mar)
(104, '2026-02-02'),
(104, '2026-03-01'),

-- User 105: Active in Month 0 (Feb) only
(105, '2026-02-10');