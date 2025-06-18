-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250624_schema;
USE daily_practice_20250624_schema;

-- Create Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Insert Data into Products Table
INSERT INTO Products (product_id, product_name, category, price, stock_quantity) VALUES
(101, 'Laptop Pro X', 'Electronics', 1200.00, 50),
(102, 'Mechanical Keyboard', 'Electronics', 150.00, 120),
(103, 'Ergonomic Chair', 'Office Supplies', 300.00, 30),
(104, 'Smartwatch Gen 5', 'Wearables', 250.00, 70),
(105, 'Organic Coffee Beans', 'Food & Beverage', 25.00, 200),
(106, 'Wireless Earbuds', 'Electronics', 100.00, 80),
(107, 'Yoga Mat Pro', 'Sports & Outdoors', 40.00, 150),
(108, 'Noise Cancelling Headphones', 'Electronics', 200.00, 60),
(109, 'Cookbook: Italian Classics', 'Books', 30.00, 100),
(110, 'Desk Lamp Smart', 'Office Supplies', 60.00, 90);

-- Create Reviews Table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    review_date DATE NOT NULL,
    rating INT NOT NULL, -- 1 to 5 stars
    review_text TEXT, -- Can be NULL for just star ratings
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Data into Reviews Table
-- Reviews for Laptop Pro X (product_id 101)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(101, 1001, '2025-01-15', 5, 'Absolutely fantastic laptop for professional work! Fast and reliable.'),
(101, 1002, '2025-01-20', 4, 'Great performance, but a bit heavy. Overall satisfied.'),
(101, 1003, '2025-02-01', 5, 'Highly recommend for its speed and display quality.'),
(101, 1004, '2025-02-10', 3, 'Decent, but battery life could be better. Runs hot sometimes.'),
(101, 1005, '2025-03-05', 5, 'Best laptop I\'ve ever owned.'),
(101, 1001, '2025-06-10', 5, 'Still loving it after months of use!');

-- Reviews for Mechanical Keyboard (product_id 102)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(102, 1001, '2025-01-25', 4, 'Solid build, satisfying clicks. A bit noisy though.'),
(102, 1006, '2025-02-15', 5, 'Perfect for gaming and typing. Backlight is a nice touch.'),
(102, 1007, '2025-03-20', 3, 'Keycaps feel cheap after a while. Expected more for the price.');

-- Reviews for Ergonomic Chair (product_id 103)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(103, 1002, '2025-02-05', 5, 'Very comfortable, improved my posture significantly.'),
(103, 1008, '2025-03-01', 4, 'Good chair, but assembly was a bit tricky.'),
(103, 1009, '2025-04-10', 5, 'Worth every penny for the comfort it provides.');

-- Reviews for Smartwatch Gen 5 (product_id 104)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(104, 1003, '2025-02-15', 3, 'Battery drains quickly. Features are good, but usability suffers.'),
(104, 1010, '2025-03-10', 4, 'Sleek design, works well with my phone.'),
(104, 1001, '2025-06-15', 2, 'Battery life has worsened. Disappointed with the longevity.'); -- Alice's second review

-- Reviews for Organic Coffee Beans (product_id 105)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(105, 1004, '2025-02-20', 5, 'Rich flavor, great aroma. My new favorite coffee!'),
(105, 1005, '2025-03-10', 5, 'Excellent quality. Smooth and delicious.'),
(105, 1006, '2025-04-01', 4, 'Good, but a little pricey for the quantity.');

-- Reviews for Wireless Earbuds (product_id 106)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(106, 1007, '2025-03-05', 2, 'Poor sound quality and constantly disconnecting.'),
(106, 1008, '2025-04-15', 1, 'Worst earbuds ever. Returned them the next day. The bass is non-existent.');

-- Reviews for Yoga Mat Pro (product_id 107)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(107, 1009, '2025-04-01', 5, 'Very grippy and comfortable for yoga.'),
(107, 1010, '2025-05-01', 5, 'Perfect thickness and durability.');

-- Reviews for Noise Cancelling Headphones (product_id 108)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(108, 1001, '2025-04-20', 5, 'Amazing sound and noise cancellation. A must-have for travel.'),
(108, 1002, '2025-05-10', 5, 'Top-notch quality. Blocks out all distractions. Highly recommended.');

-- Reviews for Cookbook: Italian Classics (product_id 109)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(109, 1003, '2025-05-15', 4, 'Great recipes, easy to follow. Some ingredients are hard to find.'),
(109, 1004, '2025-06-01', 5, 'A truly classic cookbook. Delicious results every time.');

-- Reviews for Desk Lamp Smart (product_id 110)
INSERT INTO Reviews (product_id, customer_id, review_date, rating, review_text) VALUES
(110, 1005, '2025-06-05', 4, 'Smart features work well. Light is bright enough for my desk.'),
(110, 1006, '2025-06-12', 3, 'A bit expensive for a lamp, but the features are nice.'),
(110, 1001, '2025-06-20', 4, NULL); -- NULL review text
