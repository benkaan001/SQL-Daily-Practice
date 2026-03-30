CREATE DATABASE IF NOT EXISTS daily_practice_20260330_schema;
USE daily_practice_20260330_schema;

-- This table represents the seating chart for a movie theater.
CREATE TABLE cinema_seats (
    row_letter CHAR(1),
    seat_number INT,
    status ENUM('AVAILABLE', 'BOOKED'),
    PRIMARY KEY (row_letter, seat_number)
);

INSERT INTO cinema_seats (row_letter, seat_number, status) VALUES
-- Row A: A block of 3 available seats perfectly in the middle
('A', 1, 'BOOKED'),
('A', 2, 'AVAILABLE'),
('A', 3, 'AVAILABLE'),
('A', 4, 'AVAILABLE'),
('A', 5, 'BOOKED'),

-- Row B: An isolated block of 2, then a block of 3
('B', 1, 'AVAILABLE'),
('B', 2, 'AVAILABLE'),
('B', 3, 'BOOKED'),
('B', 4, 'AVAILABLE'),
('B', 5, 'AVAILABLE'),
('B', 6, 'AVAILABLE'),

-- Row C: Barely any availability, no blocks of 3
('C', 1, 'BOOKED'),
('C', 2, 'BOOKED'),
('C', 3, 'AVAILABLE'),
('C', 4, 'AVAILABLE'),

-- Row D: A block of 4, followed by a booked seat, followed by a block of 3
('D', 1, 'AVAILABLE'),
('D', 2, 'AVAILABLE'),
('D', 3, 'AVAILABLE'),
('D', 4, 'AVAILABLE'),
('D', 5, 'BOOKED'),
('D', 6, 'AVAILABLE'),
('D', 7, 'AVAILABLE'),
('D', 8, 'AVAILABLE');