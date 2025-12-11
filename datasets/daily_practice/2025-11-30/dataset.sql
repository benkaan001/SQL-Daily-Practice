CREATE DATABASE IF NOT EXISTS daily_practice_20251130_schema;
USE daily_practice_20251130_schema;

-- This table logs active connections to database servers.
CREATE TABLE db_connections (
    connection_id INT PRIMARY KEY AUTO_INCREMENT,
    server_name VARCHAR(50),
    connect_time DATETIME(3),
    disconnect_time DATETIME(3)
);

INSERT INTO db_connections (server_name, connect_time, disconnect_time) VALUES
-- Server 'DB-01': Peak concurrency test
-- 10:00:00: C1 starts (Count: 1)
-- 10:05:00: C2 starts (Count: 2)
-- 10:10:00: C3 starts (Count: 3) -> PEAK START
-- 10:15:00: C2 ends   (Count: 2)
-- 10:20:00: C1 ends   (Count: 1)
-- 10:30:00: C3 ends   (Count: 0)
(1, 'DB-01', '2023-11-30 10:00:00.000', '2023-11-30 10:20:00.000'),
(2, 'DB-01', '2023-11-30 10:05:00.000', '2023-11-30 10:15:00.000'),
(3, 'DB-01', '2023-11-30 10:10:00.000', '2023-11-30 10:30:00.000'),

-- Server 'DB-02': Two separate peaks
-- 14:00 - 14:30: C4
-- 14:10 - 14:40: C5 (Peak of 2 at 14:10)
-- 14:20 - 14:25: C6 (Peak of 3 at 14:20)
(4, 'DB-02', '2023-11-30 14:00:00.000', '2023-11-30 14:30:00.000'),
(5, 'DB-02', '2023-11-30 14:10:00.000', '2023-11-30 14:40:00.000'),
(6, 'DB-02', '2023-11-30 14:20:00.000', '2023-11-30 14:25:00.000'),

-- Server 'DB-03': Low traffic, single connection
(7, 'DB-03', '2023-11-30 16:00:00.000', '2023-11-30 16:05:00.000'),

-- Server 'DB-01': Another connection later (doesn't affect peak)
(8, 'DB-01', '2023-11-30 11:00:00.000', '2023-11-30 11:10:00.000');