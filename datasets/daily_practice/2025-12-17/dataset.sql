CREATE DATABASE IF NOT EXISTS daily_practice_20251217_schema;
USE daily_practice_20251217_schema;

-- This table logs the scheduled shifts for employees in a retail store.
CREATE TABLE employee_shifts (
    shift_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    shift_start DATETIME,
    shift_end DATETIME,
    role VARCHAR(50)
);

INSERT INTO employee_shifts (employee_id, shift_start, shift_end, role) VALUES
-- Employee 101: Normal schedule (9-5 equivalent), plenty of rest
(101, '2023-12-16 09:00:00', '2023-12-16 17:00:00', 'Cashier'),
(101, '2023-12-17 09:00:00', '2023-12-17 17:00:00', 'Cashier'),

-- Employee 102: The "Clopening" (Closing late, opening early)
(102, '2023-12-16 15:00:00', '2023-12-16 23:30:00', 'Stocker'), -- Ends late
(102, '2023-12-17 05:30:00', '2023-12-17 13:30:00', 'Stocker'), -- Starts early (6 hours rest)

-- Employee 103: Late shift, but starts late next day (Sufficient rest)
(103, '2023-12-16 16:00:00', '2023-12-17 00:30:00', 'Manager'), -- Ends past midnight
(103, '2023-12-17 12:00:00', '2023-12-17 20:00:00', 'Manager'), -- 11.5 hours rest

-- Employee 104: Another "Clopening" case
(104, '2023-12-17 14:00:00', '2023-12-17 22:00:00', 'Cashier'),
(104, '2023-12-18 06:00:00', '2023-12-18 14:00:00', 'Cashier'), -- 8 hours rest

-- Employee 105: Double shift (Back to back - counts as 0 rest, technically insufficient)
(105, '2023-12-17 08:00:00', '2023-12-17 12:00:00', 'Greeter'),
(105, '2023-12-17 12:00:00', '2023-12-17 16:00:00', 'Cashier'); -- 0 hours rest