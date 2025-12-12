CREATE DATABASE IF NOT EXISTS daily_practice_20251205_schema;
USE daily_practice_20251205_schema;

-- This table logs user login attempts with geolocation data.
CREATE TABLE auth_geo_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    timestamp DATETIME,
    country_code CHAR(2),
    status ENUM('SUCCESS', 'FAILURE')
);

INSERT INTO auth_geo_logs (user_id, timestamp, country_code, status) VALUES
-- User 101: Impossible Travel (US to JP in 1 hour)
(101, '2023-12-05 08:00:00', 'US', 'SUCCESS'),
(101, '2023-12-05 09:00:00', 'JP', 'SUCCESS'),

-- User 102: Normal Travel (US to US)
(102, '2023-12-05 08:00:00', 'US', 'SUCCESS'),
(102, '2023-12-05 12:00:00', 'US', 'SUCCESS'),

-- User 103: VPN hopping (3 countries in 10 minutes)
(103, '2023-12-05 10:00:00', 'FR', 'SUCCESS'),
(103, '2023-12-05 10:05:00', 'DE', 'SUCCESS'),
(103, '2023-12-05 10:09:00', 'BR', 'SUCCESS');