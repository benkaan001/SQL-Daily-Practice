CREATE DATABASE IF NOT EXISTS daily_practice_20250828_schema;
USE daily_practice_20250828_schema;

-- This table logs events related to feature flag changes and application errors.
CREATE TABLE feature_flag_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_timestamp DATETIME(3),
    user_id INT, -- NULL for system-level events like flag changes
    event_type ENUM('FLAG_ENABLED', 'FLAG_DISABLED', 'USER_EXPOSED', 'APP_ERROR'),
    details JSON
);

INSERT INTO feature_flag_events (user_id, event_timestamp, event_type, details) VALUES
-- Feature 'new_search_algo': Gradual rollout
(NULL, '2023-11-20 09:00:00.000', 'FLAG_ENABLED', '{"feature_name": "new_search_algo", "rollout_pct": 10}'),
(101, '2023-11-20 09:05:00.000', 'USER_EXPOSED', '{"feature_name": "new_search_algo"}'),
(102, '2023-11-20 09:10:00.000', 'USER_EXPOSED', '{"feature_name": "new_search_algo"}'),
(NULL, '2023-11-21 09:00:00.000', 'FLAG_ENABLED', '{"feature_name": "new_search_algo", "rollout_pct": 50}'),
(103, '2023-11-21 09:15:00.000', 'USER_EXPOSED', '{"feature_name": "new_search_algo"}'),
(104, '2023-11-21 09:20:00.000', 'USER_EXPOSED', '{"feature_name": "new_search_algo"}'),
(105, '2023-11-21 09:25:00.000', 'USER_EXPOSED', '{"feature_name": "new_search_algo"}'),
(NULL, '2023-11-22 09:00:00.000', 'FLAG_ENABLED', '{"feature_name": "new_search_algo", "rollout_pct": 100}'),
(106, '2023-11-22 09:30:00.000', 'USER_EXPOSED', '{"feature_name": "new_search_algo"}'),

-- Feature 'new_checkout_ui': Causes errors and is rolled back
(NULL, '2023-11-25 14:00:00.000', 'FLAG_ENABLED', '{"feature_name": "new_checkout_ui", "rollout_pct": 100}'),
(201, '2023-11-25 14:02:00.000', 'USER_EXPOSED', '{"feature_name": "new_checkout_ui"}'),
(201, '2023-11-25 14:02:30.500', 'APP_ERROR', '{"error_code": 500, "source": "checkout_service"}'), -- First error
(202, '2023-11-25 14:03:00.000', 'USER_EXPOSED', '{"feature_name": "new_checkout_ui"}'),
(202, '2023-11-25 14:03:45.000', 'APP_ERROR', '{"error_code": 500, "source": "checkout_service"}'),
(203, '2023-11-25 14:04:00.000', 'USER_EXPOSED', '{"feature_name": "new_checkout_ui"}'), -- No error for this user
(NULL, '2023-11-25 14:10:00.000', 'FLAG_DISABLED', '{"feature_name": "new_checkout_ui"}'), -- Rollback
(204, '2023-11-25 14:12:00.000', 'USER_EXPOSED', '{"feature_name": "new_checkout_ui"}'), -- User exposed AFTER rollback, should be ignored

-- Feature 'recommendations_v2': No errors
(NULL, '2023-11-26 10:00:00.000', 'FLAG_ENABLED', '{"feature_name": "recommendations_v2", "rollout_pct": 100}'),
(301, '2023-11-26 10:05:00.000', 'USER_EXPOSED', '{"feature_name": "recommendations_v2"}'),
(301, '2023-11-26 10:05:30.000', 'APP_ERROR', '{"error_code": 404, "source": "product_service"}'), -- Unrelated error
(302, '2023-11-26 10:06:00.000', 'USER_EXPOSED', '{"feature_name": "recommendations_v2"}');
