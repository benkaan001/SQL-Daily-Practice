CREATE DATABASE IF NOT EXISTS daily_practice_20260304_schema;
USE daily_practice_20260304_schema;

-- This table stores meeting room bookings for the day.
-- Assume the booking application prevents overlapping meetings within the same room.
CREATE TABLE room_bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    room_name VARCHAR(50),
    start_time DATETIME,
    end_time DATETIME
);

INSERT INTO room_bookings (room_name, start_time, end_time) VALUES
-- Boardroom A: Multiple meetings with varying gaps. 
-- Gap before 09:00 (1h), gap between 10:30-11:00 (30m, too small), gap 12:00-14:00 (2h), gap 15:30-17:30 (2h)
('Boardroom A', '2026-03-04 09:00:00', '2026-03-04 10:30:00'),
('Boardroom A', '2026-03-04 11:00:00', '2026-03-04 12:00:00'),
('Boardroom A', '2026-03-04 14:00:00', '2026-03-04 15:30:00'),
('Boardroom A', '2026-03-04 17:30:00', '2026-03-04 18:00:00'),

-- Strategy Room: Booked back-to-back most of the day.
-- Starts exactly at 08:00. Gap 12:00-12:30 (30m, too small). Free from 17:00 to end of day.
('Strategy Room', '2026-03-04 08:00:00', '2026-03-04 12:00:00'),
('Strategy Room', '2026-03-04 12:30:00', '2026-03-04 17:00:00'),

-- Innovation Lab: Only small gaps in the morning, free all evening.
('Innovation Lab', '2026-03-04 08:30:00', '2026-03-04 09:00:00'),
('Innovation Lab', '2026-03-04 09:30:00', '2026-03-04 16:30:00'),

-- Quiet Room: Barely used. Free all morning until 10:00, then free all afternoon.
('Quiet Room', '2026-03-04 10:00:00', '2026-03-04 11:00:00');