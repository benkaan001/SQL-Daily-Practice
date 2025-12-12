CREATE DATABASE IF NOT EXISTS daily_practice_20251206_schema;
USE daily_practice_20251206_schema;

CREATE TABLE user_logins (
    user_id INT,
    login_time DATETIME
);

CREATE TABLE subscriptions (
    user_id INT,
    status ENUM('ACTIVE', 'CANCELLED'),
    monthly_fee DECIMAL(10, 2)
);

INSERT INTO subscriptions (user_id, status, monthly_fee) VALUES
(101, 'ACTIVE', 10.00),
(102, 'ACTIVE', 20.00),
(103, 'CANCELLED', 10.00);

INSERT INTO user_logins (user_id, login_time) VALUES
(101, '2023-12-01 10:00:00'), -- Active recently
(102, '2023-09-01 10:00:00'), -- Active sub, but hasn't logged in for > 90 days
(103, '2023-11-20 10:00:00');