CREATE DATABASE IF NOT EXISTS daily_practice_20260513_schema;
USE daily_practice_20260513_schema;

-- Table 1: User Subscription Details
-- Plan names follow the pattern: CATEGORY:TYPE (e.g., PRO:FAMILY)
CREATE TABLE user_plans (
    user_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    join_date DATE,
    monthly_cost DECIMAL(10, 2)
);

-- Table 2: Viewing History
-- Titles follow the pattern: "Show Name | S# | E#" (e.g., "The Crown | S01 | E05")
CREATE TABLE viewing_history (
    view_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    show_title VARCHAR(255),
    genre VARCHAR(50),
    view_duration_mins INT,
    view_timestamp DATETIME,
    FOREIGN KEY (user_id) REFERENCES user_plans(user_id)
);

INSERT INTO user_plans (user_id, plan_name, join_date, monthly_cost) VALUES
(1, 'PREMIUM:FAMILY', '2026-01-10', 19.99),
(2, 'BASIC:INDIVIDUAL', '2026-02-15', 9.99),
(3, 'PREMIUM:INDIVIDUAL', '2026-03-01', 14.99),
(4, 'BASIC:FAMILY', '2026-03-20', 12.99),
(5, 'PREMIUM:FAMILY', '2026-04-05', 19.99);

INSERT INTO viewing_history (user_id, show_title, genre, view_duration_mins, view_timestamp) VALUES
(1, 'Midnight Sun | S01 | E01', 'Sci-Fi', 45, '2026-05-01 10:00:00'),
(1, 'Midnight Sun | S01 | E02', 'Sci-Fi', 50, '2026-05-01 11:00:00'),
(1, 'Cooking Master | S02 | E10', 'Reality', 30, '2026-05-02 15:00:00'),
(2, 'Midnight Sun | S01 | E01', 'Sci-Fi', 15, '2026-05-01 10:30:00'),
(2, 'Ocean Blue | S01 | E01', 'Documentary', 60, '2026-05-03 08:00:00'),
(3, 'Midnight Sun | S01 | E01', 'Sci-Fi', 48, '2026-05-01 12:00:00'),
(3, 'Midnight Sun | S01 | E02', 'Sci-Fi', 42, '2026-05-01 13:00:00'),
(3, 'Midnight Sun | S02 | E01', 'Sci-Fi', 55, '2026-05-05 20:00:00'),
(4, 'Midnight Sun | S01 | E01', 'Sci-Fi', 5, '2026-05-01 09:00:00'),
(4, 'Cooking Master | S01 | E01', 'Reality', 25, '2026-05-04 12:00:00'),
(4, 'Cooking Master | S01 | E02', 'Reality', 28, '2026-05-04 12:30:00'),
(5, 'Ocean Blue | S01 | E01', 'Documentary', 65, '2026-05-03 09:00:00'),
(5, 'Ocean Blue | S01 | E02', 'Documentary', 70, '2026-05-03 10:30:00'),
(5, 'Midnight Sun | S01 | E01', 'Sci-Fi', 40, '2026-05-06 21:00:00');