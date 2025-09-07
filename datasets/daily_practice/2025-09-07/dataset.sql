CREATE DATABASE IF NOT EXISTS daily_practice_20250907_schema;
USE daily_practice_20250907_schema;

-- This table logs the sequence of events for each ride-sharing trip.
CREATE TABLE trip_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    trip_id INT,
    event_timestamp DATETIME(3),
    event_type ENUM('REQUEST', 'ACCEPT', 'PICKUP', 'DROPOFF', 'CANCEL_RIDER', 'CANCEL_DRIVER')
);

INSERT INTO trip_events (trip_id, event_timestamp, event_type) VALUES
-- Trip 101: Standard successful trip
(101, '2023-11-15 10:00:00.000', 'REQUEST'),
(101, '2023-11-15 10:01:00.000', 'ACCEPT'),
(101, '2023-11-15 10:05:00.000', 'PICKUP'),
(101, '2023-11-15 10:15:00.000', 'DROPOFF'),

-- Trip 102: Driver accepts then cancels
(102, '2023-11-15 11:01:00.000', 'REQUEST'),
(102, '2023-11-15 11:02:00.000', 'ACCEPT'),
(102, '2023-11-15 11:04:00.000', 'CANCEL_DRIVER'),

-- Trip 103: Rider cancels before acceptance
(103, '2023-11-15 12:01:00.000', 'REQUEST'),
(103, '2023-11-15 12:02:00.000', 'CANCEL_RIDER'),

-- Trip 104: Another successful trip
(104, '2023-11-16 13:00:00.000', 'REQUEST'),
(104, '2023-11-16 13:01:30.000', 'ACCEPT'),
(104, '2023-11-16 13:08:00.000', 'PICKUP'),
(104, '2023-11-16 13:20:00.000', 'DROPOFF'),

-- Trip 105: Request with no acceptance (timeout)
(105, '2023-11-16 14:00:00.000', 'REQUEST');
