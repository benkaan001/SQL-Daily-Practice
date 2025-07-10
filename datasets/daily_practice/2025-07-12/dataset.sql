-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250712_schema;
USE daily_practice_20250712_schema;


-- Create Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    current_job_title VARCHAR(50) NOT NULL,
    current_salary DECIMAL(10, 2) NOT NULL
);

-- Insert Data into Employees Table
INSERT INTO Employees (employee_id, first_name, last_name, department, hire_date, current_job_title, current_salary) VALUES
(101, 'Alice', 'Smith', 'Engineering', '2022-01-10', 'Senior Engineer', 110000.00),
(102, 'Bob', 'Johnson', 'Engineering', '2022-03-15', 'Software Engineer', 95000.00),
(103, 'Charlie', 'Brown', 'HR', '2023-02-01', 'HR Specialist', 70000.00),
(104, 'Diana', 'Miller', 'Sales', '2023-01-20', 'Sales Manager', 90000.00),
(105, 'Eve', 'Davis', 'Sales', '2023-03-01', 'Sales Representative', 65000.00),
(106, 'Frank', 'Wilson', 'Marketing', '2022-05-01', 'Marketing Specialist', 75000.00),
(107, 'Grace', 'Taylor', 'Engineering', '2024-01-01', 'Junior Engineer', 80000.00),
(108, 'Henry', 'Moore', 'HR', '2023-04-10', 'HR Assistant', 55000.00);

-- Create PerformanceReviews Table
CREATE TABLE PerformanceReviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    review_date DATE NOT NULL,
    reviewer_id INT NOT NULL, -- ID of the reviewer (could be manager or HR)
    rating INT NOT NULL, -- 1-5 scale, 5 being excellent
    comments TEXT, -- Can be NULL
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Insert Data into PerformanceReviews Table
-- Alice Smith (101)
INSERT INTO PerformanceReviews (employee_id, review_date, reviewer_id, rating, comments) VALUES
(101, '2023-07-01', 201, 5, 'Consistently exceeds expectations.'),
(101, '2024-07-01', 201, 5, 'Outstanding leadership and technical skills.');

-- Bob Johnson (102)
INSERT INTO PerformanceReviews (employee_id, review_date, reviewer_id, rating, comments) VALUES
(102, '2023-07-15', 201, 4, 'Strong contributor, good progress.'),
(102, '2024-07-15', 201, 4, 'Reliable and effective. Ready for more responsibility.');

-- Charlie Brown (103)
INSERT INTO PerformanceReviews (employee_id, review_date, reviewer_id, rating, comments) VALUES
(103, '2023-08-01', 202, 3, 'Meets expectations.'),
(103, '2024-08-01', 202, 4, 'Improved significantly, proactive.');

-- Diana Miller (104)
INSERT INTO PerformanceReviews (employee_id, review_date, reviewer_id, rating, comments) VALUES
(104, '2023-07-01', 203, 5, 'Excellent sales results, highly motivated.'),
(104, '2024-07-01', 203, 5, 'Continues to drive team success.');

-- Eve Davis (105)
INSERT INTO PerformanceReviews (employee_id, review_date, reviewer_id, rating, comments) VALUES
(105, '2023-08-10', 203, 3, 'Learning quickly.'),
(105, '2024-08-10', 203, 3, 'Consistent performance, needs more initiative.');

-- Frank Wilson (106)
INSERT INTO PerformanceReviews (employee_id, review_date, reviewer_id, rating, comments) VALUES
(106, '2023-07-20', 204, 4, 'Creative and detail-oriented.'),
(106, '2024-07-20', 204, 4, 'Delivers high-quality work.');

-- Grace Taylor (107) - New hire, one review
INSERT INTO PerformanceReviews (employee_id, review_date, reviewer_id, rating, comments) VALUES
(107, '2024-07-01', 201, 3, 'Good start, learning the ropes.');

-- Henry Moore (108) - One review, NULL comments
INSERT INTO PerformanceReviews (employee_id, review_date, reviewer_id, rating, comments) VALUES
(108, '2023-08-15', 202, 3, NULL);

-- Create Promotions Table
CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    promotion_date DATE NOT NULL,
    old_job_title VARCHAR(50) NOT NULL,
    new_job_title VARCHAR(50) NOT NULL,
    salary_increase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Insert Data into Promotions Table
INSERT INTO Promotions (employee_id, promotion_date, old_job_title, new_job_title, salary_increase) VALUES
(101, '2024-01-01', 'Software Engineer', 'Senior Engineer', 10000.00),
(104, '2024-02-01', 'Sales Representative', 'Sales Manager', 15000.00),
(103, '2024-03-01', 'HR Assistant', 'HR Specialist', 5000.00),
(102, '2025-01-01', 'Software Engineer', 'Senior Software Engineer', 10000.00); -- Future promotion
