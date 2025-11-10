CREATE DATABASE IF NOT EXISTS daily_practice_20251110_schema;
USE daily_practice_20251110_schema;

-- This table logs key user engagement events on a social media platform.
CREATE TABLE user_engagement_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('ACCOUNT_CREATED', 'POST_CREATED', 'LIKE_GIVEN', 'COMMENT_POSTED'),
    -- post_id is the ID of the post being created or commented on.
    -- liked_post_id is the ID of the post being liked.
    -- liked_user_id is the ID of the user who *owns* the post that was liked.
    details JSON
);

INSERT INTO user_engagement_events (user_id, event_timestamp, event_type, details) VALUES
-- User 101: Creates account, posts, gets a few likes
(101, '2023-11-01 10:00:00.000', 'ACCOUNT_CREATED', NULL),
(101, '2023-11-01 11:00:00.000', 'POST_CREATED', '{"post_id": 1001}'),
(201, '2023-11-02 12:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1001, "liked_user_id": 101}'),
(202, '2023-11-03 13:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1001, "liked_user_id": 101}'),
(203, '2023-11-04 14:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1001, "liked_user_id": 101}'),
(101, '2023-11-10 10:00:00.000', 'POST_CREATED', '{"post_id": 1002}'), -- 2nd post
(204, '2023-11-11 11:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1002, "liked_user_id": 101}'),

-- User 102: Power User
(102, '2023-11-02 09:00:00.000', 'ACCOUNT_CREATED', NULL),
(102, '2023-11-03 10:00:00.000', 'POST_CREATED', '{"post_id": 1003}'), -- First post
(201, '2023-11-03 11:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(202, '2023-11-04 12:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(203, '2023-11-05 13:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(204, '2023-11-06 14:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(205, '2023-11-07 15:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(206, '2023-11-08 16:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(207, '2023-11-09 17:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(208, '2023-11-09 18:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(209, '2023-11-09 19:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'),
(210, '2023-11-09 20:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}'), -- 10th like, within 7 days of first post

-- User 103: Misses the 7-day window
(103, '2023-11-05 10:00:00.000', 'ACCOUNT_CREATED', NULL),
(103, '2023-11-05 11:00:00.000', 'POST_CREATED', '{"post_id": 1004}'), -- First post
(201, '2023-11-06 11:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'),
(202, '2023-11-07 12:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'),
(203, '2023-11-08 13:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'),
(204, '2023-11-09 14:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'),
(205, '2023-11-10 15:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'), -- 5 likes within 7 days
(206, '2023-11-15 16:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'), -- 6th like, but outside 7-day window
(207, '2023-11-16 17:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'),
(208, '2023-11-17 18:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'),
(209, '2023-11-18 19:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'),
(210, '2023-11-19 20:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1004, "liked_user_id": 103}'), -- 10th like, but too late

-- User 104: Never posts, just comments
(104, '2023-11-06 10:00:00.000', 'ACCOUNT_CREATED', NULL),
(104, '2023-11-07 11:00:00.000', 'COMMENT_POSTED', '{"post_id": 1001}'),
(104, '2023-11-08 12:00:00.000', 'LIKE_GIVEN', '{"liked_post_id": 1003, "liked_user_id": 102}');