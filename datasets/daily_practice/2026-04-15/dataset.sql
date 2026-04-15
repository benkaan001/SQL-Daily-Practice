CREATE DATABASE IF NOT EXISTS daily_practice_20260414_schema;
USE daily_practice_20260414_schema;

-- This table logs user authentication events, capturing a hidden device fingerprint.
CREATE TABLE access_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    device_fingerprint VARCHAR(50),
    login_timestamp DATETIME
);

INSERT INTO access_logs (user_id, device_fingerprint, login_timestamp) VALUES
-- Device A: Flagrant multi-accounting within 12 hours
(101, 'dev_A_99x', '2026-04-14 08:00:00'),
(102, 'dev_A_99x', '2026-04-14 10:30:00'), -- 2.5 hours later

-- Device B: Two users share a device, but 48 hours apart (Safe, maybe a shared library computer)
(103, 'dev_B_77y', '2026-04-12 09:00:00'),
(104, 'dev_B_77y', '2026-04-14 09:00:00'),

-- Device C: A "Fraud Ring" of 3 accounts logging in rapidly
(105, 'dev_C_55z', '2026-04-14 12:00:00'),
(106, 'dev_C_55z', '2026-04-14 12:15:00'), -- 15 mins after 105
(107, 'dev_C_55z', '2026-04-14 13:00:00'), -- 45 mins after 106, 1 hour after 105

-- Device D: Multi-accounting, but user 109 logs in BEFORE user 108
(108, 'dev_D_33w', '2026-04-14 15:00:00'),
(109, 'dev_D_33w', '2026-04-14 14:00:00'), -- 1 hour before 108

-- User 101 also logs in from a clean device (Normal behavior)
(101, 'dev_E_11v', '2026-04-14 18:00:00');