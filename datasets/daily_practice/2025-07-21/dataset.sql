CREATE DATABASE IF NOT EXISTS daily_practice_20250721_schema;
USE daily_practice_20250721_schema;

CREATE TABLE employee_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    review_date DATE,
    department VARCHAR(50),
    job_level INT,
    performance_score DECIMAL(3, 2),
    potential_score DECIMAL(3, 2),
    projects_completed INT,
    last_promotion_date DATE
);

INSERT INTO employee_reviews (employee_id, review_date, department, job_level, performance_score, potential_score, projects_completed, last_promotion_date) VALUES
(101, '2022-12-15', 'Engineering', 2, 4.5, 4.8, 5, '2022-01-10'),
(102, '2022-12-15', 'Engineering', 3, 4.2, 4.0, 8, '2021-07-20'),
(103, '2022-12-20', 'Sales', 2, 3.8, 4.5, 12, '2022-03-01'),
(104, '2022-12-20', 'Marketing', 2, 4.0, 4.2, 3, '2022-02-15'),
(101, '2023-06-15', 'Engineering', 2, 4.6, 4.9, 6, '2022-01-10'),
(105, '2023-06-18', 'Engineering', 1, 4.8, 5.0, 4, NULL),
(102, '2023-06-15', 'Engineering', 3, 4.0, 3.8, 7, '2021-07-20'),
(106, '2023-06-20', 'Sales', 1, 4.9, 4.8, 15, NULL),
(103, '2023-06-20', 'Sales', 3, 4.1, 4.6, 14, '2023-01-05'),
(104, '2023-06-22', 'Marketing', 2, 3.5, 3.8, 4, '2022-02-15'),
(107, '2023-06-22', 'Marketing', 3, 4.3, 4.0, 6, '2021-11-01'),
(101, '2023-12-15', 'Engineering', 3, 4.8, 4.9, 7, '2023-07-01'),
(102, '2023-12-15', 'Engineering', 3, 4.3, 4.1, 8, '2021-07-20'),
(105, '2023-12-18', 'Engineering', 2, 4.7, 4.8, 5, '2023-07-01'),
(103, '2023-12-20', 'Sales', 3, 4.0, 4.5, 11, '2023-01-05'),
(108, '2023-12-20', 'Sales', 2, 3.9, 4.0, 10, '2023-02-01'),
(104, '2023-12-22', 'Marketing', 3, 3.8, 4.0, 5, '2023-08-01'),
(107, '2023-12-22', 'Marketing', 3, 4.2, 3.9, 5, '2021-11-01'),
(106, '2023-12-20', 'Sales', 2, 4.7, 4.6, 18, '2023-07-01');
