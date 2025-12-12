CREATE DATABASE IF NOT EXISTS daily_practice_20251204_schema;
USE daily_practice_20251204_schema;

CREATE TABLE social_interactions (
    interaction_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    interaction_type ENUM('LIKE', 'COMMENT', 'SHARE'),
    timestamp DATETIME
);

INSERT INTO social_interactions (post_id, user_id, interaction_type, timestamp) VALUES
-- Post 1: Popular (More likes than comments)
(1, 101, 'LIKE', '2023-12-04 10:00:00'),
(1, 102, 'LIKE', '2023-12-04 10:01:00'),
(1, 103, 'COMMENT', '2023-12-04 10:05:00'),

-- Post 2: "Ratioed" (More comments than likes)
(2, 104, 'LIKE', '2023-12-04 11:00:00'),
(2, 105, 'COMMENT', '2023-12-04 11:05:00'),
(2, 106, 'COMMENT', '2023-12-04 11:10:00'),
(2, 107, 'COMMENT', '2023-12-04 11:15:00');