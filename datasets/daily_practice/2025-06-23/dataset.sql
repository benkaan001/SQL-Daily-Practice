-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250623_schema;
USE daily_practice_20250623_schema;


-- Create Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    registration_date DATE NOT NULL,
    last_login_date DATE, -- Can be NULL if never logged in or very old inactive user
    country VARCHAR(50), -- Can be NULL
    account_status ENUM('Active', 'Inactive', 'Suspended') NOT NULL DEFAULT 'Active'
);

-- Insert Data into Users Table
INSERT INTO Users (user_id, username, registration_date, last_login_date, country, account_status) VALUES
(1, 'userA', '2023-01-10', '2025-06-21', 'USA', 'Active'),
(2, 'userB', '2023-02-15', '2025-06-18', 'Canada', 'Active'),
(3, 'userC', '2023-03-01', '2025-05-20', 'UK', 'Inactive'),
(4, 'userD', '2023-04-05', '2025-06-22', 'USA', 'Active'),
(5, 'userE', '2023-05-10', NULL, 'Germany', 'Active'), -- Never logged in
(6, 'userF', '2023-06-01', '2025-06-19', 'France', 'Suspended'),
(7, 'userG', '2024-01-01', '2025-06-21', 'USA', 'Active'),
(8, 'userH', '2024-02-10', '2025-06-17', NULL, 'Active'); -- NULL country

-- Create ActivityLogs Table
CREATE TABLE ActivityLogs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    activity_timestamp DATETIME NOT NULL,
    activity_type VARCHAR(50) NOT NULL, -- e.g., 'login', 'logout', 'view_profile', 'post', 'comment', 'purchase'
    details VARCHAR(255), -- Can be NULL
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert Data into ActivityLogs Table
-- userA (ID 1) - Active, diverse activities
INSERT INTO ActivityLogs (user_id, activity_timestamp, activity_type, details) VALUES
(1, '2025-06-10 09:00:00', 'login', NULL),
(1, '2025-06-10 09:15:00', 'view_profile', 'profile_id: 10'),
(1, '2025-11-10 10:00:00', 'login', NULL), -- Activity from late 2025 for future problem flexibility
(1, '2025-06-10 09:30:00', 'post', 'New article published'),
(1, '2025-06-10 17:00:00', 'logout', NULL),
(1, '2025-06-11 08:30:00', 'login', NULL),
(1, '2025-06-11 12:00:00', 'comment', 'Commented on post 123'),
(1, '2025-06-11 16:45:00', 'logout', NULL),
(1, '2025-06-15 09:00:00', 'login', NULL),
(1, '2025-06-15 10:00:00', 'purchase', 'Item ID: 500'),
(1, '2025-06-15 17:00:00', 'logout', NULL),
(1, '2025-06-21 08:00:00', 'login', NULL),
(1, '2025-06-21 08:05:00', 'view_profile', 'profile_id: 1'),
(1, '2025-06-21 08:30:00', 'logout', NULL);


-- userB (ID 2) - Active, login/logout only
INSERT INTO ActivityLogs (user_id, activity_timestamp, activity_type, details) VALUES
(2, '2025-06-16 07:00:00', 'login', NULL),
(2, '2025-06-16 18:00:00', 'logout', NULL),
(2, '2025-06-17 07:30:00', 'login', NULL),
(2, '2025-06-17 17:00:00', 'logout', NULL),
(2, '2025-06-18 08:00:00', 'login', NULL),
(2, '2025-06-18 17:00:00', 'logout', NULL);

-- userC (ID 3) - Inactive, older activities
INSERT INTO ActivityLogs (user_id, activity_timestamp, activity_type, details) VALUES
(3, '2025-05-19 10:00:00', 'login', NULL),
(3, '2025-05-19 11:00:00', 'view_profile', 'profile_id: 20'),
(3, '2025-05-20 09:00:00', 'login', NULL),
(3, '2025-05-20 17:00:00', 'logout', NULL);

-- userD (ID 4) - Active, recent multiple logins in a day
INSERT INTO ActivityLogs (user_id, activity_timestamp, activity_type, details) VALUES
(4, '2025-06-22 08:00:00', 'login', NULL),
(4, '2025-06-22 09:00:00', 'logout', NULL),
(4, '2025-06-22 10:00:00', 'login', NULL),
(4, '2025-06-22 11:00:00', 'purchase', 'Item ID: 600'),
(4, '2025-06-22 12:00:00', 'logout', NULL);

-- userE (ID 5) - No activity logs (as last_login_date is NULL)

-- userF (ID 6) - Suspended, one recent login attempt
INSERT INTO ActivityLogs (user_id, activity_timestamp, activity_type, details) VALUES
(6, '2025-06-19 10:00:00', 'login', NULL),
(6, '2025-06-19 10:01:00', 'failed_attempt', 'Invalid password');

-- userG (ID 7) - New user, active
INSERT INTO ActivityLogs (user_id, activity_timestamp, activity_type, details) VALUES
(7, '2025-06-20 10:00:00', 'login', NULL),
(7, '2025-06-20 11:00:00', 'view_profile', 'profile_id: 7'),
(7, '2025-06-21 09:00:00', 'login', NULL); -- Missing logout

-- userH (ID 8) - NULL country, regular activity
INSERT INTO ActivityLogs (user_id, activity_timestamp, activity_type, details) VALUES
(8, '2025-06-17 08:00:00', 'login', NULL),
(8, '2025-06-17 17:00:00', 'logout', NULL);
