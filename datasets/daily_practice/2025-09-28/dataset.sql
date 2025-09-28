CREATE DATABASE IF NOT EXISTS daily_practice_20250928_schema;
USE daily_practice_20250928_schema;

-- This table logs events from various sensors in a smart home.
CREATE TABLE smart_home_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    device_id VARCHAR(50),
    room VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM(
        'MOTION_DETECTED',
        'DOOR_OPENED',
        'DOOR_CLOSED',
        'WINDOW_OPENED',
        'WINDOW_CLOSED',
        'LIGHT_ON',
        'LIGHT_OFF'
    )
);

INSERT INTO smart_home_events (device_id, room, event_timestamp, event_type) VALUES
-- Day 1: Normal entry and activity
('entry_door_sensor', 'Entryway', '2023-11-28 18:00:00.000', 'DOOR_OPENED'),
('entry_motion_sensor', 'Entryway', '2023-11-28 18:00:10.000', 'MOTION_DETECTED'),
('living_room_light', 'Living Room', '2023-11-28 18:00:20.000', 'LIGHT_ON'),
('living_room_motion', 'Living Room', '2023-11-28 18:00:30.000', 'MOTION_DETECTED'),
('kitchen_motion_sensor', 'Kitchen', '2023-11-28 18:10:00.000', 'MOTION_DETECTED'),
('entry_door_sensor', 'Entryway', '2023-11-28 22:00:00.000', 'DOOR_CLOSED'),

-- Day 2: Anomalous event in the morning
('bedroom_motion_sensor', 'Bedroom', '2023-11-29 07:30:00.000', 'MOTION_DETECTED'), -- Should trigger alert
('kitchen_light', 'Kitchen', '2023-11-29 07:31:00.000', 'LIGHT_ON'),
('entry_door_sensor', 'Entryway', '2023-11-29 08:00:00.000', 'DOOR_OPENED'),
('entry_door_sensor', 'Entryway', '2023-11-29 08:01:00.000', 'DOOR_CLOSED'), -- Person leaves

-- Day 2: Another anomalous event later in the day
('living_room_motion', 'Living Room', '2023-11-29 14:00:00.000', 'MOTION_DETECTED'), -- Should trigger alert

-- Day 3: Normal entry, but motion is detected long after entry
('entry_door_sensor', 'Entryway', '2023-11-30 19:00:00.000', 'DOOR_OPENED'),
('kitchen_motion_sensor', 'Kitchen', '2023-11-30 19:20:00.000', 'MOTION_DETECTED'), -- This is > 15 mins after door open, so it's an anomaly.
('entry_door_sensor', 'Entryway', '2023-11-30 19:25:00.000', 'DOOR_CLOSED'),

-- Day 3: A valid motion detection shortly after the door was opened
('entry_door_sensor', 'Entryway', '2023-11-30 20:00:00.000', 'DOOR_OPENED'),
('entry_motion_sensor', 'Entryway', '2023-11-30 20:01:00.000', 'MOTION_DETECTED'); -- This is valid, should NOT be in the output.
