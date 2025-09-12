CREATE DATABASE IF NOT EXISTS daily_practice_20250912_schema;
USE daily_practice_20250912_schema;

-- This table logs hotel room bookings, including their status.
CREATE TABLE hotel_bookings (
    booking_id INT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in_date DATE,
    check_out_date DATE,
    booking_timestamp DATETIME(3),
    status ENUM('CONFIRMED', 'CANCELLED')
);

INSERT INTO hotel_bookings (booking_id, guest_id, room_id, check_in_date, check_out_date, booking_timestamp, status) VALUES
-- Scenario 1: The resolved overbooking
(101, 501, 101, '2024-01-10', '2024-01-15', '2023-11-01 10:00:00.000', 'CONFIRMED'), -- The existing, firm booking.
(102, 502, 101, '2024-01-12', '2024-01-17', '2023-11-05 11:00:00.000', 'CANCELLED'), -- The conflicting booking that gets cancelled.
(103, 502, 102, '2024-01-12', '2024-01-17', '2023-11-05 11:05:00.000', 'CONFIRMED'), -- The guest is re-booked into a new room.

-- Standard bookings, no conflict
(104, 503, 201, '2024-02-01', '2024-02-05', '2023-11-10 14:00:00.000', 'CONFIRMED'),
(105, 504, 202, '2024-02-01', '2024-02-05', '2023-11-11 15:00:00.000', 'CONFIRMED'),

-- Scenario 2: A different resolved overbooking
(106, 505, 301, '2024-03-20', '2024-03-25', '2023-12-01 09:00:00.000', 'CONFIRMED'),
(107, 506, 301, '2024-03-22', '2024-03-28', '2023-12-05 16:00:00.000', 'CANCELLED'),
(108, 506, 302, '2024-03-22', '2024-03-28', '2023-12-05 16:10:00.000', 'CONFIRMED'),

-- Scenario 3: An unresolved conflict (one booking is just cancelled, not re-booked)
(109, 507, 401, '2024-04-10', '2024-04-15', '2024-01-15 10:00:00.000', 'CONFIRMED'),
(110, 508, 401, '2024-04-12', '2024-04-17', '2024-01-20 11:00:00.000', 'CANCELLED'),

-- Scenario 4: A conflict where the re-booking is for different dates (should be excluded)
(111, 509, 501, '2024-05-01', '2024-05-05', '2024-02-01 08:00:00.000', 'CONFIRMED'),
(112, 510, 501, '2024-05-03', '2024-05-08', '2024-02-10 13:00:00.000', 'CANCELLED'),
(113, 510, 502, '2024-05-10', '2024-05-15', '2024-02-10 13:05:00.000', 'CONFIRMED'); -- Different dates
