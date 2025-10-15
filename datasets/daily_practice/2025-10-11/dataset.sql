CREATE DATABASE IF NOT EXISTS daily_practice_20251011_schema;
USE daily_practice_20251011_schema;

-- This table logs the journey of packages through a shipping network.
-- The 'details' column now uses the JSON data type to store structured event information.
CREATE TABLE shipment_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    shipment_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM(
        'PICKED_UP',
        'IN_TRANSIT',
        'DELAYED',
        'OUT_FOR_DELIVERY',
        'DELIVERED'
    ),
    location VARCHAR(100),
    details JSON
);

INSERT INTO shipment_logs (shipment_id, event_timestamp, event_type, location, details) VALUES
-- Shipment A-101: Delayed due to weather after passing through Chicago Hub
('A-101', '2023-10-01 10:00:00.000', 'PICKED_UP', 'New York, NY', JSON_OBJECT('driver_id', 12, 'vehicle_plate', 'NY-TRK-01')),
('A-101', '2023-10-02 14:00:00.000', 'IN_TRANSIT', 'Philadelphia, PA', JSON_OBJECT('status', 'Departed facility', 'vehicle_id', 'TRK-PHL-88')),
('A-101', '2023-10-03 18:00:00.000', 'IN_TRANSIT', 'Chicago, IL', JSON_OBJECT('status', 'Arrived at hub', 'hub_code', 'CHI-01')),
('A-101', '2023-10-04 09:00:00.000', 'DELAYED', 'Chicago, IL', JSON_OBJECT('reason', 'Weather conditions', 'estimated_delay_hours', 24)),
('A-101', '2023-10-05 11:00:00.000', 'IN_TRANSIT', 'Chicago, IL', JSON_OBJECT('status', 'Departed facility', 'vehicle_id', 'TRK-CHI-15')),
('A-101', '2023-10-06 15:00:00.000', 'OUT_FOR_DELIVERY', 'Los Angeles, CA', JSON_OBJECT('driver_id', 45)),
('A-101', '2023-10-06 18:00:00.000', 'DELIVERED', 'Los Angeles, CA', JSON_OBJECT('signed_by', 'J. Doe')),

-- Shipment B-202: Smooth delivery, no delay
('B-202', '2023-10-02 11:00:00.000', 'PICKED_UP', 'Miami, FL', JSON_OBJECT('driver_id', 21, 'vehicle_plate', 'FL-TRK-05')),
('B-202', '2023-10-03 16:00:00.000', 'IN_TRANSIT', 'Atlanta, GA', JSON_OBJECT('status', 'Departed facility', 'vehicle_id', 'TRK-ATL-02')),
('B-202', '2023-10-05 20:00:00.000', 'OUT_FOR_DELIVERY', 'Dallas, TX', JSON_OBJECT('driver_id', 52)),
('B-202', '2023-10-06 10:00:00.000', 'DELIVERED', 'Dallas, TX', JSON_OBJECT('signed_by', 'B. Smith')),

-- Shipment C-303: Delayed due to mechanical issue after Denver Hub
('C-303', '2023-10-04 08:00:00.000', 'PICKED_UP', 'Seattle, WA', JSON_OBJECT('driver_id', 33, 'vehicle_plate', 'WA-TRK-11')),
('C-303', '2023-10-06 12:00:00.000', 'IN_TRANSIT', 'Denver, CO', JSON_OBJECT('status', 'Arrived at hub', 'hub_code', 'DEN-03')),
('C-303', '2023-10-06 20:00:00.000', 'DELAYED', 'Denver, CO', JSON_OBJECT('reason', 'Mechanical issue', 'estimated_delay_hours', 48)),
('C-303', '2023-10-08 09:00:00.000', 'OUT_FOR_DELIVERY', 'Phoenix, AZ', JSON_OBJECT('driver_id', 61)),

-- Shipment D-404: Delayed due to high volume after Chicago Hub
('D-404', '2023-10-05 15:00:00.000', 'PICKED_UP', 'Boston, MA', JSON_OBJECT('driver_id', 15, 'vehicle_plate', 'MA-TRK-09')),
('D-404', '2023-10-07 18:00:00.000', 'IN_TRANSIT', 'Chicago, IL', JSON_OBJECT('status', 'Arrived at hub', 'hub_code', 'CHI-01')),
('D-404', '2023-10-08 10:00:00.000', 'DELAYED', 'Chicago, IL', JSON_OBJECT('reason', 'High volume', 'estimated_delay_hours', 12)),

-- Shipment E-505: Delayed due to weather after Atlanta Hub
('E-505', '2023-10-06 10:00:00.000', 'PICKED_UP', 'Orlando, FL', JSON_OBJECT('driver_id', 24, 'vehicle_plate', 'FL-TRK-18')),
('E-505', '2023-10-07 11:00:00.000', 'IN_TRANSIT', 'Atlanta, GA', JSON_OBJECT('status', 'Arrived at hub', 'hub_code', 'ATL-01')),
('E-505', '2023-10-08 12:00:00.000', 'DELAYED', 'Atlanta, GA', JSON_OBJECT('reason', 'Weather conditions', 'estimated_delay_hours', 18));

