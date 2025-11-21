CREATE DATABASE IF NOT EXISTS daily_practice_20251118_schema;
USE daily_practice_20251118_schema;

-- This table logs user interactions with UI elements on a web application.
CREATE TABLE ui_interaction_logs (
    interaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(50),
    interaction_timestamp DATETIME(3),
    interaction_type ENUM('CLICK', 'HOVER', 'SCROLL', 'INPUT'),
    element_id VARCHAR(50) -- The specific button, link, or input field ID
);

INSERT INTO ui_interaction_logs (user_id, session_id, interaction_timestamp, interaction_type, element_id) VALUES
-- User 101: Frustrated "Double Click" on a Submit button
(101, 'sess_A', '2023-11-28 10:00:00.000', 'HOVER', 'submit_btn'),
(101, 'sess_A', '2023-11-28 10:00:01.000', 'CLICK', 'submit_btn'),
(101, 'sess_A', '2023-11-28 10:00:01.250', 'CLICK', 'submit_btn'), -- 250ms difference (Double Click)

-- User 102: Normal navigation (clicks are far apart)
(102, 'sess_B', '2023-11-28 11:00:00.000', 'CLICK', 'nav_home'),
(102, 'sess_B', '2023-11-28 11:00:02.000', 'CLICK', 'nav_profile'), -- Different element
(102, 'sess_B', '2023-11-28 11:00:05.000', 'CLICK', 'nav_profile'), -- Same element, but 3s later (Normal)

-- User 103: "Rage Clicking" (Rapid succession)
(103, 'sess_C', '2023-11-28 12:00:00.000', 'CLICK', 'refresh_icon'),
(103, 'sess_C', '2023-11-28 12:00:00.100', 'CLICK', 'refresh_icon'), -- 100ms later (Double Click)
(103, 'sess_C', '2023-11-28 12:00:00.300', 'CLICK', 'refresh_icon'), -- 200ms after previous (Double Click)

-- User 104: Fast typing/clicking on different elements (Not a double click)
(104, 'sess_D', '2023-11-28 13:00:00.000', 'CLICK', 'option_A'),
(104, 'sess_D', '2023-11-28 13:00:00.200', 'CLICK', 'option_B'), -- Different element, fast switch

-- User 105: Accidental double click on a link
(105, 'sess_E', '2023-11-28 14:00:00.000', 'CLICK', 'read_more_link'),
(105, 'sess_E', '2023-11-28 14:00:00.450', 'CLICK', 'read_more_link'); -- 450ms later (Double Click)