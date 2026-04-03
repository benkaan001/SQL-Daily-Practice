CREATE DATABASE IF NOT EXISTS daily_practice_20260403_schema;
USE daily_practice_20260403_schema;

-- This table stores the dynamic nightly price for each room type.
-- Prices fluctuate based on weekends, holidays, or demand.
CREATE TABLE room_rates (
    room_type VARCHAR(50),
    rate_date DATE,
    nightly_rate DECIMAL(10, 2),
    PRIMARY KEY (room_type, rate_date)
);

-- This table logs guest reservations.
CREATE TABLE reservations (
    res_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(50),
    room_type VARCHAR(50),
    check_in DATE,
    check_out DATE
);

INSERT INTO room_rates (room_type, rate_date, nightly_rate) VALUES
-- 'Standard' Room Rates for early April 
-- (Notice the weekend spike on April 4th and 5th)
('Standard', '2026-04-01', 100.00),
('Standard', '2026-04-02', 100.00),
('Standard', '2026-04-03', 100.00),
('Standard', '2026-04-04', 150.00), -- Weekend
('Standard', '2026-04-05', 150.00), -- Weekend
('Standard', '2026-04-06', 100.00),
('Standard', '2026-04-07', 100.00),
('Standard', '2026-04-08', 100.00),

-- 'Suite' Room Rates for early April
('Suite', '2026-04-01', 250.00),
('Suite', '2026-04-02', 250.00),
('Suite', '2026-04-03', 250.00),
('Suite', '2026-04-04', 350.00), -- Weekend
('Suite', '2026-04-05', 350.00), -- Weekend
('Suite', '2026-04-06', 250.00),
('Suite', '2026-04-07', 250.00),
('Suite', '2026-04-08', 250.00);

INSERT INTO reservations (guest_name, room_type, check_in, check_out) VALUES
-- Reservation 1: Stays during the cheap weekdays (Nights of Apr 2, Apr 3) -> 100 + 100 = $200
('Alice Smith', 'Standard', '2026-04-02', '2026-04-04'),

-- Reservation 2: Crosses over into the expensive weekend (Nights of Apr 3, Apr 4, Apr 5) -> 100 + 150 + 150 = $400
('Bob Johnson', 'Standard', '2026-04-03', '2026-04-06'),

-- Reservation 3: A short one-night weekend stay (Night of Apr 4) -> $350
('Charlie Davis', 'Suite', '2026-04-04', '2026-04-05'),

-- Reservation 4: A full week stay spanning multiple rate changes
('Diana Prince', 'Suite', '2026-04-01', '2026-04-08');