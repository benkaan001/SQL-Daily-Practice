CREATE DATABASE IF NOT EXISTS daily_practice_20260422_schema;
USE daily_practice_20260422_schema;

-- This table logs the creation and resolution dates of customer support tickets.
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    created_date DATE,
    resolved_date DATE
);

-- This table holds the official company holidays for the year.
CREATE TABLE company_holidays (
    holiday_date DATE PRIMARY KEY,
    holiday_name VARCHAR(50)
);

INSERT INTO company_holidays (holiday_date, holiday_name) VALUES
('2026-04-03', 'Good Friday'),
('2026-05-04', 'Early May Bank Holiday'),
('2026-05-25', 'Spring Bank Holiday');

INSERT INTO support_tickets (ticket_id, created_date, resolved_date) VALUES
-- Ticket 1: Standard overnight resolution (1 business day)
(1, '2026-04-06', '2026-04-07'), 

-- Ticket 2: Spans across a normal weekend (Sat 11th, Sun 12th)
(2, '2026-04-10', '2026-04-14'), 

-- Ticket 3: Spans across a holiday (Fri 3rd) and a weekend (Sat 4th, Sun 5th)
(3, '2026-04-01', '2026-04-06'), 

-- Ticket 4: Spans a weekend AND a holiday the following Monday
(4, '2026-04-29', '2026-05-06'), 

-- Ticket 5: Created and resolved on the exact same day (0 business days taken)
(5, '2026-04-15', '2026-04-15');