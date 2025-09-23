CREATE DATABASE IF NOT EXISTS daily_practice_20250923_schema;
USE daily_practice_20250923_schema;

-- This table logs user interactions with different A/B test variations.
CREATE TABLE experiment_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    experiment_id VARCHAR(50),
    variation_name VARCHAR(20), -- 'control' or 'treatment'
    event_name VARCHAR(50), -- e.g., 'view_page', 'click_button', 'purchase'
    event_timestamp DATETIME(3),
    value DECIMAL(10, 2) -- e.g., purchase amount
);

INSERT INTO experiment_events (user_id, experiment_id, variation_name, event_name, event_timestamp, value) VALUES
-- Experiment: button_color_exp
-- Control Group
(101, 'button_color_exp', 'control', 'view_page', '2023-11-01 10:00:00.000', NULL),
(102, 'button_color_exp', 'control', 'view_page', '2023-11-01 10:05:00.000', NULL),
(102, 'button_color_exp', 'control', 'click_button', '2023-11-01 10:05:30.000', NULL),
(103, 'button_color_exp', 'control', 'view_page', '2023-11-01 10:10:00.000', NULL),
(103, 'button_color_exp', 'control', 'click_button', '2023-11-01 10:11:00.000', NULL),
(103, 'button_color_exp', 'control', 'purchase', '2023-11-01 10:12:00.000', 50.00),
(104, 'button_color_exp', 'control', 'view_page', '2023-11-02 11:00:00.000', NULL),
(105, 'button_color_exp', 'control', 'view_page', '2023-11-02 11:05:00.000', NULL),
(105, 'button_color_exp', 'control', 'click_button', '2023-11-02 11:06:00.000', NULL),
(105, 'button_color_exp', 'control', 'purchase', '2023-11-02 11:08:00.000', 60.00),

-- Treatment Group
(201, 'button_color_exp', 'treatment', 'view_page', '2023-11-01 10:01:00.000', NULL),
(202, 'button_color_exp', 'treatment', 'view_page', '2023-11-01 10:06:00.000', NULL),
(202, 'button_color_exp', 'treatment', 'click_button', '2023-11-01 10:06:20.000', NULL),
(203, 'button_color_exp', 'treatment', 'view_page', '2023-11-01 10:11:00.000', NULL),
(203, 'button_color_exp', 'treatment', 'click_button', '2023-11-01 10:11:45.000', NULL),
(203, 'button_color_exp', 'treatment', 'purchase', '2023-11-01 10:13:00.000', 75.00),
(204, 'button_color_exp', 'treatment', 'view_page', '2023-11-02 11:01:00.000', NULL),
(204, 'button_color_exp', 'treatment', 'click_button', '2023-11-02 11:01:30.000', NULL),
(204, 'button_color_exp', 'treatment', 'purchase', '2023-11-02 11:02:00.000', 80.00),
(205, 'button_color_exp', 'treatment', 'view_page', '2023-11-02 11:07:00.000', NULL),
(205, 'button_color_exp', 'treatment', 'click_button', '2023-11-02 11:07:30.000', NULL),
(205, 'button_color_exp', 'treatment', 'purchase', '2023-11-02 11:09:00.000', 85.00),

-- Another experiment for noise
(301, 'checkout_flow_exp', 'control', 'view_page', '2023-11-05 14:00:00.000', NULL),
(302, 'checkout_flow_exp', 'treatment', 'purchase', '2023-11-05 15:00:00.000', 100.00);
