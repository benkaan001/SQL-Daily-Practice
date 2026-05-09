CREATE DATABASE IF NOT EXISTS daily_practice_20260509_schema;
USE daily_practice_20260509_schema;

-- This table logs the first time a user interacts with a specific product feature.
CREATE TABLE feature_adoption_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    feature_name VARCHAR(50),
    adoption_date DATE
);

INSERT INTO feature_adoption_log (user_id, feature_name, adoption_date) VALUES
-- User 101: Adopts A, then B, then C
(101, 'Dashboard', '2026-01-05'),
(101, 'Reporting', '2026-02-10'),
(101, 'API_Access', '2026-03-15'),

-- User 102: Adopts B, then A
(102, 'Reporting', '2026-01-10'),
(102, 'Dashboard', '2026-01-20'),

-- User 103: Only ever adopts A
(103, 'Dashboard', '2026-02-01'),

-- User 104: Adopts A, then C
(104, 'Dashboard', '2026-02-05'),
(104, 'API_Access', '2026-04-01'),

-- User 105: Adopts C, then A
(105, 'API_Access', '2026-01-15'),
(105, 'Dashboard', '2026-02-05'),

-- User 106: Adopts B, then C
(106, 'Reporting', '2026-03-01'),
(106, 'API_Access', '2026-03-10');