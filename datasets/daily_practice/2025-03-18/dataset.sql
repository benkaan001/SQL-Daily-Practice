CREATE SCHEMA IF NOT EXISTS gym_20250315;
USE gym_20250315;


--------------------------
-- Create Members Table --
--------------------------
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100),
    join_date DATE,
    membership_type VARCHAR(20)  -- May contain NULL values
);

-- Insert initial 5 members
INSERT INTO members (member_id, member_name, join_date, membership_type) VALUES
(1, 'Alice Johnson', '2022-01-10', 'Gold'),
(2, 'Bob Smith', '2022-02-15', 'Silver'),
(3, 'Charlie Davis', '2022-02-28', 'Gold'),
(4, 'Diana Lee', '2022-01-25', NULL),
(5, 'Edward Kim', '2022-03-01', 'Platinum'),
(6, 'Fiona Clark', '2022-06-05', 'Gold'),
(7, 'George Martin', '2022-08-10', 'Silver'),
(8, 'Hannah Lee', '2022-10-15', 'Platinum'),
(9, 'Ian Wright', '2022-12-20', 'Gold'),
(10, 'Julia Roberts', '2023-01-25', 'Silver'),
(11, 'Kevin Durant', '2023-02-28', 'VIP'),
(12, 'Laura Palmer', '2023-03-01', 'Regular'),
(13, 'Marcus Aurelius', '2023-04-05', 'VIP'),
(14, 'Nina Simone', '2023-06-10', 'Gold'),
(15, 'Oliver Twist', '2023-07-15', NULL),
(16, 'Priya Patel', '2023-08-20', 'Platinum'),
(17, 'Mohammed Ali', '2023-09-25', 'Gold'),
(18, 'Sofia Rodriguez', '2023-10-01', 'Silver'),
(19, 'Chen Wei', '2023-11-05', 'VIP'),
(20, 'Aisha Khan', '2023-11-10', 'Regular'),
(21, 'Yuki Tanaka', '2023-11-15', 'Gold'),
(22, 'Lars Anderson', '2023-11-20', 'Platinum'),
(23, 'Zara Ahmed', '2023-12-01', 'Silver'),
(24, 'Diego Martinez', '2023-12-15', 'VIP'),
(25, 'Emma Thompson', '2023-12-31', NULL);

----------------------------
-- Create Trainers Table --
----------------------------
CREATE TABLE trainers (
    trainer_id INT PRIMARY KEY,
    trainer_name VARCHAR(100),
    specialty VARCHAR(50),
    hire_date DATE
);

-- Insert initial 3 trainers
INSERT INTO trainers (trainer_id, trainer_name, specialty, hire_date) VALUES
(1, 'Linda Brown', 'Yoga', '2021-05-10'),
(2, 'Michael Green', 'CrossFit', '2021-08-15'),
(3, 'Sarah White', 'Pilates', '2022-01-05'),
(4, 'Peter Parker', 'Zumba', '2022-06-01'),
(5, 'Quincy Adams', 'Strength Training', '2022-09-01'),
(6, 'Rachel Green', 'Cardio', '2023-01-01'),
(7, 'Kim Jong', 'HIIT Training', '2023-02-15'),
(8, 'Maria Garcia', 'Dance Fitness', '2023-04-01'),
(9, 'Alex Thompson', 'Boxing', '2023-06-15'),
(10, 'Fatima Hassan', 'Nutrition', '2023-08-01'),
(11, 'David Cohen', 'Senior Fitness', '2023-10-15'),
(12, 'Sven Erikson', 'Functional Training', '2023-12-01');

-----------------------------
-- Create Classes Table    --
-----------------------------
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(100),
    trainer_id INT,   -- May be NULL if no trainer assigned
    schedule_date DATE,
    capacity INT,
    location VARCHAR(50),   -- May contain NULL values
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
);

