CREATE DATABASE IF NOT EXISTS daily_practice_20250805_schema;
USE daily_practice_20250805_schema;

-- This table logs student interactions with online courses.
CREATE TABLE course_activity (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    course_id INT,
    activity_type ENUM('enroll', 'start_lesson', 'finish_lesson', 'take_quiz'),
    activity_timestamp DATETIME,
    lesson_or_quiz_id INT, -- Refers to either a lesson or a quiz
    quiz_score DECIMAL(5, 2) -- NULL for non-quiz activities
);

INSERT INTO course_activity (user_id, course_id, activity_type, activity_timestamp, lesson_or_quiz_id, quiz_score) VALUES
-- User 101: Completes Course 1001 quickly
(101, 1001, 'enroll', '2023-10-01 09:00:00', NULL, NULL),
(101, 1001, 'start_lesson', '2023-10-01 09:05:00', 1, NULL),
(101, 1001, 'finish_lesson', '2023-10-01 09:30:00', 1, NULL),
(101, 1001, 'start_lesson', '2023-10-01 09:32:00', 2, NULL),
(101, 1001, 'finish_lesson', '2023-10-01 10:00:00', 2, NULL),
(101, 1001, 'take_quiz', '2023-10-01 10:15:00', 1, 95.00), -- Final quiz for course 1001

-- User 102: Starts Course 1001, but drops off
(102, 1001, 'enroll', '2023-10-02 11:00:00', NULL, NULL),
(102, 1001, 'start_lesson', '2023-10-02 11:10:00', 1, NULL),
(102, 1001, 'finish_lesson', '2023-10-02 11:45:00', 1, NULL),
-- No activity for a long time after this

-- User 103: Completes Course 1002, fails a quiz once
(103, 1002, 'enroll', '2023-10-03 14:00:00', NULL, NULL),
(103, 1002, 'start_lesson', '2023-10-04 15:00:00', 1, NULL),
(103, 1002, 'finish_lesson', '2023-10-05 16:00:00', 1, NULL),
(103, 1002, 'take_quiz', '2023-10-05 16:10:00', 1, 65.00), -- Fails first attempt
(103, 1002, 'take_quiz', '2023-10-06 10:00:00', 1, 85.00), -- Passes second attempt
(103, 1002, 'start_lesson', '2023-10-07 11:00:00', 2, NULL),
(103, 1002, 'finish_lesson', '2023-10-08 12:00:00', 2, NULL),
(103, 1002, 'take_quiz', '2023-10-08 12:15:00', 2, 90.00), -- Final quiz for course 1002

-- User 101: Also takes Course 1002
(101, 1002, 'enroll', '2023-10-10 13:00:00', NULL, NULL),
(101, 1002, 'start_lesson', '2023-10-10 13:05:00', 1, NULL),
(101, 1002, 'finish_lesson', '2023-10-11 14:00:00', 1, NULL),
(101, 1002, 'take_quiz', '2023-10-11 14:10:00', 1, 92.00),
(101, 1002, 'start_lesson', '2023-10-12 15:00:00', 2, NULL),
(101, 1002, 'finish_lesson', '2023-10-13 16:00:00', 2, NULL),
(101, 1002, 'take_quiz', '2023-10-13 16:15:00', 2, 98.00),

-- User 104: Enrolls but never starts
(104, 1001, 'enroll', '2023-10-15 09:00:00', NULL, NULL),

-- User 105: Starts Course 1003, is currently active
(105, 1003, 'enroll', '2023-10-20 10:00:00', NULL, NULL),
(105, 1003, 'start_lesson', '2023-10-21 11:00:00', 1, NULL),
(105, 1003, 'finish_lesson', '2023-10-22 12:00:00', 1, NULL);
