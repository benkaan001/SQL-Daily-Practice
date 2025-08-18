CREATE DATABASE IF NOT EXISTS daily_practice_20250818_schema;
USE daily_practice_20250818_schema;

-- This table logs events from a CI/CD (Continuous Integration/Continuous Deployment) pipeline.
CREATE TABLE cicd_pipeline_events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    commit_hash VARCHAR(40),
    service_name VARCHAR(50),
    event_timestamp DATETIME(3),
    event_type ENUM('BUILD_STARTED', 'BUILD_SUCCESS', 'BUILD_FAILURE', 'TEST_STARTED', 'TEST_SUCCESS', 'TEST_FAILURE', 'DEPLOY_STARTED', 'DEPLOY_SUCCESS', 'DEPLOY_FAILURE'),
    details JSON
);

INSERT INTO cicd_pipeline_events (commit_hash, service_name, event_timestamp, event_type, details) VALUES
-- Commit 'a1b2c3d4': Successful run for auth_service
('a1b2c3d4', 'auth_service', '2023-12-10 10:00:00.000', 'BUILD_STARTED', NULL),
('a1b2c3d4', 'auth_service', '2023-12-10 10:05:00.000', 'BUILD_SUCCESS', NULL),
('a1b2c3d4', 'auth_service', '2023-12-10 10:05:01.000', 'TEST_STARTED', '{"test_suite": "unit_tests"}'),
('a1b2c3d4', 'auth_service', '2023-12-10 10:10:00.000', 'TEST_SUCCESS', '{"test_suite": "unit_tests"}'),
('a1b2c3d4', 'auth_service', '2023-12-10 10:10:01.000', 'DEPLOY_STARTED', '{"environment": "production"}'),
('a1b2c3d4', 'auth_service', '2023-12-10 10:15:00.000', 'DEPLOY_SUCCESS', '{"environment": "production"}'),

-- Commit 'e5f6g7h8': Build failure for order_service
('e5f6g7h8', 'order_service', '2023-12-10 11:00:00.000', 'BUILD_STARTED', NULL),
('e5f6g7h8', 'order_service', '2023-12-10 11:07:00.000', 'BUILD_FAILURE', '{"error": "dependency_not_found"}'),

-- Commit 'i9j0k1l2': Flaky integration tests for auth_service
('i9j0k1l2', 'auth_service', '2023-12-11 09:00:00.000', 'BUILD_STARTED', NULL),
('i9j0k1l2', 'auth_service', '2023-12-11 09:05:00.000', 'BUILD_SUCCESS', NULL),
('i9j0k1l2', 'auth_service', '2023-12-11 09:05:01.000', 'TEST_STARTED', '{"test_suite": "integration_tests"}'),
('i9j0k1l2', 'auth_service', '2023-12-11 09:20:00.000', 'TEST_FAILURE', '{"test_suite": "integration_tests", "reason": "timeout"}'), -- First run fails
('i9j0k1l2', 'auth_service', '2023-12-11 09:25:01.000', 'TEST_STARTED', '{"test_suite": "integration_tests"}'), -- Retry
('i9j0k1l2', 'auth_service', '2023-12-11 09:40:00.000', 'TEST_SUCCESS', '{"test_suite": "integration_tests"}'), -- Second run passes
('i9j0k1l2', 'auth_service', '2023-12-11 09:40:01.000', 'DEPLOY_STARTED', '{"environment": "production"}'),
('i9j0k1l2', 'auth_service', '2023-12-11 09:45:00.000', 'DEPLOY_SUCCESS', '{"environment": "production"}'),

-- Commit 'm3n4o5p6': Deployment failure and recovery for order_service
('m3n4o5p6', 'order_service', '2023-12-12 14:00:00.000', 'BUILD_STARTED', NULL),
('m3n4o5p6', 'order_service', '2023-12-12 14:06:00.000', 'BUILD_SUCCESS', NULL),
('m3n4o5p6', 'order_service', '2023-12-12 14:06:01.000', 'TEST_STARTED', '{"test_suite": "all"}'),
('m3n4o5p6', 'order_service', '2023-12-12 14:15:00.000', 'TEST_SUCCESS', '{"test_suite": "all"}'),
('m3n4o5p6', 'order_service', '2023-12-12 14:15:01.000', 'DEPLOY_STARTED', '{"environment": "production"}'),
('m3n4o5p6', 'order_service', '2023-12-12 14:25:00.000', 'DEPLOY_FAILURE', '{"environment": "production", "error": "db_migration_failed"}'),
-- A hotfix is pushed as a new commit 'q7r8s9t0'
('q7r8s9t0', 'order_service', '2023-12-12 14:55:00.000', 'BUILD_STARTED', NULL),
('q7r8s9t0', 'order_service', '2023-12-12 15:01:00.000', 'BUILD_SUCCESS', NULL),
('q7r8s9t0', 'order_service', '2023-12-12 15:01:01.000', 'TEST_STARTED', '{"test_suite": "all"}'),
('q7r8s9t0', 'order_service', '2023-12-12 15:10:00.000', 'TEST_SUCCESS', '{"test_suite": "all"}'),
('q7r8s9t0', 'order_service', '2023-12-12 15:10:01.000', 'DEPLOY_STARTED', '{"environment": "production"}'),
('q7r8s9t0', 'order_service', '2023-12-12 15:20:00.000', 'DEPLOY_SUCCESS', '{"environment": "production"}');
