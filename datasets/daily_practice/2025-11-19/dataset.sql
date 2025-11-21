CREATE DATABASE IF NOT EXISTS daily_practice_20251119_schema;
USE daily_practice_20251119_schema;

-- This table logs key changes related to marketing campaign budget allocation.
CREATE TABLE marketing_budget_allocation (
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    campaign_id VARCHAR(50),
    change_timestamp DATETIME(3),
    budget_change DECIMAL(10, 2), -- Positive for increase, negative for decrease
    channel VARCHAR(50)
);

INSERT INTO marketing_budget_allocation (campaign_id, change_timestamp, budget_change, channel) VALUES
-- Campaign 'Q4_Holiday': Needs two continuous increases (3 or more increases in a row).
('Q4_Holiday', '2023-11-01 09:00:00.000', 5000.00, 'Search'),
('Q4_Holiday', '2023-11-01 10:00:00.000', -1000.00, 'Search'), -- Interruption
('Q4_Holiday', '2023-11-02 11:00:00.000', 2000.00, 'Social'),
('Q4_Holiday', '2023-11-03 12:00:00.000', 3000.00, 'Social'),
('Q4_Holiday', '2023-11-04 13:00:00.000', 5000.00, 'Social'), -- Continuous 3-day increase streak starts here (3 increases in a row)
('Q4_Holiday', '2023-11-05 14:00:00.000', 1000.00, 'Social'),
('Q4_Holiday', '2023-11-06 15:00:00.000', 200.00, 'Search'), -- Budget increased, but channel changed

-- Campaign 'New_Product_Launch': Budget is cut repeatedly.
('New_Product_Launch', '2023-11-01 14:00:00.000', 10000.00, 'Video'),
('New_Product_Launch', '2023-11-02 15:00:00.000', -500.00, 'Video'),
('New_Product_Launch', '2023-11-03 16:00:00.000', -200.00, 'Video'),
('New_Product_Launch', '2023-11-04 17:00:00.000', -100.00, 'Video'), -- Continuous 3-day decrease streak

-- Campaign 'Brand_Awareness': Increases, but not 3 days in a row
('Brand_Awareness', '2023-11-05 18:00:00.000', 1000.00, 'Display'),
('Brand_Awareness', '2023-11-06 19:00:00.000', 500.00, 'Display'),
('Brand_Awareness', '2023-11-07 20:00:00.000', -100.00, 'Display'), -- Interruption
('Brand_Awareness', '2023-11-08 21:00:00.000', 2000.00, 'Display');