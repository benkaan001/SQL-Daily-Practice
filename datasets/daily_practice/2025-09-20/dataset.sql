CREATE DATABASE IF NOT EXISTS daily_practice_20250920_schema;
USE daily_practice_20250920_schema;

-- This table logs posts from a Q&A forum.
-- Posts can be 'QUESTION's or 'ANSWER's.
-- Answers are linked to questions via parent_post_id.
-- Questions can have one accepted_answer_id.
CREATE TABLE forum_posts (
    post_id INT PRIMARY KEY,
    parent_post_id INT, -- Foreign key to the same table (the parent question)
    user_id INT,
    post_type ENUM('QUESTION', 'ANSWER'),
    creation_date DATETIME,
    score INT, -- Represents net upvotes (positive) or downvotes (negative)
    accepted_answer_id INT -- Only populated for 'QUESTION' posts
);

INSERT INTO forum_posts (post_id, parent_post_id, user_id, post_type, creation_date, score, accepted_answer_id) VALUES
-- Scenario 1: User 101 asks, User 102 provides the accepted answer which is also upvoted.
(1, NULL, 101, 'QUESTION', '2023-11-01 10:00:00', 5, 2),
(2, 1,    102, 'ANSWER',   '2023-11-01 11:00:00', 10, NULL),
(3, 1,    103, 'ANSWER',   '2023-11-01 11:30:00', 2, NULL),

-- Scenario 2: User 103 asks, User 101 answers (upvoted) but another answer is accepted.
(4, NULL, 103, 'QUESTION', '2023-11-02 09:00:00', 3, 6),
(5, 4,    101, 'ANSWER',   '2023-11-02 09:15:00', 8, NULL),
(6, 4,    104, 'ANSWER',   '2023-11-02 09:30:00', 3, NULL),

-- Scenario 3: User 102 asks a question that gets no accepted answer. User 101's answer is downvoted.
(7, NULL, 102, 'QUESTION', '2023-11-03 14:00:00', 1, NULL),
(8, 7,    101, 'ANSWER',   '2023-11-03 14:30:00', -3, NULL),

-- Scenario 4: User 104 asks, User 101 provides the accepted answer.
(9, NULL, 104, 'QUESTION', '2023-11-04 16:00:00', 12, 10),
(10, 9,   101, 'ANSWER',   '2023-11-04 16:05:00', 20, NULL);
