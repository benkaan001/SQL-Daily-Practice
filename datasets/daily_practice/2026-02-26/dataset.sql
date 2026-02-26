CREATE DATABASE IF NOT EXISTS daily_practice_20260226_schema;
USE daily_practice_20260226_schema;

-- This table stores promotional periods for various products.
-- Often, marketing teams create overlapping or back-to-back promotions.
CREATE TABLE product_promotions (
    promo_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    start_date DATE,
    end_date DATE,
    discount_name VARCHAR(50)
);

INSERT INTO product_promotions (product_id, start_date, end_date, discount_name) VALUES
-- Product 101: Overlapping, contiguous, and isolated promos
(101, '2026-03-01', '2026-03-05', 'Spring Kickoff'),
(101, '2026-03-04', '2026-03-08', 'Flash Sale'),        -- Overlaps with previous
(101, '2026-03-09', '2026-03-12', 'Members Only'),      -- Contiguous (starts day after previous ends)
(101, '2026-03-20', '2026-03-25', 'Clearance'),         -- Isolated block (Gap before this)

-- Product 102: Fully contained promotions
(102, '2026-04-01', '2026-04-15', 'April Showers'),
(102, '2026-04-05', '2026-04-10', 'Mid-Week Drop'),     -- Fully contained within April Showers

-- Product 103: Two separate non-overlapping blocks
(103, '2026-05-01', '2026-05-05', 'May Day'),
(103, '2026-05-10', '2026-05-15', 'Mid-May Markdown');