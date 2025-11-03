CREATE DATABASE IF NOT EXISTS daily_practice_20251103_schema;
USE daily_practice_20251103_schema;

-- This table logs all changes to hotel room reservations.
-- A single booking_id can have multiple event types, such as 'CREATED', 'MODIFIED', or 'CANCELLED'.
-- The check_in_date/check_out_date recorded in the 'CREATED' event is the original booking.
CREATE TABLE booking_updates (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    room_id INT,
    guest_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('CREATED', 'MODIFIED', 'CANCELLED'),
    -- Dates are only populated for CREATED or MODIFIED events
    check_in_date DATE,
    check_out_date DATE
);

INSERT INTO booking_updates (booking_id, room_id, guest_id, event_timestamp, event_type, check_in_date, check_out_date) VALUES
-- Booking 101: Cancelled, but room was successfully re-booked
(101, 10, 501, '2023-11-20 10:00:00.000', 'CREATED', '2023-12-20', '2023-12-22'),
(101, 10, 501, '2023-11-25 14:00:00.000', 'CANCELLED', NULL, NULL),

-- Booking 102: The re-booking for Room 10, starts same day
(102, 10, 502, '2023-11-26 11:00:00.000', 'CREATED', '2023-12-20', '2023-12-21'),

-- Booking 103: Cancelled, room was not re-booked in time
(103, 20, 503, '2023-11-22 09:00:00.000', 'CREATED', '2023-12-15', '2023-12-18'),
(103, 20, 503, '2023-11-28 10:00:00.000', 'CANCELLED', NULL, NULL),

-- Booking 104: A successful booking that was not cancelled
(104, 30, 504, '2023-11-23 13:00:00.000', 'CREATED', '2023-12-25', '2023-12-28'),

-- Booking 105: Modified, then cancelled (room not re-booked)
(105, 40, 505, '2023-11-24 16:00:00.000', 'CREATED', '2024-01-10', '2024-01-15'),
(105, 40, 505, '2023-11-25 17:00:00.000', 'MODIFIED', '2024-01-10', '2024-01-17'),
(105, 40, 505, '2023-11-30 09:00:00.000', 'CANCELLED', NULL, NULL),

-- Booking 106: Re-booking for Room 20, but starts > 24h after 103's original start
(106, 20, 506, '2023-11-29 12:00:00.000', 'CREATED', '2023-12-16', '2023-12-17'), -- B-103 started 12-15, this is 24h later

-- Booking 107: Another re-booking for Room 20, but starts 2 days after 103's original start
(107, 20, 507, '2023-11-30 15:00:00.000', 'CREATED', '2023-12-17', '2023-12-19');
