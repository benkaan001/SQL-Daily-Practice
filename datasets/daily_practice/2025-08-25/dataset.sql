CREATE DATABASE IF NOT EXISTS daily_practice_20250825_schema;
USE daily_practice_20250825_schema;

-- This table logs access and modification events for objects in a clouad storage system.
CREATE TABLE cloud_storage_logs (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    bucket_name VARCHAR(50),
    object_key VARCHAR(255),
    event_timestamp DATETIME(3),
    event_type ENUM('PUT', 'GET', 'DELETE', 'LIST'),
    user_id INT,
    bytes_transferred BIGINT,
    is_public BOOLEAN
);

INSERT INTO cloud_storage_logs (bucket_name, object_key, event_timestamp, event_type, user_id, bytes_transferred, is_public) VALUES
-- Bucket 'backups': Lifecycle policy candidates
('backups', 'db_dump_20231001.gz', '2023-10-01 03:00:00.000', 'PUT', 901, 5368709120, false), -- 5 GB
('backups', 'db_dump_20231001.gz', '2023-10-02 04:00:00.000', 'GET', 902, 5368709120, false), -- Accessed once
('backups', 'app_log_20231005.log', '2023-10-05 10:00:00.000', 'PUT', 901, 104857600, false), -- 100 MB, never accessed
('backups', 'db_dump_20231101.gz', '2023-11-01 03:00:00.000', 'PUT', 901, 5800000000, false), -- Accessed recently
('backups', 'db_dump_20231101.gz', '2023-11-20 05:00:00.000', 'GET', 902, 5800000000, false),

-- Bucket 'public-assets': Leaky bucket scenario
('public-assets', 'images/logo_private.png', '2023-10-15 11:00:00.000', 'PUT', 903, 51200, false), -- Initially private
('public-assets', 'images/banner_private.jpg', '2023-10-16 12:00:00.000', 'PUT', 903, 204800, false),
('public-assets', 'images/logo_public.png', '2023-10-20 14:00:00.000', 'PUT', 903, 51200, true), -- Bucket is now public
('public-assets', 'images/promo.gif', '2023-10-21 15:00:00.000', 'PUT', 903, 1024000, true),

-- User 904: Egress cost anomaly
('user-uploads', 'user_904/file1.zip', '2023-11-10 08:00:00.000', 'GET', 904, 10000000, false), -- 10 MB
('user-uploads', 'user_904/file2.zip', '2023-11-11 09:00:00.000', 'GET', 904, 12000000, false),
('user-uploads', 'user_904/file3.zip', '2023-11-12 10:00:00.000', 'GET', 904, 11000000, false),
('user-uploads', 'user_904/file4.zip', '2023-11-13 11:00:00.000', 'GET', 904, 9000000, false),
('user-uploads', 'user_904/file5.zip', '2023-11-14 12:00:00.000', 'GET', 904, 13000000, false),
('user-uploads', 'user_904/file6.zip', '2023-11-15 13:00:00.000', 'GET', 904, 10000000, false),
('user-uploads', 'user_904/file7.zip', '2023-11-16 14:00:00.000', 'GET', 904, 12000000, false),
('user-uploads', 'user_904/data_leak.zip', '2023-11-17 10:00:00.000', 'GET', 904, 500000000, false), -- 500 MB spike
('user-uploads', 'user_904/normal.zip', '2023-11-18 11:00:00.000', 'GET', 904, 15000000, false),

-- Bucket 'archive': No issues
('archive', 'projectA.zip', '2023-09-01 18:00:00.000', 'PUT', 905, 1073741824, false); -- 1 GB
