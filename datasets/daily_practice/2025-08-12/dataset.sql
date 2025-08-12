CREATE DATABASE IF NOT EXISTS daily_practice_20250812_schema;
USE daily_practice_20250812_schema;

-- This table logs invocation events for serverless functions.
CREATE TABLE function_invocations (
    invocation_id VARCHAR(50) PRIMARY KEY,
    function_name VARCHAR(50),
    version_id INT,
    start_timestamp DATETIME(3),
    end_timestamp DATETIME(3),
    duration_ms INT,
    memory_used_mb INT,
    status ENUM('SUCCESS', 'ERROR'),
    is_cold_start BOOLEAN
);

INSERT INTO function_invocations (invocation_id, function_name, version_id, start_timestamp, end_timestamp, duration_ms, memory_used_mb, status, is_cold_start) VALUES
-- image_processor function: v1 is stable, v2 is a canary release
('inv_001', 'image_processor', 1, '2023-12-01 10:00:00.000', '2023-12-01 10:00:00.150', 150, 128, 'SUCCESS', true),
('inv_002', 'image_processor', 1, '2023-12-01 10:00:01.000', '2023-12-01 10:00:01.050', 50, 128, 'SUCCESS', false),
('inv_003', 'image_processor', 2, '2023-12-01 10:00:02.000', '2023-12-01 10:00:02.250', 250, 135, 'SUCCESS', true), -- Canary v2 cold start
('inv_004', 'image_processor', 1, '2023-12-01 10:00:03.000', '2023-12-01 10:00:03.055', 55, 128, 'SUCCESS', false),
('inv_005', 'image_processor', 2, '2023-12-01 10:00:04.000', '2023-12-01 10:00:04.080', 80, 135, 'SUCCESS', false), -- Canary v2 warm
('inv_006', 'image_processor', 2, '2023-12-01 10:00:05.000', '2023-12-01 10:00:05.190', 190, 135, 'ERROR', false), -- Canary v2 error

-- data_enrichment function: High frequency invocations
('inv_007', 'data_enrichment', 1, '2023-12-01 11:30:00.000', '2023-12-01 11:30:00.020', 20, 64, 'SUCCESS', true),
('inv_008', 'data_enrichment', 1, '2023-12-01 11:30:01.000', '2023-12-01 11:30:01.022', 22, 64, 'SUCCESS', false),
('inv_009', 'data_enrichment', 1, '2023-12-01 11:30:02.000', '2023-12-01 11:30:02.018', 18, 64, 'SUCCESS', false),
('inv_010', 'data_enrichment', 1, '2023-12-01 11:30:03.000', '2023-12-01 11:30:03.025', 25, 64, 'ERROR', false),
('inv_011', 'data_enrichment', 1, '2023-12-01 11:30:04.000', '2023-12-01 11:30:04.019', 19, 64, 'SUCCESS', false),
('inv_012', 'data_enrichment', 1, '2023-12-01 11:30:05.000', '2023-12-01 11:30:05.021', 21, 64, 'SUCCESS', false),
('inv_013', 'data_enrichment', 1, '2023-12-01 11:30:06.000', '2023-12-01 11:30:06.023', 23, 64, 'SUCCESS', false),

-- user_auth function: Chained invocations
('inv_014', 'user_auth', 3, '2023-12-02 09:00:00.000', '2023-12-02 09:00:00.050', 50, 256, 'SUCCESS', true),
('inv_015', 'user_auth', 3, '2023-12-02 09:00:00.051', '2023-12-02 09:00:00.090', 39, 256, 'SUCCESS', false), -- Chained
('inv_016', 'user_auth', 3, '2023-12-02 09:00:00.091', '2023-12-02 09:00:00.120', 29, 256, 'SUCCESS', false), -- Chained
('inv_017', 'user_auth', 3, '2023-12-02 09:05:00.000', '2023-12-02 09:05:00.045', 45, 256, 'SUCCESS', false),

-- billing_service: Infrequent, long-running
('inv_018', 'billing_service', 1, '2023-12-02 03:00:00.000', '2023-12-02 03:00:05.500', 5500, 512, 'SUCCESS', true),
('inv_019', 'billing_service', 1, '2023-12-03 03:00:00.000', '2023-12-03 03:00:05.600', 5600, 512, 'SUCCESS', true),
('inv_020', 'billing_service', 1, '2023-12-04 03:00:00.000', '2023-12-04 03:00:05.400', 5400, 512, 'SUCCESS', true);
