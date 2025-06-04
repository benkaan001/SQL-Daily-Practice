
CREATE SCHEMA IF NOT EXISTS gym_20250604;
USE gym_20250604;

--------------------------
-- Create Members Table --
--------------------------
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100),
    join_date DATE,
    membership_type VARCHAR(20)
);

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

--------------------------
-- Create Trainers Table --
--------------------------
CREATE TABLE trainers (
    trainer_id INT PRIMARY KEY,
    trainer_name VARCHAR(100),
    hire_date DATE,
    specialty VARCHAR(50)
);

INSERT INTO trainers (trainer_id, trainer_name, hire_date, specialty) VALUES
(1, 'John Doe', '2021-05-15', 'Strength Training'),
(2, 'Jane Smith', '2021-06-20', 'Cardio'),
(3, 'Emily Johnson', '2021-07-10', 'Yoga'),
(4, 'Michael Brown', '2021-08-25', 'Pilates'),
(5, 'Mary Davis', '2021-09-30', 'Nutrition'),
(6, 'James Wilson', '2021-10-15', 'Weight Loss'),
(7, 'Patricia Garcia', '2021-11-20', 'Bodybuilding'),
(8, 'Robert Martinez', '2021-12-05', 'Kickboxing'),
(9, 'Linda Hernandez', '2022-01-10', 'Zumba'),
(10, 'William Clark', '2022-02-14', 'CrossFit');

--------------------------
-- Create Classes Table --
--------------------------
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(100),
    schedule_time TIME,
    duration_minutes INT,
    intensity_level VARCHAR(20)
);

INSERT INTO classes (class_id, class_name, schedule_time, duration_minutes, intensity_level) VALUES
(1, 'Morning Yoga', '07:00:00', 60, 'Low'),
(2, 'Pilates Basics', '08:30:00', 45, 'Medium'),
(3, 'Cardio Blast', '09:30:00', 30, 'High'),
(4, 'Strength Training 101', '10:30:00', 60, 'High'),
(5, 'Nutrition Workshop', '12:00:00', 90, 'Medium'),
(6, 'Evening Zumba', '18:00:00', 60, 'Low'),
(7, 'Kickboxing Fundamentals', '19:30:00', 45, 'High'),
(8, 'Advanced CrossFit', '20:30:00', 60, 'Very High');

--------------------------
-- Create Class Enrollments Table --
--------------------------
CREATE TABLE class_enrollments (
    enrollment_id INT PRIMARY KEY,
    member_id INT,
    class_id INT,
    enrollment_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

INSERT INTO class_enrollments (enrollment_id, member_id, class_id, enrollment_date) VALUES
(1, 1, 1, '2022-01-10'),
(2, 2, 2, '2022-02-15'),
(3, 3, 3, '2022-02-28'),
(4, 4, 4, '2022-01-25'),
(5, 5, 5, '2022-03-01'),
(6, 6, 6, '2022-06-05'),
(7, 7, 7, '2022-08-10'),
(8, 8, 8, '2022-10-15'),
(9, 9, 1, '2022-12-20'),
(10, 10, 2, '2023-01-25'),
(11, 11, 3, '2023-02-28'),
(12, 12, 4, '2023-03-01'),
(13, 13, 5, '2023-04-05'),
(14, 14, 6, '2023-06-10'),
(15, 15, 7, '2023-07-15'),
(16, 16, 8, '2023-08-20'),
(17, 17, 1, '2023-09-25'),
(18, 18, 2, '2023-10-01'),
(19, 19, 3, '2023-11-05'),
(20, 20, 4, '2023-11-10'),
(21, 21, 5, '2023-11-15'),
(22, 22, 6, '2023-11-20'),
(23, 23, 7, '2023-12-01'),
(24, 24, 8, '2023-12-15'),
(25, 25, 1, '2023-12-31');

--------------------------
-- Create Trainer Ratings Table --
--------------------------
CREATE TABLE trainer_ratings (
    rating_id INT PRIMARY KEY,
    trainer_id INT,
    member_id INT,
    rating INT,
    comments VARCHAR(255),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO trainer_ratings (rating_id, trainer_id, member_id, rating, comments) VALUES
(1, 1, 1, 5, 'Excellent trainer, very knowledgeable.'),
(2, 2, 2, 4, 'Great class, but could be more challenging.'),
(3, 3, 3, 5, 'Loved the yoga class, very relaxing.'),
(4, 4, 4, 3, 'Pilates was good, but not what I expected.'),
(5, 5, 5, 4, 'Nutrition advice was helpful, thanks!'),
(6, 6, 6, 5, 'Lost 5 pounds in a month, highly recommend!'),
(7, 7, 7, 4, 'Bodybuilding tips were useful, saw results.'),
(8, 8, 8, 5, 'Kickboxing was intense, but fun!'),
(9, 9, 1, 4, 'Zumba class was enjoyable, nice music.'),
(10, 10, 2, 5, 'CrossFit is challenging but rewarding.');

--------------------------
-- Create Class Attendance Table --
--------------------------
CREATE TABLE class_attendance (
    attendance_id INT PRIMARY KEY,
    class_id INT,
    attendance_date DATE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

INSERT INTO class_attendance (attendance_id, class_id, attendance_date) VALUES
(1, 1, '2022-01-10'),
(2, 2, '2022-02-15'),
(3, 3, '2022-02-28'),
(4, 4, '2022-01-25'),
(5, 5, '2022-03-01'),
(6, 6, '2022-06-05'),
(7, 7, '2022-08-10'),
(8, 8, '2022-10-15'),
(9, 1, '2022-12-20'),
(10, 2, '2023-01-25'),
(11, 3, '2023-02-28'),
(12, 4, '2023-03-01'),
(13, 5, '2023-04-05'),
(14, 6, '2023-06-10'),
(15, 7, '2023-07-15'),
(16, 8, '2023-08-20'),
(17, 1, '2023-09-25'),
(18, 2, '2023-10-01'),
(19, 3, '2023-11-05'),
(20, 4, '2023-11-10'),
(21, 5, '2023-11-15'),
(22, 6, '2023-11-20'),
(23, 7, '2023-12-01'),
(24, 8, '2023-12-15'),
(25, 1, '2023-12-31');
