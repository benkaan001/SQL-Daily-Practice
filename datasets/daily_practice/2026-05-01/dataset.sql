CREATE DATABASE IF NOT EXISTS daily_practice_20260501_schema;
USE daily_practice_20260501_schema;

-- This table stores employee base pay rates.
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    hourly_rate DECIMAL(10, 2)
);

-- This table logs the daily hours worked by each employee.
CREATE TABLE timesheets (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    shift_date DATE,
    hours_worked DECIMAL(4, 2)
);

-- This table holds officially recognized company holidays.
CREATE TABLE public_holidays (
    holiday_date DATE PRIMARY KEY,
    holiday_name VARCHAR(50)
);

INSERT INTO employees (emp_id, emp_name, hourly_rate) VALUES
(101, 'Alice', 30.00),
(102, 'Bob', 25.00),
(103, 'Charlie', 20.00);

INSERT INTO public_holidays (holiday_date, holiday_name) VALUES
('2026-05-01', 'International Workers Day');

INSERT INTO timesheets (emp_id, shift_date, hours_worked) VALUES
-- Alice: Works normal hours, some overtime, and works on the holiday
(101, '2026-04-29', 8.00),
(101, '2026-04-30', 10.50), -- 2.5 hours of Overtime
(101, '2026-05-01', 5.00),  -- Works 5 hours on the holiday

-- Bob: Works a little overtime, and pulls a long shift on the holiday
(102, '2026-04-29', 9.00),  -- 1 hour of Overtime
(102, '2026-05-01', 10.00), -- Works 10 hours on the holiday

-- Charlie: Standard 8-hour shifts, takes the holiday off
(103, '2026-04-28', 8.00),
(103, '2026-04-29', 8.00),
(103, '2026-04-30', 8.00);