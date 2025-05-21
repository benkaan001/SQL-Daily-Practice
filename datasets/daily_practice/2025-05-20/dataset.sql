CREATE DATABASE IF NOT EXISTS daily_practice_20250520_schema;
USE daily_practice_20250520_schema;

DROP TABLE IF EXISTS search_logs;
CREATE TABLE search_logs (
    search_id INT,
    search_term VARCHAR(255),
    clicked INT,
    search_results_position INT
);

INSERT INTO search_logs (search_id, search_term, clicked, search_results_position) VALUES
(1, 'rabbit', 1, 5),
(2, 'airline', 1, 4),
(3, 'hotel', 1, 1),
(5, 'rabbit', 1, 1),
(6, 'politics', 1, 2),
(10, 'rabbit', 0, 4),
(14, 'rabbit', 1, 3),
(14, 'cat', 1, 3),
(17, 'dog', 0, 5),
(18, 'dog', 1, 3),
(38, 'dog', 0, 2),
(40, 'national', 0, 2),
(50, 'rabbit', 0, 1),
(51, 'dog', 1, 5),
(41, 'law', 0, 1),
(42, 'cat', 1, 4),
(52, 'cat', 1, 2),
(53, 'cat', 1, 1),
(56, 'dog', 0, 2),
(57, 'cat', 1, 2),
(57, 'dog', 1, 1),
(63, 'rabbit', 1, 3),
(63, 'cat', 0, 2),
(68, 'rabbit', 1, 3),
(68, 'cat', 1, 1),
(69, 'education', 1, 3),
(74, 'dog', 0, 3),
(81, 'rabbit', 0, 1),
(90, 'dog', 1, 1),
(97, 'rabbit', 1, 2),
(97, 'dog', 0, 4),
(120, 'rabbit', 1, 1),
(123, 'cat', 1, 1),
(182, 'education', 0, 1),
(720, 'police', 1, 1);