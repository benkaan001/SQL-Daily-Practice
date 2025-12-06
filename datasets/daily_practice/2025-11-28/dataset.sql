CREATE DATABASE IF NOT EXISTS daily_practice_20251128_schema;
USE daily_practice_20251128_schema;

-- This table logs background processing jobs executed on various servers.
-- Each server is single-threaded and should strictly run only one job at a time
CREATE TABLE server_job_log (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    server_id VARCHAR(50),
    start_time DATETIME(3),
    end_time DATETIME(3),
    job_name VARCHAR(100),
    status ENUM('COMPLETED', 'FAILED')
);

INSERT INTO server_job_log (server_id, start_time, end_time, job_name, status) VALUES
-- Server-A: Clean sequential execution
('srv-A', '2023-12-01 10:00:00.000', '2023-12-01 10:30:00.000', 'Data_Backup_A', 'COMPLETED'),
('srv-A', '2023-12-01 10:30:00.000', '2023-12-01 11:00:00.000', 'Log_Rotation_A', 'COMPLETED'), -- Starts exactly when previous ends (Allowed)
('srv-A', '2023-12-01 11:05:00.000', '2023-12-01 11:15:00.000', 'Cache_Clear_A', 'COMPLETED'),

-- Server-B: A clear overlap (Job 203 starts while 202 is running)
('srv-B', '2023-12-01 09:00:00.000', '2023-12-01 09:45:00.000', 'Data_Import_B', 'COMPLETED'), -- Job 202 (implied ID 4)
('srv-B', '2023-12-01 09:30:00.000', '2023-12-01 10:00:00.000', 'Email_Sync_B', 'FAILED'),   -- Job 203 (implied ID 5): Overlaps!

-- Server-C: Nested overlap (Job 205 runs entirely inside 204)
('srv-C', '2023-12-01 14:00:00.000', '2023-12-01 16:00:00.000', 'Long_Process_C', 'COMPLETED'), -- Job 204 (implied ID 6)
('srv-C', '2023-12-01 14:30:00.000', '2023-12-01 14:45:00.000', 'Quick_Fix_C', 'COMPLETED'),    -- Job 205 (implied ID 7): Overlaps!

-- Server-D: Complex overlap (Chain reaction)
('srv-D', '2023-12-01 08:00:00.000', '2023-12-01 09:00:00.000', 'Task_D1', 'COMPLETED'), -- Job 8
('srv-D', '2023-12-01 08:50:00.000', '2023-12-01 09:10:00.000', 'Task_D2', 'FAILED'),    -- Job 9: Overlaps with 8
('srv-D', '2023-12-01 09:05:00.000', '2023-12-01 09:30:00.000', 'Task_D3', 'COMPLETED'); -- Job 10: Overlaps with 9 (but not 8)