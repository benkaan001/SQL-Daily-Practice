CREATE DATABASE IF NOT EXISTS daily_practice_20260406_schema;
USE daily_practice_20260406_schema;

-- This table stores the physical rooms in the hotel.
CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(50),
    nightly_rate DECIMAL(10, 2)
);

-- This table logs all past, present, and future reservations.
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT,
    guest_name VARCHAR(50),
    check_in_date DATE,
    check_out_date DATE
);

INSERT INTO rooms (room_id, room_type, nightly_rate) VALUES
(101, 'Standard', 100.00),
(102, 'Standard', 100.00),
(103, 'Deluxe', 150.00),
(104, 'Suite', 250.00),
(105, 'Suite', 250.00);

INSERT INTO reservations (room_id, guest_name, check_in_date, check_out_date) VALUES
-- Room 101: Available! Checks out right before, checks in right after.
(101, 'Alice', '2026-04-10', '2026-04-15'),
(101, 'Bob', '2026-04-18', '2026-04-22'),

-- Room 102: Unavailable! Existing reservation overlaps the start date.
(102, 'Charlie', '2026-04-12', '2026-04-16'),

-- Room 103: Unavailable! Existing reservation is entirely within the search window.
(103, 'Diana', '2026-04-16', '2026-04-17'),

-- Room 104: Unavailable! Existing reservation completely surrounds the search window.
(104, 'Evan', '2026-04-14', '2026-04-20');

-- Room 105 has no reservations on record (Always Available).