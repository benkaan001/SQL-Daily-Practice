CREATE DATABASE IF NOT EXISTS daily_practice_20260307_schema;
USE daily_practice_20260307_schema;

-- This table logs individual page views within user sessions on a website.
CREATE TABLE web_navigation (
    view_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR(50),
    view_timestamp DATETIME(3),
    page_url VARCHAR(100)
);

INSERT INTO web_navigation (session_id, view_timestamp, page_url) VALUES
-- Session 1: A smooth path to conversion
('sess_1', '2026-03-07 10:00:00', '/home'),
('sess_1', '2026-03-07 10:01:00', '/products'),
('sess_1', '2026-03-07 10:05:00', '/checkout'),
('sess_1', '2026-03-07 10:10:00', '/success'),

-- Session 2: Browsing, reading the blog, then looking at products
('sess_2', '2026-03-07 10:15:00', '/home'),
('sess_2', '2026-03-07 10:16:00', '/blog'),
('sess_2', '2026-03-07 10:20:00', '/home'),
('sess_2', '2026-03-07 10:22:00', '/products'),

-- Session 3: Abandons checkout to go back to the homepage
('sess_3', '2026-03-07 10:30:00', '/home'),
('sess_3', '2026-03-07 10:31:00', '/products'),
('sess_3', '2026-03-07 10:35:00', '/checkout'),
('sess_3', '2026-03-07 10:40:00', '/home'),

-- Session 4: Enters directly on a product page, successfully checks out
('sess_4', '2026-03-07 11:00:00', '/products'),
('sess_4', '2026-03-07 11:05:00', '/checkout'),
('sess_4', '2026-03-07 11:10:00', '/success'),

-- Session 5: Looks at products, then decides to read the blog
('sess_5', '2026-03-07 11:15:00', '/home'),
('sess_5', '2026-03-07 11:16:00', '/products'),
('sess_5', '2026-03-07 11:20:00', '/blog'),

-- Session 6: Enters on the blog, goes to the homepage
('sess_6', '2026-03-07 11:30:00', '/blog'),
('sess_6', '2026-03-07 11:35:00', '/home');