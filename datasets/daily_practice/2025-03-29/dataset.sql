-- Create the database and table for a YouTube user flags dataset
CREATE DATABASE IF NOT EXISTS daily_practice_20250329_schema;
USE daily_practice_20250329_schema;

CREATE TABLE user_flags (
    user_firstname TEXT,
    user_lastname TEXT,
    video_id TEXT,
    flag_id TEXT
);

-- Insert sample data with some missing values (represented here as NULL)
INSERT INTO user_flags (user_firstname, user_lastname, video_id, flag_id) VALUES
('Courtney', NULL, 'dQw4w9WgXcQ', NULL),
('Gina', 'Korman', NULL, NULL),
('Greg', NULL, '5qap5aO4i9A', NULL),
('Alice', 'Smith', 'abc123', 'flag1'),
('Bob', NULL, NULL, 'flag2'),
('David', 'Jones', 'xyz789', NULL);