-- Insert 10 classes (IDs 1 to 10)
INSERT INTO classes (class_id, class_name, trainer_id, schedule_date, capacity, location) VALUES
(1, 'Beginner Yoga', 1, '2022-03-10', 20, 'Studio A'),
(2, 'Intro to CrossFit', 2, '2022-05-12', 15, 'Gym Room'),
(3, 'Pilates Basics', 3, '2022-07-14', 18, 'Studio B'),
(4, 'Advanced Yoga', 1, '2022-09-16', 20, 'Studio A'),
(5, 'CrossFit Extreme', 2, '2022-11-18', 15, 'Gym Room'),
(6, 'Morning Yoga', 1, '2023-01-20', 20, 'Studio A'),
(7, 'Evening CrossFit', 2, '2023-03-21', 15, 'Gym Room'),
(8, 'Pilates Intermediate', 3, '2023-05-22', 18, 'Studio B'),
(9, 'Zumba Dance', 4, '2023-07-23', 25, 'Studio C'),
(10, 'Strength Bootcamp', 5, '2023-08-24', 12, 'Gym Room'),
(11, 'Boxing Fundamentals', 9, '2023-09-25', 15, 'Boxing Ring'),
(12, 'Senior Stretch', 11, '2023-09-26', 20, 'Studio A'),
(13, 'HIIT Challenge', 7, '2023-10-27', 18, 'Gym Room'),
(14, 'Latin Dance Fitness', 8, '2023-10-28', 25, 'Studio C'),
(15, 'Nutrition Workshop', 10, '2023-11-29', 30, 'Conference Room'),
(16, 'Functional Training', 12, '2023-11-30', 12, 'Outdoor Area'),
(17, 'Boxing Advanced', 9, '2023-12-01', 10, 'Boxing Ring'),
(18, 'Morning HIIT', 7, '2023-12-02', 20, 'Gym Room'),
(19, 'Dance Cardio', 8, '2023-12-03', 25, 'Studio C'),
(20, 'Strength & Balance', 11, '2023-12-04', 15, 'Studio B');

---------------------------------
-- Create Class Enrollments Table --
---------------------------------
CREATE TABLE class_enrollments (
    enrollment_id INT PRIMARY KEY,
    class_id INT,
    member_id INT,
    enrollment_date DATE,
    status VARCHAR(20) CHECK (status IN ('active', 'cancelled', 'completed')),
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO class_enrollments (enrollment_id, class_id, member_id, enrollment_date, status) VALUES
(1, 1, 1, '2022-03-08', 'completed'),
(2, 1, 2, '2022-03-08', 'completed'),
(3, 2, 3, '2022-05-10', 'completed'),
(4, 3, 4, '2022-07-12', 'completed'),
(5, 4, 5, '2022-09-14', 'completed'),
(6, 15, 10, '2023-11-25', 'active'),
(7, 15, 11, '2023-11-26', 'active'),
(8, 16, 12, '2023-11-28', 'active'),
(9, 17, 13, '2023-11-29', 'active'),
(10, 18, 14, '2023-11-30', 'active');

---------------------------------
-- Create Trainer Ratings Table --
---------------------------------
CREATE TABLE trainer_ratings (
    rating_id INT PRIMARY KEY,
    trainer_id INT,
    member_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    feedback TEXT,
    rating_date DATE,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO trainer_ratings (rating_id, trainer_id, member_id, rating, feedback, rating_date) VALUES
(1, 1, 1, 5, 'Excellent yoga instruction', '2022-03-11'),
(2, 2, 3, 4, 'Great energy in CrossFit', '2022-05-13'),
(3, 3, 4, 5, 'Very attentive instructor', '2022-07-15'),
(4, 4, 6, 4, 'Fun Zumba class', '2023-07-24'),
(5, 5, 8, 5, 'Challenging workout', '2023-08-25');

---------------------------------
-- Create Class Attendance Table --
---------------------------------
CREATE TABLE class_attendance (
    attendance_id INT PRIMARY KEY,
    class_id INT,
    member_id INT,
    attendance_date DATE,
    status VARCHAR(20) CHECK (status IN ('present', 'absent', 'late')),
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO class_attendance (attendance_id, class_id, member_id, attendance_date, status) VALUES
(1, 1, 1, '2022-03-10', 'present'),
(2, 1, 2, '2022-03-10', 'present'),
(3, 2, 3, '2022-05-12', 'late'),
(4, 3, 4, '2022-07-14', 'present'),
(5, 4, 5, '2022-09-16', 'absent'),
(6, 15, 10, '2023-11-29', 'present'),
(7, 15, 11, '2023-11-29', 'present'),
(8, 16, 12, '2023-11-30', 'late'),
(9, 17, 13, '2023-12-01', 'present'),
(10, 18, 14, '2023-12-02', 'present');