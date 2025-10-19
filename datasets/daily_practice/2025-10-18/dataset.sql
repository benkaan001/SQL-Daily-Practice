CREATE DATABASE IF NOT EXISTS daily_practice_20251018_schema;
USE daily_practice_20251018_schema;

-- This table logs the enabling and disabling of features for different user segments.
-- A NULL value in a segment column (e.g., country) means the rule applies to ALL values of that segment (a wildcard).
CREATE TABLE feature_flags (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_timestamp DATETIME(3),
    feature_name VARCHAR(50),
    status ENUM('ENABLED', 'DISABLED'),
    country VARCHAR(50), -- NULL means all countries
    device_type VARCHAR(50) -- NULL means all device types
);

INSERT INTO feature_flags (log_timestamp, feature_name, status, country, device_type) VALUES
-- Feature 'new_profile_page': Enabled for everyone, then disabled for a specific country (Conflict)
('2023-11-01 10:00:00.000', 'new_profile_page', 'ENABLED', NULL, NULL),
('2023-11-02 11:00:00.000', 'new_profile_page', 'DISABLED', 'CA', NULL),

-- Feature 'dark_mode': Enabled for mobile, but later disabled for all devices (No conflict, as the broader rule overrides)
('2023-11-03 09:00:00.000', 'dark_mode', 'ENABLED', NULL, 'mobile'),
('2023-11-04 14:00:00.000', 'dark_mode', 'DISABLED', NULL, NULL),

-- Feature 'beta_feature_x': Enabled for a specific country, disabled for a specific device (No conflict)
('2023-11-05 16:00:00.000', 'beta_feature_x', 'ENABLED', 'US', NULL),
('2023-11-06 18:00:00.000', 'beta_feature_x', 'DISABLED', NULL, 'tablet'),

-- Feature 'new_chat': Enabled for a country, then disabled for a more specific segment (country + device) (Conflict)
('2023-11-08 10:00:00.000', 'new_chat', 'ENABLED', 'DE', NULL),
('2023-11-09 11:00:00.000', 'new_chat', 'DISABLED', 'DE', 'android'),

-- Feature 'promo_banner': Was enabled and then disabled globally. (No conflict)
('2023-11-10 09:00:00.000', 'promo_banner', 'ENABLED', NULL, NULL),
('2023-11-12 09:00:00.000', 'promo_banner', 'DISABLED', NULL, NULL);
