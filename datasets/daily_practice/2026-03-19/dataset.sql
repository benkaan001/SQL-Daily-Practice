CREATE DATABASE IF NOT EXISTS daily_practice_20260319_schema;
USE daily_practice_20260319_schema;

-- This table logs individual page views within user sessions on an e-commerce site.
CREATE TABLE user_navigation (
    view_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    view_timestamp DATETIME(3),
    page_name VARCHAR(50)
);

INSERT INTO user_navigation (session_id, view_timestamp, page_name) VALUES
-- Session A: A smooth path to checkout
('sess_A', '2026-03-19 10:00:00', 'Home'),
('sess_A', '2026-03-19 10:01:00', 'Search'),
('sess_A', '2026-03-19 10:02:00', 'Product'),
('sess_A', '2026-03-19 10:05:00', 'Cart'),
('sess_A', '2026-03-19 10:10:00', 'Checkout'),

-- Session B: Looks at a product, checks reviews, then leaves
('sess_B', '2026-03-19 11:00:00', 'Home'),
('sess_B', '2026-03-19 11:01:00', 'Search'),
('sess_B', '2026-03-19 11:02:00', 'Product'),
('sess_B', '2026-03-19 11:04:00', 'Reviews'),

-- Session C: Enters directly on a search page and checks out
('sess_C', '2026-03-19 12:00:00', 'Search'),
('sess_C', '2026-03-19 12:01:00', 'Product'),
('sess_C', '2026-03-19 12:05:00', 'Cart'),
('sess_C', '2026-03-19 12:10:00', 'Checkout'),

-- Session D: Abandons cart
('sess_D', '2026-03-19 13:00:00', 'Home'),
('sess_D', '2026-03-19 13:01:00', 'Search'),
('sess_D', '2026-03-19 13:02:00', 'Product'),
('sess_D', '2026-03-19 13:05:00', 'Cart'),

-- Session E: Enters through a blog post
('sess_E', '2026-03-19 14:00:00', 'Blog'),
('sess_E', '2026-03-19 14:05:00', 'Home'),
('sess_E', '2026-03-19 14:06:00', 'Search'),

-- Session F: Very short session (ignored for 3-step paths)
('sess_F', '2026-03-19 15:00:00', 'Home'),
('sess_F', '2026-03-19 15:01:00', 'Search');