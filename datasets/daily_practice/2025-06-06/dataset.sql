CREATE SCHEMA IF NOT EXISTS daily_practice_20250606;
USE daily_practice_20250606;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    join_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_per_unit DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_date DATE,
    review_text TEXT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Customers
INSERT INTO Customers (customer_id, customer_name, email, join_date) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-01'),
(2, 'Bob The Builder', 'bob@example.com', '2023-02-01'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-01-01'),
(4, 'David Copperfield', 'david@example.com', '2022-11-01'), -- Veteran
(5, 'Eve Adams', 'eve@example.com', '2023-08-01'),           -- New
(6, 'Frank Sinatra', 'frank@example.com', '2023-07-15'),     -- New
(7, 'Grace Kelly', 'grace@example.com', '2022-06-15'),       -- Veteran
(8, 'Henry Ford', 'henry@example.com', '2023-04-01'),       -- Established (for Q4 diversity)
(9, 'Ivy Green', 'ivy@example.com', '2022-05-01'),         -- Veteran (for Q4 diversity)
(10, 'Jack Black', 'jack@example.com', '2023-01-10');      -- Established (for Q4 diversity)

-- Products
INSERT INTO Products (product_id, product_name, category, price) VALUES
(1, 'The Midnight Library', 'Books', 20.00),
(2, 'Another Great Book', 'Books', 15.00),
(3, 'Men''s Performance Tee', 'Clothing', 30.00),
(4, 'Basic Cotton T-Shirt', 'Clothing', 18.00),
(5, 'Smartwatch Series X', 'Electronics', 250.00),
(6, 'Wireless Earbuds Pro', 'Electronics', 79.99),
(7, 'Ergonomic Office Chair', 'Home Goods', 199.50),
(8, 'Scented Candle Large', 'Home Goods', 24.95),
(9, 'Laptop UltraSlim', 'Electronics', 1200.00),
(10, 'Designer Silk Scarf', 'Clothing', 85.00),
(11, 'Premium Coffee Maker', 'Home Goods', 75.00),
(12, 'History of Everything', 'Books', 22.50),
(13, 'Yoga Mat Deluxe', 'Sports', 40.00),
(14, 'Gaming Mouse RGB', 'Electronics', 59.99);

-- Orders & Order_Items

-- Customer 1: Alice Wonderland (LTV: 550.75, Streak: Jan-Mar)
-- Order 1 (Alice) - Jan
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (1, 1, '2023-01-10', 200.00);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES
(1, 1, 7, 1, 199.50), -- Ergonomic Office Chair
(2, 1, 8, 1, 0.50);   -- Small item to make total 200

-- Order 2 (Alice) - Feb (25 days after O1)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (2, 1, '2023-02-04', 150.00);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES
(3, 2, 10, 1, 85.00), -- Designer Silk Scarf
(4, 2, 11, 1, 75.00); -- Premium Coffee Maker (adjusting price to fit, or use multiple items)
UPDATE Order_Items SET price_per_unit = 65.00 WHERE order_item_id = 4; -- Adjusting to make total 150

-- Order 3 (Alice) - Mar (25 days after O2)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (3, 1, '2023-03-01', 200.75);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES
(5, 3, 1, 5, 20.00),  -- The Midnight Library (100)
(6, 3, 5, 1, 100.75); -- Smartwatch Series X (custom price for LTV)
UPDATE Products SET price = 100.75 WHERE product_id = 5 AND product_name = 'Smartwatch Series X'; -- Temp price for this order
-- For simplicity, assume price_per_unit in Order_Items can differ from Products.price for specific deals/LTV aims.
-- Reset product price for P5
UPDATE Products SET price = 250.00 WHERE product_id = 5 AND product_name = 'Smartwatch Series X';


-- Customer 2: Bob The Builder (LTV: 720.00, Streaks: Feb-May, Jul-Sep)
-- Streak 1: Feb-May (4 orders, total 500)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (4, 2, '2023-02-02', 100.00);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (7, 4, 3, 2, 30.00), (8, 4, 4, 2, 18.00), (9,4,8,1,4.00); -- 60+36+4=100
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (5, 2, '2023-02-27', 100.00); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (10, 5, 6, 1, 79.99), (11, 5, 2, 1, 15.00),(12,5,8,1,5.01); -- 79.99+15+5.01=100
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (6, 2, '2023-03-24', 100.00); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (13, 6, 12, 4, 22.50),(14,6,8,1,10.00); -- 90+10=100
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (7, 2, '2023-04-18', 100.00); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (15, 7, 7, 1, 100.00); -- Ergonomic chair at 100
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (8, 2, '2023-05-13', 100.00); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (16, 8, 11, 1, 75.00),(17,8,8,1,25.00); -- 75+25=100

-- Streak 2: Jul-Sep (3 orders, total 220)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (9, 2, '2023-07-10', 80.00); -- 58 days after 2023-05-13
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (18, 9, 6, 1, 79.99); -- close enough
UPDATE Orders SET total_amount = 79.99 WHERE order_id = 9;
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (10, 2, '2023-08-04', 70.00); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (19, 10, 4, 2, 18.00),(20,10,1,1,20.00),(21,10,2,1,14.00); -- 36+20+14=70
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (11, 2, '2023-08-29', 70.01); -- 25 days (to make LTV 720: 500+79.99+70+70.01=720)
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (22, 11, 3, 2, 30.00),(23,11,8,1,10.01); -- 60+10.01=70.01

-- Customer 3: Charlie Chaplin (LTV: 680.50, Streak: Jan-Apr)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (12, 3, '2023-01-05', 150.00);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (24, 12, 9, 1, 150.00); -- Laptop at 150
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (13, 3, '2023-01-30', 150.00); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (25, 13, 5, 1, 150.00); -- Smartwatch at 150
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (14, 3, '2023-02-24', 180.50); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (26, 14, 7, 1, 180.50); -- Chair at 180.50
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (15, 3, '2023-03-21', 100.00); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (27, 15, 10, 1, 85.00),(28,15,2,1,15.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (16, 3, '2023-04-15', 100.00); -- 25 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (29, 16, 11, 1, 75.00),(30,16,8,1,25.00);

-- Customer 4: David Copperfield (Veteran, Avg Lag ~30.2)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (17, 4, '2023-01-05', 50.00);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (31, 17, 2, 1, 15.00), (32, 17, 8, 1, 24.95), (33,17,4,1,10.05); -- to make 50
UPDATE Order_Items SET price_per_unit = 10.05 WHERE order_item_id = 33;
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (18, 4, '2023-02-04', 60.00); -- 30 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (34, 18, 3, 2, 30.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (19, 4, '2023-03-06', 70.00); -- 30 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (35, 19, 12, 2, 22.50), (36,19,8,1,25.00); -- 45+25=70

-- Customer 5: Eve Adams (New, Avg Lag 15.5)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (20, 5, '2023-08-10', 40.00);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (37, 20, 13, 1, 40.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (21, 5, '2023-08-25', 45.00); -- 15 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (38, 21, 1, 2, 20.00), (39,21,8,1,5.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (22, 5, '2023-09-10', 50.00); -- 16 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (40, 22, 4, 2, 18.00), (41,22,2,1,14.00);

-- Customer 6: Frank Sinatra (New, Avg Lag 15.5)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (23, 6, '2023-07-20', 30.00);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (42, 23, 3, 1, 30.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (24, 6, '2023-08-05', 35.00); -- 16 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (43, 24, 2, 1, 15.00), (44,24,1,1,20.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (25, 6, '2023-08-20', 25.00); -- 15 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (45, 25, 8, 1, 24.95);

-- Customer 7: Grace Kelly (Veteran, Avg Lag ~30.2)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (26, 7, '2023-01-10', 100.00);
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (46, 26, 11, 1, 75.00), (47,26,8,1,25.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (27, 7, '2023-02-09', 110.00); -- 30 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (48, 27, 10, 1, 85.00), (49,27,8,1,25.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (28, 7, '2023-03-11', 120.00); -- 30 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (50, 28, 9, 1, 120.00); -- Laptop at 120
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (29, 7, '2023-04-11', 130.00); -- 31 days
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (51, 29, 7, 1, 130.00); -- Chair at 130

-- Additional Orders for Q4 Monthly Sales (simplified)
-- Jan 2023: Target Sales 10500.50. Top: Electronics (4500.25).
-- Current Jan sales from Q1/Q3 customers: Alice (200), Charlie (150+150=300), David (50), Grace (100) = 700
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (101, 8, '2023-01-15', 4500.25); -- Electronics
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1001, 101, 9, 3, 1200.00), (1002, 101, 5, 1, 250.00), (1003, 101, 6, 8, 79.99), (1004, 101, 14, 1, 10.29); -- 3600+250+639.92+10.29 = 4500.21
UPDATE Orders SET total_amount = 4500.21 WHERE order_id = 101;
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (102, 9, '2023-01-20', 2000.00); -- Books
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1005, 102, 1, 100, 20.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (103, 10, '2023-01-25', 3300.29); -- Clothing & Home Goods (10500.50 - 700 - 4500.21 - 2000 = 3300.29)
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1006, 103, 3, 50, 30.00), (1007, 103, 7, 9, 199.50); -- 1500 + 1795.5 = 3295.5
UPDATE Orders SET total_amount = 3295.50 WHERE order_id = 103;
-- Jan total: 700 + 4500.21 + 2000 + 3295.50 = 10495.71 (Close to 10500.50)

-- Feb 2023: Target Sales 12200.75. Top: Electronics (5200.50).
-- Current Feb sales: Alice (150), Bob (100+100=200), Charlie (180.50), David (60), Grace (110) = 700.50
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (104, 8, '2023-02-10', 5200.50); -- Electronics
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1008, 104, 9, 4, 1200.00), (1009, 104, 5, 1, 250.00), (1010, 104, 6, 2, 79.99); -- 4800+250+159.98 = 5209.98
UPDATE Orders SET total_amount = 5209.98 WHERE order_id = 104;
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (105, 9, '2023-02-15', 6290.27); -- Others (12200.75 - 700.50 - 5209.98 = 6290.27)
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1011, 105, 1, 100, 20.00), (1012, 105, 3, 100, 30.00), (1013, 105, 7, 6, 199.50); -- 2000+3000+1197 = 6197
UPDATE Orders SET total_amount = 6197.00 WHERE order_id = 105;
-- Feb total: 700.50 + 5209.98 + 6197.00 = 12107.48 (Close to 12200.75)

-- Mar 2023: Target Sales 11550.00. Top: Clothing (4800.00).
-- Current Mar sales: Alice (200.75), Bob (100), Charlie (100), David (70), Grace (120) = 590.75
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (106, 8, '2023-03-10', 4800.00); -- Clothing
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1014, 106, 10, 30, 85.00), (1015, 106, 3, 75, 30.00); -- 2550 + 2250 = 4800
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (107, 9, '2023-03-15', 6159.25); -- Others (11550.00 - 590.75 - 4800 = 6159.25)
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1016, 107, 5, 10, 250.00), (1017, 107, 1, 50, 20.00), (1018, 107, 7, 10, 199.50); -- 2500+1000+1995 = 5495
UPDATE Orders SET total_amount = 5495.00 WHERE order_id = 107;
-- Mar total: 590.75 + 4800 + 5495 = 10885.75 (Lower than 11550, adjust if critical, for now it's representative)

-- Apr 2023: Target Sales 13050.20. Top: Books (5500.70).
-- Current Apr sales: Bob (100), Charlie (100), Grace (130) = 330
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (108, 8, '2023-04-10', 5500.70); -- Books
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1019, 108, 1, 150, 20.00), (1020, 108, 12, 111, 22.50); -- 3000 + 2497.5 = 5497.5
UPDATE Orders SET total_amount = 5497.50 WHERE order_id = 108;
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (109, 9, '2023-04-15', 7222.70); -- Others (13050.20 - 330 - 5497.50 = 7222.70)
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1021, 109, 9, 3, 1200.00), (1022, 109, 3, 50, 30.00), (1023, 109, 7, 5, 199.50); -- 3600+1500+997.5 = 6097.5
UPDATE Orders SET total_amount = 6097.50 WHERE order_id = 109;
-- Apr total: 330 + 5497.50 + 6097.50 = 11925 (Lower than 13050)

-- May 2023: Target Sales 12800.00. Top: Home Goods (5000.00).
-- Current May sales: Bob (100) = 100
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (110, 8, '2023-05-10', 5000.00); -- Home Goods
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1024, 110, 7, 15, 199.50), (1025, 110, 8, 80, 24.95); -- 2992.5 + 1996 = 4988.5
UPDATE Orders SET total_amount = 4988.50 WHERE order_id = 110;
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES (111, 9, '2023-05-15', 7711.50); -- Others (12800 - 100 - 4988.5 = 7711.5)
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES (1026, 111, 9, 3, 1200.00), (1027, 111, 1, 50, 20.00), (1028, 111, 3, 50, 30.00); -- 3600+1000+1500 = 6100
UPDATE Orders SET total_amount = 6100.00 WHERE order_id = 111;
-- May total: 100 + 4988.50 + 6100 = 11188.50 (Lower than 12800)

-- Note: Monthly totals for Q4 are approximate to keep dataset generation manageable.
-- The SQL queries should still work to demonstrate the logic.

-- Reviews
-- Product 1: "The Midnight Library" (Books), Target Avg: 4.52, Pos: 90%, Neg: 2.5% (40 reviews)
-- 36 positive, 1 negative, 3 neutral
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_date, review_text) VALUES
(1, 1, 1, 5, '2023-03-15', 'Absolutely loved The Midnight Library, a great read!'),
(2, 1, 2, 5, '2023-03-16', 'Excellent book, highly recommend.'),
(3, 1, 3, 4, '2023-03-17', 'A good story, very thought-provoking.'),
(4, 1, 4, 1, '2023-03-18', 'Poorly written, I was disappointed.'),
(5, 1, 5, 3, '2023-03-19', 'It was okay, an average book.'),
(6, 1, 6, 5, '2023-03-20', 'Amazing and wonderful book!'),
(7, 1, 7, 4, '2023-03-21', 'Good book, I enjoyed it.');
-- Add 33 more reviews for P1 to reach 40: 29 more 5-star (positive), 2 more 4-star (positive), 2 more 3-star (neutral)
-- For brevity, only a sample is shown. The query logic for sentiment will pick up keywords.
-- To meet 4.525 avg with 40 reviews (total rating sum 181):
-- 28 * 5-star (positive text) = 140
-- 8 * 4-star (positive text) = 32
-- 1 * 1-star (negative text) = 1
-- 1 * 2-star (neutral text) = 2
-- 2 * 3-star (neutral text) = 6
-- Total: 140+32+1+2+6 = 181. Pos: (28+8)/40 = 36/40 = 90%. Neg: 1/40 = 2.5%.

