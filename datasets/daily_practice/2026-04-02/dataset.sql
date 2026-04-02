CREATE DATABASE IF NOT EXISTS daily_practice_20260402_schema;
USE daily_practice_20260402_schema;

-- This table logs the scheduled and actual times for commercial flights.
CREATE TABLE flight_operations (
    flight_id INT PRIMARY KEY,
    tail_number VARCHAR(10),
    scheduled_departure DATETIME,
    actual_departure DATETIME,
    scheduled_arrival DATETIME,
    actual_arrival DATETIME
);

INSERT INTO flight_operations (flight_id, tail_number, scheduled_departure, actual_departure, scheduled_arrival, actual_arrival) VALUES
-- Plane N111A: Flight 2 arrives late, causing Flight 3 to depart late (Cascading Delay)
(1, 'N111A', '2026-04-02 08:00:00', '2026-04-02 08:00:00', '2026-04-02 10:00:00', '2026-04-02 10:00:00'),
(2, 'N111A', '2026-04-02 11:00:00', '2026-04-02 11:00:00', '2026-04-02 13:00:00', '2026-04-02 13:45:00'), -- Arrives 45m late
(3, 'N111A', '2026-04-02 14:00:00', '2026-04-02 14:30:00', '2026-04-02 16:00:00', '2026-04-02 16:30:00'), -- Departs 30m late because turnaround was squeezed
(4, 'N111A', '2026-04-02 18:00:00', '2026-04-02 18:05:00', '2026-04-02 20:00:00', '2026-04-02 20:05:00'),

-- Plane N222B: Flight 5 arrives late, but a long layover prevents Flight 6 from being delayed by it (Independent Delay)
(5, 'N222B', '2026-04-02 09:00:00', '2026-04-02 09:20:00', '2026-04-02 11:00:00', '2026-04-02 11:20:00'), -- Arrives 20m late
(6, 'N222B', '2026-04-02 14:00:00', '2026-04-02 14:30:00', '2026-04-02 16:00:00', '2026-04-02 16:30:00'), -- Departs 30m late, but NOT due to turnaround

-- Plane N333C: Flight 7 arrives severely late, directly impacting Flight 8
(7, 'N333C', '2026-04-02 10:00:00', '2026-04-02 10:00:00', '2026-04-02 12:00:00', '2026-04-02 13:00:00'), -- Arrives 60m late
(8, 'N333C', '2026-04-02 13:15:00', '2026-04-02 13:45:00', '2026-04-02 15:15:00', '2026-04-02 15:45:00'), -- Departs 30m late

-- Plane N444D: First flight of the day is delayed (No previous flight to blame)
(9, 'N444D', '2026-04-02 07:00:00', '2026-04-02 07:45:00', '2026-04-02 09:00:00', '2026-04-02 09:45:00');