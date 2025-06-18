-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250626_schema;
USE daily_practice_20250626_schema;


-- Create Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    difficulty ENUM('Beginner', 'Intermediate', 'Advanced') NOT NULL,
    duration_hours INT NOT NULL -- Total hours of course content
);

-- Insert Data into Courses Table
INSERT INTO Courses (course_id, course_name, category, difficulty, duration_hours) VALUES
(101, 'SQL for Data Analysis', 'Data Science', 'Intermediate', 20),
(102, 'Python Programming Basics', 'Programming', 'Beginner', 30),
(103, 'Machine Learning Fundamentals', 'Data Science', 'Advanced', 45),
(104, 'Web Development HTML/CSS', 'Programming', 'Beginner', 25),
(105, 'Cloud Computing Essentials', 'IT & Software', 'Intermediate', 35),
(106, 'Cybersecurity Introduction', 'IT & Software', 'Beginner', 20),
(107, 'Advanced Database Design', 'Data Science', 'Advanced', 40),
(108, 'JavaScript for Web', 'Programming', 'Intermediate', 30),
(109, 'Data Visualization with Tableau', 'Data Science', 'Beginner', 15),
(110, 'Project Management Agile', 'Business', 'Intermediate', 28);


-- Create Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    completion_date DATE, -- NULL if not completed yet
    progress_percentage DECIMAL(5, 2) NOT NULL DEFAULT 0.00, -- 0 to 100
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Data into Enrollments Table
-- Student 1: Completes many courses
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, progress_percentage) VALUES
(1, 101, '2024-01-01', '2024-02-15', 100.00), -- Completed
(1, 102, '2024-01-05', '2024-02-20', 100.00), -- Completed
(1, 103, '2024-03-01', NULL, 75.00), -- In Progress
(1, 104, '2024-03-10', '2024-04-05', 100.00), -- Completed
(1, 107, '2024-05-01', NULL, 10.00); -- Barely started

-- Student 2: Some completions, some drop-outs (low progress, no completion date)
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, progress_percentage) VALUES
(2, 101, '2024-01-10', '2024-03-01', 100.00), -- Completed
(2, 105, '2024-02-01', NULL, 10.00), -- Likely dropped
(2, 106, '2024-03-01', NULL, 5.00); -- Likely dropped

-- Student 3: Completed one, started another
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, progress_percentage) VALUES
(3, 102, '2024-02-01', '2024-03-10', 100.00), -- Completed
(3, 108, '2024-03-15', NULL, 60.00); -- In progress

-- Student 4: Single enrollment, completed
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, progress_percentage) VALUES
(4, 109, '2024-04-01', '2024-04-20', 100.00);

-- Student 5: Enrolled but no progress
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, progress_percentage) VALUES
(5, 110, '2024-05-01', NULL, 0.00); -- No progress

-- Student 6: Multiple enrollments, no completions (new student)
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, progress_percentage) VALUES
(6, 101, '2024-06-01', NULL, 20.00),
(6, 102, '2024-06-05', NULL, 15.00);

-- Student 7: Another full completion
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, progress_percentage) VALUES
(7, 105, '2024-01-01', '2024-03-01', 100.00);

-- Student 8: Has not enrolled in any course
-- (This implicitly tests for LEFT JOIN behavior where a student_id might not appear in Enrollments)

-- Additional data for edge cases/testing
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, progress_percentage) VALUES
(1, 105, '2024-06-01', NULL, 99.00), -- Very high progress, but not completed
(2, 104, '2024-01-01', NULL, 0.00), -- Dropped with 0 progress
(9, 101, '2024-05-10', NULL, 0.00); -- New student, no progress
