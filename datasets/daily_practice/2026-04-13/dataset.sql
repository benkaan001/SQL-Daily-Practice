CREATE DATABASE IF NOT EXISTS daily_practice_20260413_schema;
USE daily_practice_20260413_schema;

-- This table logs positive "likes" users have given to movies on a streaming platform.
CREATE TABLE user_movie_likes (
    user_id INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id)
);

INSERT INTO user_movie_likes (user_id, movie_id) VALUES
-- User 101 (Our Target User): Likes Sci-Fi and Action (Movies 1, 2, 3, 4, 5)
(101, 1), (101, 2), (101, 3), (101, 4), (101, 5),

-- User 102 (The Clone): Likes exactly the same movies as 101
(102, 1), (102, 2), (102, 3), (102, 4), (102, 5),

-- User 103 (The Best Friend): Likes 4 of the same, plus 1 different movie
(103, 1), (103, 2), (103, 3), (103, 4), (103, 6),

-- User 104 (The Casual): Likes only 2 movies, but both are shared with 101
(104, 1), (104, 2),

-- User 105 (The Complete Opposite): Likes completely different movies (No overlap with 101)
(105, 7), (105, 8), (105, 9),

-- User 106 (The Movie Buff): Likes everything including 101's list, but has a massive library of likes
(106, 1), (106, 2), (106, 3), (106, 4), (106, 5), 
(106, 6), (106, 7), (106, 8), (106, 9), (106, 10);