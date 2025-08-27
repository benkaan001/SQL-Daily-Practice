CREATE DATABASE IF NOT EXISTS daily_practice_20250827_schema;
USE daily_practice_20250827_schema;

-- This table logs user activity on a travel booking website.
CREATE TABLE travel_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(50),
    event_timestamp DATETIME,
    event_type ENUM('search_flights', 'view_hotel', 'book_flight', 'book_hotel', 'cancel_booking'),
    details JSON
);

INSERT INTO travel_events (user_id, session_id, event_timestamp, event_type, details) VALUES
-- User 101: Searches and books a winter getaway
(101, 'sess_A', '2023-11-15 10:00:00', 'search_flights', '{"origin": "JFK", "destination": "ZRH"}'),
(101, 'sess_A', '2023-11-15 10:02:00', 'view_hotel', '{"city": "ZRH", "hotel_id": 901}'),
(101, 'sess_A', '2023-11-15 10:10:00', 'book_flight', '{"booking_id": "BK-F1", "destination": "ZRH", "value": 1200.00}'),
(101, 'sess_A', '2023-11-15 10:15:00', 'book_hotel', '{"booking_id": "BK-H1", "city": "ZRH", "value": 800.00}'),

-- User 102: Searches, views, but doesn't book
(102, 'sess_B', '2023-11-15 11:00:00', 'search_flights', '{"origin": "LAX", "destination": "ZRH"}'),
(102, 'sess_B', '2023-11-15 11:03:00', 'view_hotel', '{"city": "ZRH", "hotel_id": 902}'),

-- User 103: Searches but doesn't view hotel
(103, 'sess_C', '2023-11-16 09:00:00', 'search_flights', '{"origin": "ORD", "destination": "ZRH"}'),

-- User 104: Last-minute cancellation
(104, 'sess_D', '2023-11-16 14:00:00', 'book_flight', '{"booking_id": "BK-F2", "destination": "MIA", "value": 450.00}'),
(104, 'sess_D', '2023-11-17 10:00:00', 'cancel_booking', '{"booking_id": "BK-F2", "reason": "change_of_plans"}'), -- Within 48h

-- User 105: Normal cancellation
(105, 'sess_E', '2023-11-10 18:00:00', 'book_hotel', '{"booking_id": "BK-H2", "city": "LAS", "value": 600.00}'),
(105, 'sess_E', '2023-11-15 19:00:00', 'cancel_booking', '{"booking_id": "BK-H2", "reason": "found_better_deal"}'), -- More than 48h

-- User 106: "Ghost booking" bug
(106, 'sess_F', '2023-11-18 13:00:00', 'view_hotel', '{"city": "SFO", "hotel_id": 801}'),
(106, 'sess_F', '2023-11-18 13:05:00', 'book_flight', '{"booking_id": "BK-F3", "destination": "SFO", "value": 350.00}'), -- No preceding search in this session

-- User 107: Searches for a different destination
(107, 'sess_G', '2023-11-18 15:00:00', 'search_flights', '{"origin": "MIA", "destination": "LHR"}'),
(107, 'sess_G', '2023-11-18 15:05:00', 'book_flight', '{"booking_id": "BK-F4", "destination": "LHR", "value": 950.00}');
