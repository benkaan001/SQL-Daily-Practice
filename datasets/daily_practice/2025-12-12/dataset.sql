CREATE DATABASE IF NOT EXISTS daily_practice_20251212_schema;
USE daily_practice_20251212_schema;

-- This table logs user reviews for products.
CREATE TABLE product_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    user_id INT,
    rating INT, -- 1 to 5 stars
    review_timestamp DATETIME(3)
);

INSERT INTO product_reviews (product_id, user_id, rating, review_timestamp) VALUES
-- Product 101: Organic, healthy reviews over time
(101, 501, 5, '2023-12-12 08:00:00.000'),
(101, 502, 4, '2023-12-12 09:30:00.000'),
(101, 503, 5, '2023-12-12 12:15:00.000'),

-- Product 102: Targeted "Review Bombing" attack
(102, 504, 5, '2023-12-12 10:00:00.000'), -- Normal review
(102, 505, 1, '2023-12-12 14:00:00.000'), -- Attack starts
(102, 506, 1, '2023-12-12 14:05:00.000'),
(102, 507, 1, '2023-12-12 14:12:00.000'),
(102, 508, 1, '2023-12-12 14:20:00.000'),
(102, 509, 1, '2023-12-12 14:25:00.000'), -- 5th 1-star review in < 30 mins
(102, 510, 2, '2023-12-12 15:00:00.000'), -- Attack subsides

-- Product 103: Consistent low quality (not a burst)
(103, 601, 1, '2023-12-12 09:00:00.000'),
(103, 602, 1, '2023-12-12 10:30:00.000'),
(103, 603, 1, '2023-12-12 12:00:00.000'),
(103, 604, 1, '2023-12-12 13:30:00.000');