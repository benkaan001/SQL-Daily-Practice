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


-- Update members table
INSERT INTO members (member_id, member_name, join_date, membership_type) VALUES
(26, 'Jane Doe', '2022-01-15', 'Gold'),
(27, 'Peter Jones', '2022-02-20', 'Silver'),
(28, 'Susan Williams', '2022-03-05', 'Gold'),
(29, 'Karen Brown', '2023-01-30', 'Platinum'),
(30, 'Tom Davis', '2023-02-05', 'Silver'),
(31, 'Lisa Green', '2023-03-10', 'Gold'),
(32, 'Mike Smith', '2023-04-15', NULL),
(33, 'Amy White', '2023-05-20', 'Platinum');

-- Update trainers table
INSERT INTO trainers (trainer_id, trainer_name, specialty, hire_date) VALUES
(13, 'John Smith', 'Yoga', '2024-01-10'),
(14, 'Emily Jones', 'CrossFit', '2024-02-15');

-- Update classes table
INSERT INTO classes (class_id, class_name, trainer_id, schedule_date, capacity, location) VALUES
(21, 'Power Yoga', 1, '2023-11-29', 20, 'Studio A'),
(22, 'Morning CrossFit', 2, '2023-12-01', 15, 'Gym Room'),
(23, 'Yoga Flow', 1, '2023-12-05', 20, 'Studio A'),
(24, 'Advanced CrossFit', 2, '2023-12-10', 15, 'Gym Room'),
(25, 'Zumba Mania', 4, '2023-12-12', 25, 'Studio C'),
(26, 'HIIT Express', 7, '2023-12-15', 18, 'Gym Room'),
(27, 'Boxing Workout', 9, '2023-12-18', 15, 'Boxing Ring'),
(28, 'Senior Yoga', 11, '2023-12-20', 20, 'Studio A');

-- Update class_enrollments table
INSERT INTO class_enrollments (enrollment_id, class_id, member_id, enrollment_date, status) VALUES
(11, 17, 13, '2023-11-29', 'active'),
(12, 17, 1, '2023-11-29', 'active'),
(13, 17, 2, '2023-11-29', 'active'),
(14, 17, 3, '2023-11-29', 'active'),
(15, 17, 5, '2023-11-29', 'active'),
(16, 17, 10, '2023-11-29', 'active'),
(17, 17, 11, '2023-11-29', 'active'),
(18, 17, 12, '2023-11-29', 'active'),
(19, 17, 14, '2023-11-29', 'active'),
(20, 13, 1, '2023-10-27', 'completed'),
(21, 13, 2, '2023-10-27', 'completed'),
(22, 13, 3, '2023-10-27', 'completed'),
(23, 13, 4, '2023-10-27', 'completed'),
(24, 13, 6, '2023-10-27', 'completed'),
(25, 13, 7, '2023-10-27', 'completed'),
(26, 13, 8, '2023-10-27', 'completed'),
(27, 13, 9, '2023-10-27', 'completed'),
(28, 16, 1, '2023-11-30', 'active'),
(29, 16, 2, '2023-11-30', 'active'),
(30, 16, 3, '2023-11-30', 'active'),
(31, 16, 4, '2023-11-30', 'active'),
(32, 16, 5, '2023-11-30', 'active'),
(33, 16, 6, '2023-11-30', 'active'),
(34, 16, 7, '2023-11-30', 'active'),
(35, 16, 15, '2023-11-30', 'active'),
(36, 18, 1, '2023-12-02', 'active'),
(37, 18, 2, '2023-12-02', 'active'),
(38, 18, 14, '2023-12-02', 'active'),
(39, 18, 16, '2023-12-02', 'active'),
(40, 18, 17, '2023-12-02', 'active'),
(41, 18, 18, '2023-12-02', 'active'),
(42, 18, 19, '2023-12-02', 'active'),
(43, 18, 20, '2023-12-02', 'active'),
(44, 18, 21, '2023-12-02', 'active'),
(45, 18, 22, '2023-12-02', 'active'),
(46, 21, 1, '2023-11-29', 'active'),
(47, 21, 14, '2023-11-29', 'active'),
(48, 21, 17, '2023-11-29', 'active'),
(49, 21, 19, '2023-11-29', 'active'),
(50, 21, 21, '2023-11-29', 'active'),
(51, 6, 1, '2023-01-20', 'completed'),
(52, 6, 2, '2023-01-20', 'completed'),
(53, 6, 3, '2023-01-20', 'completed'),
(54, 4, 1, '2022-09-16', 'completed'),
(55, 4, 3, '2022-09-16', 'completed');

