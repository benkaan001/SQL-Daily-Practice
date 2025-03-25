-- Create the database schema for a simple video watching platform
CREATE DATABASE IF NOT EXISTS daily_practice_20250325_schema;;
USE daily_practice_20250325_schema;;

-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    signup_date DATE
);

-- Videos table
CREATE TABLE videos (
    video_id INT PRIMARY KEY,
    title VARCHAR(100),
    category VARCHAR(50)
);

-- Watch history table capturing when a user watched a video
CREATE TABLE watch_history (
    watch_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    video_id INT,
    watch_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

-- Insert sample users
INSERT INTO users (user_id, username, signup_date) VALUES
(1, 'alice', '2025-03-01'),
(2, 'bob', '2025-03-02'),
(3, 'charlie', '2025-03-03'),
(4, 'diana', '2025-03-04'),
(5, 'edward', '2025-03-05'),
(6, 'fiona', '2025-03-06'),
(7, 'george', '2025-03-07'),
(8, 'hannah', '2025-03-08'),
(9, 'ian', '2025-03-09'),
(10, 'julia', '2025-03-10');

-- Insert sample videos
INSERT INTO videos (video_id, title, category) VALUES
(101, 'Introduction to SQL', 'Education'),
(102, 'Advanced SQL Techniques', 'Education'),
(103, 'Docker for Beginners', 'Technology'),
(104, 'Cooking 101', 'Lifestyle'),
(105, 'Travel Vlog: Japan', 'Travel');

-- Insert sample watch history data
-- Assume users watch videos in different orders; watch_date is used to determine the order per user.
INSERT INTO watch_history (user_id, video_id, watch_date) VALUES
(1, 101, '2025-03-11'),
(1, 102, '2025-03-12'),
(1, 104, '2025-03-13'),

(2, 101, '2025-03-11'),
(2, 103, '2025-03-12'),

(3, 105, '2025-03-10'),
(3, 101, '2025-03-11'),
(3, 102, '2025-03-12'),
(3, 103, '2025-03-13'),

(4, 104, '2025-03-11'),

(5, 101, '2025-03-12'),
(5, 105, '2025-03-13'),

(6, 102, '2025-03-10'),
(6, 103, '2025-03-11'),
(6, 104, '2025-03-12'),

(7, 103, '2025-03-10'),
(7, 101, '2025-03-11'),

(8, 105, '2025-03-11'),
(8, 104, '2025-03-12'),

(9, 101, '2025-03-10'),
(9, 102, '2025-03-11'),
(9, 103, '2025-03-12'),
(9, 104, '2025-03-13'),

(10, 105, '2025-03-10'),
(10, 101, '2025-03-11'),
(10, 104, '2025-03-12');