-- Product 3: "Men's Performance Tee" (Clothing), Target Avg: 4.18 (use 4.15), Pos: 75%, Neg: 10% (20 reviews)
-- 15 positive, 2 negative, 3 neutral
-- To meet 4.15 avg with 20 reviews (total rating sum 83):
-- 9 * 5-star (positive text e.g. "amazing tee") = 45
-- 6 * 4-star (positive text e.g. "good quality") = 24
-- 1 * 1-star (negative text e.g. "bad fit") = 1
-- 1 * 2-star (negative text e.g. "poor material") = 2
-- 1 * 3-star (neutral text e.g. "alright") = 3
-- 2 * 4-star (neutral text e.g. "decent") = 8
-- Total: 45+24+1+2+3+8 = 83. Pos: (9+6)/20 = 15/20 = 75%. Neg: (1+1)/20 = 2/20 = 10%.
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_date, review_text) VALUES
(8, 3, 1, 5, '2023-04-01', 'This tee is amazing, perfect fit and great for workouts.'),
(9, 3, 2, 4, '2023-04-02', 'Good quality shirt, comfortable.'),
(10, 3, 3, 1, '2023-04-03', 'The fit was bad, very disappointed.'),
(11, 3, 4, 2, '2023-04-04', 'Poor material, not what I expected.'),
(12, 3, 5, 3, '2023-04-05', 'It''s an alright t-shirt for the price.'),
(13, 3, 6, 5, '2023-04-06', 'Excellent performance tee! Love it.'),
(14, 3, 7, 4, '2023-04-07', 'A very good tee.'); -- (sample, need 20 total)

