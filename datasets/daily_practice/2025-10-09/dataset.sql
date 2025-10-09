CREATE DATABASE IF NOT EXISTS daily_practice_20251009_schema;
USE daily_practice_20251009_schema;

-- This table logs the movement and processing of packages within a large fulfillment center.
CREATE TABLE warehouse_package_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    package_id VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM(
        'RECEIVED_AT_DOCK',
        'SORTED',
        'MOVED_TO_BIN',
        'PICKED_FOR_SHIPMENT',
        'PACKED',
        'LOADED_ON_TRUCK'
    ),
    location_details VARCHAR(100) -- e.g., Dock Door, Bin ID, Packing Station
);

INSERT INTO warehouse_package_log (package_id, event_timestamp, event_type, location_details) VALUES
-- Package PKG-101: Flows through smoothly
('PKG-101', '2023-12-10 08:00:00.000', 'RECEIVED_AT_DOCK', 'Dock-A-1'),
('PKG-101', '2023-12-10 08:30:00.000', 'SORTED', 'Sorting-Belt-3'),
('PKG-101', '2023-12-10 09:15:00.000', 'MOVED_TO_BIN', 'Bin-C-42'),
('PKG-101', '2023-12-11 10:00:00.000', 'PICKED_FOR_SHIPMENT', 'Bin-C-42'),
('PKG-101', '2023-12-11 10:25:00.000', 'PACKED', 'Packing-Station-5'),
('PKG-101', '2023-12-11 11:00:00.000', 'LOADED_ON_TRUCK', 'Truck-Bay-7'),

-- Package PKG-102: Lost after being moved to a bin
('PKG-102', '2023-12-10 14:00:00.000', 'RECEIVED_AT_DOCK', 'Dock-B-2'),
('PKG-102', '2023-12-10 14:45:00.000', 'SORTED', 'Sorting-Belt-1'),
('PKG-102', '2023-12-10 15:30:00.000', 'MOVED_TO_BIN', 'Bin-A-113'),
-- No activity for this package since 2023-12-10. It should be flagged as lost.

-- Package PKG-103: Lost right after being sorted
('PKG-103', '2023-12-11 11:00:00.000', 'RECEIVED_AT_DOCK', 'Dock-A-3'),
('PKG-103', '2023-12-11 11:30:00.000', 'SORTED', 'Sorting-Belt-2'),
-- No activity since 2023-12-11. It should also be flagged as lost.

-- Package PKG-104: Still in process, but not yet lost
('PKG-104', '2023-12-13 09:00:00.000', 'RECEIVED_AT_DOCK', 'Dock-C-1'),
('PKG-104', '2023-12-13 09:40:00.000', 'SORTED', 'Sorting-Belt-4'),
('PKG-104', '2023-12-14 10:00:00.000', 'MOVED_TO_BIN', 'Bin-D-88'),
-- Last activity is recent, so it should NOT appear in the output.

-- Package PKG-105: Another smooth fulfillment
('PKG-105', '2023-12-12 16:00:00.000', 'RECEIVED_AT_DOCK', 'Dock-B-4'),
('PKG-105', '2023-12-12 16:30:00.000', 'SORTED', 'Sorting-Belt-1'),
('PKG-105', '2023-12-12 17:10:00.000', 'MOVED_TO_BIN', 'Bin-B-21'),
('PKG-105', '2023-12-13 14:00:00.000', 'PICKED_FOR_SHIPMENT', 'Bin-B-21'),
('PKG-105', '2023-12-13 14:20:00.000', 'PACKED', 'Packing-Station-2'),
('PKG-105', '2023-12-13 15:00:00.000', 'LOADED_ON_TRUCK', 'Truck-Bay-9');
