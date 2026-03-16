CREATE DATABASE IF NOT EXISTS daily_practice_20260316_schema;
USE daily_practice_20260316_schema;

-- This table stores the social graph. 
-- Friendships are mutual, and the system optimizes reads by storing 
-- both directions explicitly (if A is friends with B, there is a row for A->B and B->A).
CREATE TABLE friendships (
    user_id INT,
    friend_id INT,
    PRIMARY KEY (user_id, friend_id)
);

INSERT INTO friendships (user_id, friend_id) VALUES
-- User 101's direct network
(101, 102), (102, 101),
(101, 103), (103, 101),
(101, 104), (104, 101),

-- User 102's other friends
(102, 105), (105, 102),

-- User 103's other friends
(103, 105), (105, 103),
(103, 106), (106, 103),

-- User 104's other friends
(104, 106), (106, 104),
(104, 107), (107, 104),

-- User 105's other friends (3rd degree connection for 101)
(105, 108), (108, 105);