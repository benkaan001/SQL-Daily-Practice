CREATE DATABASE IF NOT EXISTS daily_practice_20250814_schema;
USE daily_practice_20250814_schema;

-- This table logs user interactions during various A/B tests on a website.
CREATE TABLE ab_test_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    user_id INT,
    event_timestamp DATETIME,
    experiment_id VARCHAR(50),
    variation_name ENUM('control', 'treatment'),
    event_name ENUM('view_homepage', 'click_cta', 'add_to_cart', 'purchase'),
    purchase_value DECIMAL(10, 2) -- NULL for non-purchase events
);

INSERT INTO ab_test_events (session_id, user_id, event_timestamp, experiment_id, variation_name, event_name, purchase_value) VALUES
-- Experiment: 'exp_button_color'
('sess_01', 101, '2023-11-10 09:00:00', 'exp_button_color', 'control', 'view_homepage', NULL),
('sess_01', 101, '2023-11-10 09:01:00', 'exp_button_color', 'control', 'click_cta', NULL),
('sess_01', 101, '2023-11-10 09:02:00', 'exp_button_color', 'control', 'purchase', 50.00),
('sess_02', 102, '2023-11-10 09:05:00', 'exp_button_color', 'treatment', 'view_homepage', NULL),
('sess_02', 102, '2023-11-10 09:06:00', 'exp_button_color', 'treatment', 'click_cta', NULL),
('sess_03', 103, '2023-11-10 09:10:00', 'exp_button_color', 'control', 'view_homepage', NULL),
('sess_04', 104, '2023-11-10 09:15:00', 'exp_button_color', 'treatment', 'view_homepage', NULL),
('sess_04', 104, '2023-11-10 09:16:00', 'exp_button_color', 'treatment', 'click_cta', NULL),
('sess_04', 104, '2023-11-10 09:18:00', 'exp_button_color', 'treatment', 'purchase', 45.00),
('sess_05', 105, '2023-11-10 09:20:00', 'exp_button_color', 'control', 'view_homepage', NULL),
('sess_05', 105, '2023-11-10 09:21:00', 'exp_button_color', 'control', 'click_cta', NULL),
('sess_06', 106, '2023-11-10 09:25:00', 'exp_button_color', 'treatment', 'view_homepage', NULL),
('sess_06', 106, '2023-11-10 09:26:00', 'exp_button_color', 'treatment', 'click_cta', NULL),

-- Experiment: 'exp_checkout_flow'
('sess_07', 201, '2023-11-11 11:00:00', 'exp_checkout_flow', 'control', 'view_homepage', NULL),
('sess_07', 201, '2023-11-11 11:01:00', 'exp_checkout_flow', 'control', 'add_to_cart', NULL),
('sess_07', 201, '2023-11-11 11:05:00', 'exp_checkout_flow', 'control', 'purchase', 100.00),
('sess_08', 202, '2023-11-11 11:10:00', 'exp_checkout_flow', 'treatment', 'view_homepage', NULL),
('sess_08', 202, '2023-11-11 11:11:00', 'exp_checkout_flow', 'treatment', 'add_to_cart', NULL),
('sess_08', 202, '2023-11-11 11:14:00', 'exp_checkout_flow', 'treatment', 'purchase', 150.00),
('sess_09', 203, '2023-11-11 11:15:00', 'exp_checkout_flow', 'control', 'view_homepage', NULL),
('sess_09', 203, '2023-11-11 11:16:00', 'exp_checkout_flow', 'control', 'add_to_cart', NULL), -- Abandons
('sess_10', 204, '2023-11-11 11:20:00', 'exp_checkout_flow', 'treatment', 'view_homepage', NULL),
('sess_10', 204, '2023-11-11 11:21:00', 'exp_checkout_flow', 'treatment', 'add_to_cart', NULL),
('sess_10', 204, '2023-11-11 11:23:00', 'exp_checkout_flow', 'treatment', 'purchase', 180.00),
('sess_11', 205, '2023-11-11 11:25:00', 'exp_checkout_flow', 'control', 'view_homepage', NULL),
('sess_11', 205, '2023-11-11 11:26:00', 'exp_checkout_flow', 'control', 'add_to_cart', NULL),
('sess_11', 205, '2023-11-11 11:30:00', 'exp_checkout_flow', 'control', 'purchase', 90.00),

-- User 999: Contaminated user, exposed to both variations of the same experiment
('sess_12', 999, '2023-11-12 10:00:00', 'exp_checkout_flow', 'control', 'view_homepage', NULL),
('sess_12', 999, '2023-11-12 10:01:00', 'exp_checkout_flow', 'control', 'add_to_cart', NULL),
('sess_13', 999, '2023-11-12 14:00:00', 'exp_checkout_flow', 'treatment', 'view_homepage', NULL),
('sess_13', 999, '2023-11-12 14:01:00', 'exp_checkout_flow', 'treatment', 'add_to_cart', NULL),
('sess_13', 999, '2023-11-12 14:05:00', 'exp_checkout_flow', 'treatment', 'purchase', 200.00);
