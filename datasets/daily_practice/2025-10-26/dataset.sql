CREATE DATABASE IF NOT EXISTS daily_practice_20251026_schema;
USE daily_practice_20251026_schema;

-- This table logs user interactions on a website, including page views and form submissions.
CREATE TABLE website_analytics (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('PAGE_VIEW', 'FORM_SUBMIT', 'CLICK'),
    page_url VARCHAR(255),
    form_id VARCHAR(50), -- NULL if not a FORM_SUBMIT event
    element_id VARCHAR(50) -- NULL if not a CLICK event
);

INSERT INTO website_analytics (user_id, session_id, event_timestamp, event_type, page_url, form_id, element_id) VALUES
-- User 101: Views pricing, submits contact form
(101, 'sess_A', '2023-11-01 10:00:00.000', 'PAGE_VIEW', '/pricing', NULL, NULL),
(101, 'sess_A', '2023-11-01 10:01:30.000', 'CLICK', '/pricing', NULL, 'contact_button'),
(101, 'sess_A', '2023-11-01 10:02:00.000', 'PAGE_VIEW', '/contact', NULL, NULL),
(101, 'sess_A', '2023-11-01 10:03:00.000', 'FORM_SUBMIT', '/contact', 'contact_form', NULL),

-- User 102: Views blog, then pricing, no submission
(102, 'sess_B', '2023-11-01 11:00:00.000', 'PAGE_VIEW', '/blog/article1', NULL, NULL),
(102, 'sess_B', '2023-11-01 11:05:00.000', 'PAGE_VIEW', '/pricing', NULL, NULL),
(102, 'sess_B', '2023-11-01 11:06:00.000', 'CLICK', '/pricing', NULL, 'feature_details'),

-- User 103: Views homepage, submits signup form
(103, 'sess_C', '2023-11-02 09:00:00.000', 'PAGE_VIEW', '/', NULL, NULL),
(103, 'sess_C', '2023-11-02 09:00:45.000', 'CLICK', '/', NULL, 'signup_button'),
(103, 'sess_C', '2023-11-02 09:01:00.000', 'PAGE_VIEW', '/signup', NULL, NULL),
(103, 'sess_C', '2023-11-02 09:02:15.000', 'FORM_SUBMIT', '/signup', 'signup_form', NULL),

-- User 101: Another session, views pricing, doesn't submit
(101, 'sess_D', '2023-11-03 14:00:00.000', 'PAGE_VIEW', '/pricing', NULL, NULL),
(101, 'sess_D', '2023-11-03 14:01:00.000', 'PAGE_VIEW', '/features', NULL, NULL),

-- User 104: Views contact page directly, submits form
(104, 'sess_E', '2023-11-03 15:00:00.000', 'PAGE_VIEW', '/contact', NULL, NULL),
(104, 'sess_E', '2023-11-03 15:01:00.000', 'FORM_SUBMIT', '/contact', 'contact_form', NULL),

-- User 102: Views pricing again, submits contact form this time
(102, 'sess_F', '2023-11-04 10:00:00.000', 'PAGE_VIEW', '/pricing', NULL, NULL),
(102, 'sess_F', '2023-11-04 10:01:00.000', 'FORM_SUBMIT', '/contact', 'contact_form', NULL), -- Note: Submits on /contact but the preceding PAGE_VIEW was /pricing

-- User 103: Submits signup form again (maybe error/retry?)
(103, 'sess_G', '2023-11-05 11:00:00.000', 'PAGE_VIEW', '/signup', NULL, NULL),
(103, 'sess_G', '2023-11-05 11:00:30.000', 'FORM_SUBMIT', '/signup', 'signup_form', NULL);