-- Update trainer_ratings table
INSERT INTO trainer_ratings (rating_id, trainer_id, member_id, rating, feedback, rating_date) VALUES
(6, 1, 2, 5, 'Another great class!', '2022-03-12'),
(7, 2, 1, 5, 'Very motivating!', '2022-05-14'),
(8, 1, 3, 4, 'Good adjustments.', '2022-09-17'),
(9, 2, 5, 4, 'Intense session.', '2022-11-19'),
(10, 3, 1, 5, 'Excellent focus on form.', '2023-05-23'),
(11, 1, 5, 5, 'Really enjoyed the flow.', '2023-01-21'),
(12, 2, 7, 5, 'Pushed me to my limit!', '2023-03-22'),
(13, 4, 1, 4, 'Fun and energetic.', '2023-07-24'),
(14, 5, 3, 5, 'Great for building strength.', '2023-08-26'),
(15, 7, 1, 4, 'Effective workout.', '2023-10-28'),
(16, 9, 5, 5, 'Learned a lot about technique.', '2023-09-26'),
(17, 11, 7, 4, 'Good for older adults.', '2023-09-27'),
(18, 7, 3, 5, 'Felt the burn!', '2023-12-01'),
(19, 8, 1, 4, 'Enjoyable dance moves.', '2023-10-29'),
(20, 10, 5, 5, 'Very informative session.', '2023-11-30'),
(21, 12, 7, 4, 'Challenging and rewarding.', '2023-12-02'),
(22, 9, 1, 5, 'Excellent instruction.', '2023-12-02'),
(23, 1, 10, 5, 'Relaxing and effective.', '2024-01-22'),
(24, 2, 11, 4, 'Good workout.', '2024-03-22');

-- Update class_attendance table
INSERT INTO class_attendance (attendance_id, class_id, member_id, attendance_date, status) VALUES
(11, 1, 1, '2022-03-10', 'present'),
(12, 1, 2, '2022-03-10', 'present'),
(13, 1, 3, '2022-03-10', 'present'),
(14, 2, 1, '2022-05-12', 'present'),
(15, 2, 3, '2022-05-12', 'late'),
(16, 2, 4, '2022-05-12', 'absent'),
(17, 3, 1, '2022-07-14', 'present'),
(18, 3, 4, '2022-07-14', 'present'),
(19, 3, 5, '2022-07-14', 'present'),
(20, 4, 1, '2022-09-16', 'present'),
(21, 4, 5, '2022-09-16', 'absent'),
(22, 4, 6, '2022-09-16', 'present'),
(23, 6, 1, '2023-01-20', 'present'),
(24, 6, 2, '2023-01-20', 'present'),
(25, 6, 7, '2023-01-20', 'present'),
(26, 7, 1, '2023-03-21', 'present'),
(27, 7, 2, '2023-03-21', 'present'),
(28, 7, 8, '2023-03-21', 'present'),
(29, 8, 1, '2023-05-22', 'present'),
(30, 8, 3, '2023-05-22', 'present'),
(31, 8, 9, '2023-05-22', 'present'),
(32, 9, 1, '2023-07-23', 'present'),
(33, 9, 4, '2023-07-23', 'present'),
(34, 9, 10, '2023-07-23', 'present'),
(35, 10, 1, '2023-08-24', 'present'),
(36, 10, 5, '2023-08-24', 'present'),
(37, 10, 11, '2023-08-24', 'present'),
(38, 11, 1, '2023-09-25', 'present'),
(39, 11, 6, '2023-09-25', 'present'),
(40, 11, 12, '2023-09-25', 'present'),
(41, 12, 1, '2023-09-26', 'present'),
(42, 12, 7, '2023-09-26', 'present'),
(43, 12, 13, '2023-09-26', 'present'),
(44, 13, 1, '2023-10-27', 'present'),
(45, 13, 8, '2023-10-27', 'present'),
(46, 13, 14, '2023-10-27', 'present'),
(47, 14, 1, '2023-10-28', 'present'),
(48, 14, 9, '2023-10-28', 'present'),
(49, 14, 15, '2023-10-28', 'present'),
(50, 15, 1, '2023-11-29', 'present'),
(51, 15, 10, '2023-11-29', 'present'),
(52, 15, 16, '2023-11-29', 'present'),
(53, 16, 1, '2023-11-30', 'present'),
(54, 16, 12, '2023-11-30', 'late'),
(55, 16, 17, '2023-11-30', 'present'),
(56, 17, 1, '2023-12-01', 'present'),
(57, 17, 13, '2023-12-01', 'present'),
(58, 17, 18, '2023-12-01', 'present'),
(59, 18, 1, '2023-12-02', 'present'),
(60, 18, 14, '2023-12-02', 'present'),
(61, 18, 19, '2023-12-02', 'present'),
(62, 19, 1, '2023-12-03', 'present'),
(63, 19, 15, '2023-12-03', 'present'),
(64, 19, 20, '2023-12-03', 'present'),
(65, 20, 1, '2023-12-04', 'present'),
(66, 20, 16, '2023-12-04', 'present'),
(67, 20, 21, '2023-12-04', 'present'),
(68, 21, 1, '2023-11-29', 'present'),
(69, 21, 14, '2023-11-29', 'present'),
(70, 21, 17, '2023-11-29', 'present'),
(71, 22, 1, '2023-12-01', 'present'),
(72, 22, 11, '2023-12-01', 'present'),
(73, 23, 1, '2023-12-05', 'present'),
(74, 23, 3, '2023-12-05', 'present'),
(75, 24, 1, '2023-12-10', 'present'),
(76, 24, 5, '2023-12-10', 'present'),
(77, 25, 1, '2023-12-12', 'present'),
(78, 25, 10, '2023-12-12', 'present'),
(79, 26, 1, '2023-12-15', 'present'),
(80, 26, 8, '2023-12-15', 'present'),
(81, 27, 1, '2023-12-18', 'present'),
(82, 27, 6, '2023-12-18', 'present'),
(83, 28, 1, '2023-12-20', 'present'),
(84, 28, 7, '2023-12-20', 'present'),
(85, 1, 1, '2022-03-10', 'present'),
(86, 1, 1, '2022-03-10', 'present'),
(87, 2, 1, '2022-05-12', 'present');