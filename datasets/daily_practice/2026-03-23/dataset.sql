CREATE DATABASE IF NOT EXISTS daily_practice_20260323_schema;
USE daily_practice_20260323_schema;

-- This table logs every time a user clicks a marketing link or visits the site.
-- The 'is_purchase' flag indicates if that specific session resulted in a sale.
CREATE TABLE marketing_touches (
    touch_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    touch_timestamp DATETIME,
    marketing_channel VARCHAR(50),
    is_purchase BOOLEAN
);

INSERT INTO marketing_touches (user_id, touch_timestamp, marketing_channel, is_purchase) VALUES
-- User 101: Discovers via Social, returns via Organic, buys via Email
(101, '2026-02-01 10:00:00', 'Social Media', FALSE),
(101, '2026-02-05 14:00:00', 'Organic Search', FALSE),
(101, '2026-02-10 09:00:00', 'Email Promo', TRUE),

-- User 102: Same-day conversion, First and Last touch are the same
(102, '2026-02-15 11:00:00', 'Paid Search', FALSE),
(102, '2026-02-15 11:30:00', 'Paid Search', TRUE),

-- User 103: Has multiple touches but has not converted yet
(103, '2026-02-20 16:00:00', 'Organic Search', FALSE),
(103, '2026-02-25 10:00:00', 'Direct Traffic', FALSE),

-- User 104: Long journey, multiple touches before buying
(104, '2026-01-10 08:00:00', 'Influencer Link', FALSE),
(104, '2026-01-20 09:00:00', 'Social Media', FALSE),
(104, '2026-02-10 10:00:00', 'Retargeting Ad', FALSE),
(104, '2026-03-01 15:00:00', 'Direct Traffic', TRUE),

-- User 105: Makes multiple purchases, we only care up to the FIRST purchase
(105, '2026-03-05 12:00:00', 'Email Promo', FALSE),
(105, '2026-03-06 14:00:00', 'Organic Search', TRUE),
(105, '2026-03-10 10:00:00', 'Direct Traffic', TRUE);