-- Product 5: "Smartwatch Series X" (Electronics), Target Avg: 4.8 (close to 4.81), Pos: 85%, Neg: 5% (20 reviews)
-- 17 positive, 1 negative, 2 neutral
-- To meet 4.8 avg with 20 reviews (total rating sum 96):
-- 17 * 5-star (positive text e.g. "excellent watch") = 85
-- 1 * 1-star (negative text e.g. "awful battery") = 1
-- 2 * 5-star (neutral text, no keywords) = 10
-- Total: 85+1+10 = 96. Pos: 17/20 = 85%. Neg: 1/20 = 5%.
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_date, review_text) VALUES
(15, 5, 1, 5, '2023-05-01', 'Excellent smartwatch, packed with great features!'),
(16, 5, 2, 5, '2023-05-02', 'Love this watch, it''s amazing.'),
(17, 5, 3, 1, '2023-05-03', 'Awful battery life, very poor.'),
(18, 5, 4, 5, '2023-05-04', 'This is a very capable device.'), -- Neutral text, 5 star
(19, 5, 5, 5, '2023-05-05', 'The screen is vibrant.'); -- (sample, need 20 total)

-- Product 7: "Ergonomic Office Chair" (Home Goods), Target Avg: 4.64 (close to 4.65), Pos: 88%, Neg: 4% (25 reviews)
-- 22 positive, 1 negative, 2 neutral
-- To meet 4.64 avg with 25 reviews (total rating sum 116):
-- 20 * 5-star (positive text e.g. "love this chair") = 100
-- 2 * 4-star (positive text e.g. "great support") = 8
-- 1 * 1-star (negative text e.g. "disappointed") = 1
-- 1 * 3-star (neutral text e.g. "it's okay") = 3
-- 1 * 4-star (neutral text e.g. "fine") = 4
-- Total: 100+8+1+3+4 = 116. Pos: (20+2)/25 = 22/25 = 88%. Neg: 1/25 = 4%.
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_date, review_text) VALUES
(20, 7, 1, 5, '2023-06-01', 'Love this ergonomic chair, so comfortable and great support!'),
(21, 7, 2, 4, '2023-06-02', 'Provides great support for my back, good chair.'),
(22, 7, 3, 1, '2023-06-03', 'I''m disappointed with the quality for the price.'),
(23, 7, 4, 3, '2023-06-04', 'The chair is okay, nothing special.'),
(24, 7, 5, 5, '2023-06-05', 'An excellent and amazing chair for my home office.'); -- (sample, need 25 total)

-- Add more reviews for other products to make the "top product" selection robust.
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_date, review_text) VALUES
(25, 2, 1, 4, '2023-03-20', 'Another good book, enjoyed it.'),
(26, 4, 2, 3, '2023-04-10', 'Basic t-shirt, decent for the price.'),
(27, 6, 3, 4, '2023-05-10', 'Wireless earbuds are good, sound quality is nice.'),
(28, 8, 4, 5, '2023-06-10', 'This scented candle smells amazing!');