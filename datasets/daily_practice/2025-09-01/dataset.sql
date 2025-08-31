CREATE DATABASE IF NOT EXISTS daily_practice_20250901_schema;
USE daily_practice_20250901_schema;

-- This table logs trips for a ride-sharing service.
CREATE TABLE ride_trips (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_id INT,
    passenger_id INT,
    pickup_zone_id INT,
    dropoff_zone_id INT,
    trip_start_timestamp DATETIME,
    trip_end_timestamp DATETIME,
    distance_km DECIMAL(6, 2),
    fare_amount DECIMAL(10, 2),
    surge_multiplier DECIMAL(4, 2),
    passenger_rating_by_driver INT, -- 1-5
    driver_rating_by_passenger INT  -- 1-5
);

INSERT INTO ride_trips (driver_id, passenger_id, pickup_zone_id, dropoff_zone_id, trip_start_timestamp, trip_end_timestamp, distance_km, fare_amount, surge_multiplier, passenger_rating_by_driver, driver_rating_by_passenger) VALUES
-- Driver 101's sessions
(101, 501, 1, 10, '2023-11-15 08:00:00', '2023-11-15 08:25:00', 5.5, 15.50, 1.0, 5, 5),
(101, 502, 10, 5, '2023-11-15 08:30:00', '2023-11-15 08:50:00', 4.2, 12.00, 1.0, 5, 4),
(101, 503, 5, 1, '2023-11-15 09:00:00', '2023-11-15 09:30:00', 6.0, 18.00, 1.25, 5, 5),
(101, 504, 3, 12, '2023-11-15 14:00:00', '2023-11-15 14:45:00', 12.0, 35.00, 1.5, 4, 5), -- New session after >4h break

-- Driver 102's sessions
(102, 505, 2, 8, '2023-11-15 10:00:00', '2023-11-15 10:20:00', 3.0, 10.00, 1.0, 5, 5),
(102, 506, 8, 2, '2023-11-15 10:25:00', '2023-11-15 10:45:00', 3.2, 10.50, 1.0, 5, 5),
(102, 501, 2, 10, '2023-11-16 08:00:00', '2023-11-16 08:30:00', 5.8, 16.00, 1.0, 5, 4), -- New day, new session

-- Driver 103's trips, including a low-rated trip
(103, 507, 4, 15, '2023-11-15 18:00:00', '2023-11-15 18:35:00', 8.0, 25.00, 1.25, 5, 5),
(103, 508, 15, 4, '2023-11-15 18:45:00', '2023-11-15 19:25:00', 8.5, 26.50, 1.25, 5, 2), -- Low rating from passenger
(103, 509, 4, 15, '2023-11-15 19:35:00', '2023-11-15 20:10:00', 8.1, 25.50, 1.25, 4, 4),

-- Data for location analysis
(104, 510, 20, 25, '2023-11-16 17:00:00', '2023-11-16 17:20:00', 2.5, 20.00, 2.0, 5, 5), -- High surge route
(105, 511, 20, 25, '2023-11-16 17:05:00', '2023-11-16 17:25:00', 2.6, 20.80, 2.0, 5, 5),
(106, 512, 20, 25, '2023-11-16 17:10:00', '2023-11-16 17:30:00', 2.4, 19.20, 2.0, 5, 5),
(101, 513, 1, 10, '2023-11-17 08:00:00', '2023-11-17 08:25:00', 5.5, 16.50, 1.0, 5, 5),
(102, 514, 1, 10, '2023-11-17 08:05:00', '2023-11-17 08:30:00', 5.6, 16.80, 1.0, 5, 5),

-- Passenger 508 (who gave a low rating) never returns
-- Passenger 501's last trip
(102, 501, 10, 2, '2023-11-18 09:00:00', '2023-11-18 09:20:00', 3.1, 10.20, 1.0, 5, 5);
