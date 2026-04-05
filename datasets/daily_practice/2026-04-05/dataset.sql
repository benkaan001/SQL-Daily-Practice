CREATE DATABASE IF NOT EXISTS daily_practice_20260405_schema;
USE daily_practice_20260405_schema;

-- This table logs hotel room bookings.
CREATE TABLE hotel_bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(50),
    room_rate DECIMAL(10, 2), -- The price per night
    check_in_date DATE,
    check_out_date DATE
);

INSERT INTO hotel_bookings (guest_name, room_rate, check_in_date, check_out_date) VALUES
-- Alice stays entirely within March (5 nights)
('Alice', 100.00, '2026-03-15', '2026-03-20'), 

-- Bob's stay bridges March and April (3 nights in Mar, 2 nights in Apr)
('Bob', 150.00, '2026-03-29', '2026-04-03'), 

-- Charlie stays entirely within April (5 nights)
('Charlie', 200.00, '2026-04-10', '2026-04-15'), 

-- Diana's stay bridges April and May (3 nights in Apr, 1 night in May)
('Diana', 120.00, '2026-04-28', '2026-05-02'), 

-- Evan stays for over a month (2 nights in Mar, 30 nights in Apr, 2 nights in May)
('Evan', 80.00, '2026-03-30', '2026-05-03');