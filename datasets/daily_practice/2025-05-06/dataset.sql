CREATE DATABASE IF NOT EXISTS daily_practice_20250506_schema;
USE daily_practice_20250506_schema;


CREATE TABLE rides (
    ride_id INT,
    start_date DATETIME,
    end_date DATETIME,
    category VARCHAR(20),
    start VARCHAR(50),
    stop VARCHAR(50),
    miles FLOAT,
    purpose VARCHAR(50)
);

INSERT INTO rides VALUES
(1, '2022-01-01 08:00:00', '2022-01-01 08:30:00', 'Business', 'Downtown', 'Airport', 12.5, 'Airport/Travel'),
(2, '2022-01-01 09:00:00', '2022-01-01 09:20:00', 'Business', 'Downtown', 'Office', 5.2, 'Meeting'),
(3, '2022-01-01 10:00:00', '2022-01-01 10:15:00', 'Business', 'Office', 'Cafe', 3.1, 'Meal/Entertain'),
(4, '2022-01-02 08:00:00', '2022-01-02 08:45:00', 'Business', 'Home', 'Client Site', 18.7, 'Customer Visit'),
(5, '2022-01-02 09:30:00', '2022-01-02 09:50:00', 'Business', 'Client Site', 'Office', 7.4, 'Meeting'),
(6, '2022-01-03 11:00:00', '2022-01-03 11:20:00', 'Business', 'Office', 'Downtown', 5.2, 'Errand/Supplies'),
(7, '2022-01-03 12:00:00', '2022-01-03 12:30:00', 'Business', 'Downtown', 'Home', 12.5, 'Meal/Entertain'),
(8, '2022-01-04 08:00:00', '2022-01-04 08:40:00', 'Business', 'Home', 'Airport', 15.0, 'Airport/Travel'),
(9, '2022-01-04 09:00:00', '2022-01-04 09:25:00', 'Business', 'Airport', 'Office', 10.0, 'Meeting'),
(10, '2022-01-05 10:00:00', '2022-01-05 10:30:00', 'Business', 'Office', 'Client Site', 8.5, 'Customer Visit'),
(11, '2022-01-05 11:00:00', '2022-01-05 11:20:00', 'Business', 'Client Site', 'Cafe', 4.0, 'Meal/Entertain'),
(12, '2022-01-06 08:00:00', '2022-01-06 08:30:00', 'Business', 'Cafe', 'Office', 3.1, 'Errand/Supplies'),
(13, '2022-01-06 09:00:00', '2022-01-06 09:40:00', 'Business', 'Office', 'Home', 12.5, 'Meal/Entertain'),
(14, '2022-01-07 08:00:00', '2022-01-07 08:50:00', 'Business', 'Home', 'Airport', 15.0, 'Airport/Travel'),
(15, '2022-01-07 09:00:00', '2022-01-07 09:30:00', 'Business', 'Airport', 'Client Site', 20.0, 'Customer Visit');