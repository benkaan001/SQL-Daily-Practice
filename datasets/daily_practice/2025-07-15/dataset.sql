-- Create database if not exists
CREATE DATABASE IF NOT EXISTS daily_practice_20250715_schema;
USE daily_practice_20250715_schema;


-- Create Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    enrollment_date DATE NOT NULL,
    major VARCHAR(50), -- Can be NULL
    gpa DECIMAL(3, 2) -- Can be NULL if new student or no grades yet
);

-- Insert Data into Students Table
INSERT INTO Students (student_id, first_name, last_name, enrollment_date, major, gpa) VALUES
(101, 'Alice', 'Smith', '2023-09-01', 'Computer Science', 3.85),
(102, 'Bob', 'Johnson', '2023-09-01', 'Mathematics', 3.20),
(103, 'Charlie', 'Brown', '2023-09-01', 'Physics', 3.90),
(104, 'Diana', 'Miller', '2023-09-01', 'Computer Science', 3.50),
(105, 'Eve', 'Davis', '2024-01-15', 'History', NULL), -- New student, no GPA yet
(106, 'Frank', 'Wilson', '2023-09-01', NULL, 2.90); -- NULL major

-- Create Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    credits INT NOT NULL,
    instructor VARCHAR(50) NOT NULL
);

-- Insert Data into Courses Table
INSERT INTO Courses (course_id, course_name, department, credits, instructor) VALUES
(1001, 'Intro to Programming', 'Computer Science', 3, 'Prof. Green'),
(1002, 'Calculus I', 'Mathematics', 4, 'Prof. White'),
(1003, 'Classical Mechanics', 'Physics', 4, 'Prof. Black'),
(1004, 'Data Structures', 'Computer Science', 3, 'Prof. Green'),
(1005, 'Linear Algebra', 'Mathematics', 3, 'Prof. White'),
(1006, 'Operating Systems', 'Computer Science', 4, 'Prof. Blue'),
(1007, 'World History I', 'History', 3, 'Prof. Red');

-- Create Grades Table
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    semester VARCHAR(20) NOT NULL, -- e.g., 'Fall 2023', 'Spring 2024'
    grade DECIMAL(3, 2) NOT NULL, -- e.g., 4.00 for A, 3.00 for B, 2.00 for C, 1.00 for D, 0.00 for F
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Data into Grades Table
-- Alice Smith (ID 101)
INSERT INTO Grades (student_id, course_id, semester, grade) VALUES
(101, 1001, 'Fall 2023', 4.00), -- A
(101, 1002, 'Fall 2023', 3.50), -- B+
(101, 1004, 'Spring 2024', 4.00), -- A
(101, 1006, 'Spring 2024', 3.80); -- A-

-- Bob Johnson (ID 102)
INSERT INTO Grades (student_id, course_id, semester, grade) VALUES
(102, 1001, 'Fall 2023', 3.00), -- B
(102, 1002, 'Fall 2023', 3.00), -- B
(102, 1005, 'Spring 2024', 3.50); -- B+

-- Charlie Brown (ID 103)
INSERT INTO Grades (student_id, course_id, semester, grade) VALUES
(103, 1001, 'Fall 2023', 4.00), -- A
(103, 1003, 'Fall 2023', 4.00), -- A
(103, 1002, 'Spring 2024', 3.80); -- A-

-- Diana Miller (ID 104)
INSERT INTO Grades (student_id, course_id, semester, grade) VALUES
(104, 1001, 'Fall 2023', 3.50), -- B+
(104, 1004, 'Spring 2024', 3.00); -- B

-- Eve Davis (ID 105) - New student, one grade
INSERT INTO Grades (student_id, course_id, semester, grade) VALUES
(105, 1007, 'Spring 2024', 3.00); -- B

-- Frank Wilson (ID 106)
INSERT INTO Grades (student_id, course_id, semester, grade) VALUES
(106, 1001, 'Fall 2023', 2.00), -- C
(106, 1002, 'Fall 2023', 1.00); -- D

-- Add some more grades for existing students to ensure variety
INSERT INTO Grades (student_id, course_id, semester, grade) VALUES
(101, 1005, 'Summer 2024', 4.00), -- Alice takes an extra course
(102, 1006, 'Summer 2024', 2.50), -- Bob struggles with OS
(103, 1004, 'Summer 2024', 3.00); -- Charlie takes DS
