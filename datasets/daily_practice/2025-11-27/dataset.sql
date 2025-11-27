CREATE DATABASE IF NOT EXISTS daily_practice_20251127_schema;
USE daily_practice_20251127_schema;

-- This table logs the explicit start and end times for work shifts and breaks.
CREATE TABLE employee_schedule_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    log_timestamp DATETIME(3),
    -- SHIFT_START/END define the overall work period.
    -- BREAK_START/END define non-billable periods within the shift.
    activity_type ENUM('SHIFT_START', 'SHIFT_END', 'BREAK_START', 'BREAK_END')
);

INSERT INTO employee_schedule_log (employee_id, log_timestamp, activity_type) VALUES
-- Employee 101: Two shifts on 2023-11-28. Total billable: 7.0 hours
(101, '2023-11-28 08:00:00.000', 'SHIFT_START'),
(101, '2023-11-28 11:30:00.000', 'BREAK_START'), -- 3.5 hrs billable 1
(101, '2023-11-28 12:00:00.000', 'BREAK_END'),
(101, '2023-11-28 12:00:00.000', 'SHIFT_END'), -- Shift 1 end
(101, '2023-11-28 13:00:00.000', 'SHIFT_START'),
(101, '2023-11-28 16:30:00.000', 'BREAK_START'), -- 3.5 hrs billable 2
(101, '2023-11-28 17:00:00.000', 'BREAK_END'),
(101, '2023-11-28 17:00:00.000', 'SHIFT_END'),

-- Employee 102: One long shift on 2023-11-28. Total billable: 8.0 hours
(102, '2023-11-28 09:00:00.000', 'SHIFT_START'),
(102, '2023-11-28 12:00:00.000', 'BREAK_START'),
(102, '2023-11-28 13:00:00.000', 'BREAK_END'), -- 1 hour break
(102, '2023-11-28 18:00:00.000', 'SHIFT_END'),

-- Employee 103: Shift crosses midnight (ends 2023-11-29 02:00:00)
(103, '2023-11-28 14:00:00.000', 'SHIFT_START'),
(103, '2023-11-28 17:00:00.000', 'BREAK_START'),
(103, '2023-11-28 17:30:00.000', 'BREAK_END'), -- 0.5 hour break
(103, '2023-11-29 02:00:00.000', 'SHIFT_END'), -- Shift End on Day 2

-- Employee 104: Night shift on 2023-11-28. Total billable: 8.0 hours (all active)
(104, '2023-11-28 16:00:00.000', 'SHIFT_START'),
(104, '2023-11-29 00:00:00.000', 'SHIFT_END');