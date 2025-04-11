-- Create the database and table for client calls at Redfin
CREATE DATABASE IF NOT EXISTS daily_practice_20250409_schema;
USE daily_practice_20250409_schema;

-- Calls table stores details of each call associated with a unique request_id.
CREATE TABLE calls (
    id INT PRIMARY KEY,
    created_on TIMESTAMP,
    request_id INT,
    call_duration INT  -- in minutes
);

-- Insert sample data
INSERT INTO calls (id, created_on, request_id, call_duration) VALUES
(1, '2020-03-01 04:08:04', 2, 3),
(2, '2020-03-01 05:28:47', 1, 28),
(3, '2020-03-01 07:27:36', 2, 22),
(4, '2020-03-01 13:18:21', 1, 12),
(5, '2020-03-01 15:08:08', 2, 13),
(6, '2020-03-01 16:27:23', 1, 19),
(7, '2020-03-01 17:38:01', 3, 15),
(8, '2020-03-01 17:56:39', 2, 25),
(9, '2020-03-02 00:10:10', 1, 28),
(10, '2020-03-02 00:45:49', 3, 19),
(11, '2020-03-02 04:28:44', 3, 28),
(12, '2020-03-02 04:52:52', 1, 13),
(13, '2020-03-02 05:02:41', 3, 24),
(14, '2020-03-02 06:19:56', 3, 5),
(15, '2020-03-02 07:25:59', 2, 20),
(16, '2020-03-02 08:20:25', 1, 21),
(17, '2020-03-02 10:45:35', 3, 23),
(18, '2020-03-02 13:38:59', 1, 11),
(19, '2020-03-02 15:02:29', 2, 19),
(20, '2020-03-02 17:13:13', 1, 2);