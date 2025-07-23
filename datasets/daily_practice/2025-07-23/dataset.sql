CREATE DATABASE IF NOT EXISTS daily_practice_20250723_schema;
USE daily_practice_20250723_schema;

CREATE TABLE flight_schedules (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(10),
    airline VARCHAR(50),
    origin_airport CHAR(3),
    destination_airport CHAR(3),
    scheduled_departure DATETIME,
    actual_departure DATETIME,
    scheduled_arrival DATETIME,
    actual_arrival DATETIME,
    status ENUM('On Time', 'Delayed', 'Cancelled')
);

INSERT INTO flight_schedules (flight_number, airline, origin_airport, destination_airport, scheduled_departure, actual_departure, scheduled_arrival, actual_arrival, status) VALUES
('UA123', 'United Airlines', 'JFK', 'LAX', '2023-08-01 08:00:00', '2023-08-01 08:05:00', '2023-08-01 11:30:00', '2023-08-01 11:25:00', 'On Time'),
('AA456', 'American Airlines', 'JFK', 'LAX', '2023-08-01 09:00:00', '2023-08-01 09:45:00', '2023-08-01 12:30:00', '2023-08-01 13:10:00', 'Delayed'),
('DL789', 'Delta Air Lines', 'LAX', 'ORD', '2023-08-01 13:00:00', '2023-08-01 13:00:00', '2023-08-01 19:00:00', '2023-08-01 18:55:00', 'On Time'),
('SW101', 'Southwest Airlines', 'ORD', 'MIA', '2023-08-01 20:00:00', '2023-08-01 20:15:00', '2023-08-01 23:30:00', '2023-08-01 23:45:00', 'Delayed'),
('UA124', 'United Airlines', 'JFK', 'LAX', '2023-08-02 08:00:00', NULL, '2023-08-02 11:30:00', NULL, 'Cancelled'),
('AA457', 'American Airlines', 'JFK', 'ORD', '2023-08-02 09:30:00', '2023-08-02 09:30:00', '2023-08-02 11:30:00', '2023-08-02 11:20:00', 'On Time'),
('DL790', 'Delta Air Lines', 'ORD', 'MIA', '2023-08-02 12:00:00', '2023-08-02 12:05:00', '2023-08-02 15:30:00', '2023-08-02 15:30:00', 'On Time'),
('UA125', 'United Airlines', 'LAX', 'SFO', '2023-08-02 14:00:00', '2023-08-02 14:10:00', '2023-08-02 15:15:00', '2023-08-02 15:25:00', 'Delayed'),
('AA458', 'American Airlines', 'JFK', 'LAX', '2023-08-03 09:00:00', '2023-08-03 09:00:00', '2023-08-03 12:30:00', '2023-08-03 12:30:00', 'On Time'),
('DL791', 'Delta Air Lines', 'LAX', 'ORD', '2023-08-03 13:00:00', '2023-08-03 13:30:00', '2023-08-03 19:00:00', '2023-08-03 19:25:00', 'Delayed'),
('SW102', 'Southwest Airlines', 'ORD', 'MIA', '2023-08-03 20:00:00', NULL, '2023-08-03 23:30:00', NULL, 'Cancelled'),
('UA126', 'United Airlines', 'JFK', 'ORD', '2023-08-04 10:00:00', '2023-08-04 10:05:00', '2023-08-04 12:00:00', '2023-08-04 11:58:00', 'On Time'),
('AA459', 'American Airlines', 'ORD', 'MIA', '2023-08-04 13:00:00', '2023-08-04 13:00:00', '2023-08-04 16:30:00', '2023-08-04 16:25:00', 'On Time'),
('DL792', 'Delta Air Lines', 'JFK', 'SFO', '2023-08-05 11:00:00', '2023-08-05 11:15:00', '2023-08-05 14:30:00', '2023-08-05 14:45:00', 'Delayed'),
('UA127', 'United Airlines', 'SFO', 'JFK', '2023-08-05 16:00:00', '2023-08-05 16:00:00', '2023-08-05 23:59:00', '2023-08-05 23:50:00', 'On Time'),
('AA460', 'American Airlines', 'JFK', 'MIA', '2023-08-06 07:00:00', NULL, '2023-08-06 10:00:00', NULL, 'Cancelled');
