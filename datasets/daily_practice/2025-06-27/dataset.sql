-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250627_schema;
USE daily_practice_20250627_schema;


-- Create Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    registration_date DATE NOT NULL,
    followers_count INT NOT NULL DEFAULT 0,
    is_verified BOOLEAN NOT NULL DEFAULT FALSE
);

-- Insert Data into Users Table
INSERT INTO Users (user_id, username, registration_date, followers_count, is_verified) VALUES
(101, 'AlexG', '2023-01-10', 5000, TRUE),
(102, 'BellaR', '2023-02-15', 1200, FALSE),
(103, 'ChrisM', '2023-03-01', 8000, TRUE),
(104, 'DanaW', '2023-04-05', 300, FALSE),
(105, 'EthanK', '2023-05-10', 10000, TRUE),
(106, 'FionaL', '2023-06-01', 50, FALSE); -- New, less active user

-- Create Posts Table
CREATE TABLE Posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    post_text TEXT,
    post_date DATETIME NOT NULL,
    views_count INT NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert Data into Posts Table
-- AlexG (101) posts
INSERT INTO Posts (user_id, post_text, post_date, views_count) VALUES
(101, 'Loving the new data science trends!', '2025-05-01 10:00:00', 1500),
(101, 'My thoughts on effective programming.', '2025-05-05 14:30:00', 2000),
(101, 'Quick update from my workshop.', '2025-06-10 09:00:00', 3000),
(101, 'Excited for the summer!', '2025-06-20 18:00:00', 1000);

-- BellaR (102) posts
INSERT INTO Posts (user_id, post_text, post_date, views_count) VALUES
(102, 'New photography series coming soon!', '2025-05-02 11:00:00', 800),
(102, 'Behind the scenes of my last shoot.', '2025-05-10 16:00:00', 1200),
(102, 'Testing new editing software.', '2025-06-15 10:30:00', 900);

-- ChrisM (103) posts
INSERT INTO Posts (user_id, post_text, post_date, views_count) VALUES
(103, 'A deep dive into AI ethics.', '2025-05-03 09:00:00', 5000),
(103, 'Future of tech is here.', '2025-05-20 13:00:00', 6000),
(103, 'Just published a new paper.', '2025-06-01 10:00:00', 7000);

-- DanaW (104) posts
INSERT INTO Posts (user_id, post_text, post_date, views_count) VALUES
(104, 'Gardening tips for beginners.', '2025-05-04 12:00:00', 200),
(104, 'Harvesting tomatoes!', '2025-06-05 15:00:00', 300);

-- EthanK (105) posts (very popular)
INSERT INTO Posts (user_id, post_text, post_date, views_count) VALUES
(105, 'My daily fitness routine.', '2025-05-06 08:00:00', 8000),
(105, 'Healthy eating guide.', '2025-05-25 11:00:00', 9000);

-- FionaL (106) posts (new, low views, some NULL text)
INSERT INTO Posts (user_id, post_text, post_date, views_count) VALUES
(106, NULL, '2025-06-01 10:05:00', 10), -- No text post
(106, 'First post! Hello world!', '2025-06-03 12:00:00', 50);


-- Create Interactions Table (likes, comments - one table for simplicity)
CREATE TABLE Interactions (
    interaction_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL, -- User who performed the interaction
    interaction_type ENUM('Like', 'Comment') NOT NULL,
    interaction_date DATETIME NOT NULL,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert Data into Interactions Table
-- Interactions for Post 1 (AlexG)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(1, 102, 'Like', '2025-05-01 10:05:00'),
(1, 103, 'Like', '2025-05-01 10:10:00'),
(1, 104, 'Comment', '2025-05-01 10:15:00'),
(1, 105, 'Like', '2025-05-01 10:20:00');

-- Interactions for Post 2 (AlexG)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(2, 101, 'Like', '2025-05-05 15:00:00'), -- Self-like
(2, 102, 'Comment', '2025-05-05 15:05:00');

-- Interactions for Post 3 (AlexG)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(3, 103, 'Like', '2025-06-10 09:10:00');

-- Interactions for Post 4 (AlexG) - no interactions yet

-- Interactions for Post 5 (BellaR)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(5, 101, 'Like', '2025-05-02 11:30:00'),
(5, 104, 'Like', '2025-05-02 11:45:00');

-- Interactions for Post 6 (BellaR) - no interactions yet
-- Interactions for Post 7 (BellaR) - no interactions yet

-- Interactions for Post 8 (ChrisM)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(8, 101, 'Like', '2025-05-03 09:10:00'),
(8, 102, 'Like', '2025-05-03 09:15:00'),
(8, 105, 'Comment', '2025-05-03 09:20:00');

-- Interactions for Post 9 (ChrisM)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(9, 101, 'Like', '2025-05-20 13:10:00'),
(9, 102, 'Comment', '2025-05-20 13:15:00'),
(9, 103, 'Like', '2025-05-20 13:20:00'), -- Self-like
(9, 104, 'Like', '2025-05-20 13:25:00');

-- Interactions for Post 10 (ChrisM)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(10, 105, 'Like', '2025-06-01 10:10:00');

-- Interactions for Post 11 (DanaW) - no interactions yet
-- Interactions for Post 12 (DanaW)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(12, 101, 'Like', '2025-06-05 15:10:00');

-- Interactions for Post 13 (EthanK)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(13, 101, 'Like', '2025-05-06 08:10:00'),
(13, 102, 'Like', '2025-05-06 08:15:00'),
(13, 103, 'Like', '2025-05-06 08:20:00'),
(13, 104, 'Like', '2025-05-06 08:25:00'),
(13, 106, 'Like', '2025-05-06 08:30:00');

-- Interactions for Post 14 (EthanK)
INSERT INTO Interactions (post_id, user_id, interaction_type, interaction_date) VALUES
(14, 101, 'Like', '2025-05-25 11:10:00');

-- Interactions for Post 15 (FionaL) - no interactions yet
-- Interactions for Post 16 (FionaL) - no interactions yet
