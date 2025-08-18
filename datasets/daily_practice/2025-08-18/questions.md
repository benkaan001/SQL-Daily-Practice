## Scenario 1: Pipeline Funnel and Duration Analysis

**Objective:** As an engineering lead, you need to understand the health and efficiency of your CI/CD pipeline. This involves analyzing the success rate and duration of each stage for every pipeline run.

**Task:** For each unique `commit_hash`, create a summary of its pipeline run. The report must show:

1. The `commit_hash` and `service_name`.
2. The `pipeline_start_time` (the timestamp of the 'BUILD_STARTED' event).
3. The `final_status` of the run ('SUCCESS' if it ended with 'DEPLOY_SUCCESS', otherwise 'FAILURE').
4. The `total_duration_minutes` from `BUILD_STARTED` to the final event ('DEPLOY_SUCCESS', 'DEPLOY_FAILURE', or 'BUILD_FAILURE').

Order the results by `pipeline_start_time`.

**Expected Output:**

| **commit_hash** | **service_name** | **pipeline_start_time** | **final_status** | **total_duration_minutes** |
| --------------------- | ---------------------- | ----------------------------- | ---------------------- | -------------------------------- |
| a1b2c3d4              | auth_service           | 2023-12-10 10:00:00           | SUCCESS                | 15.00                            |
| e5f6g7h8              | order_service          | 2023-12-10 11:00:00           | FAILURE                | 7.00                             |
| i9j0k1l2              | auth_service           | 2023-12-11 09:00:00           | SUCCESS                | 45.00                            |
| m3n4o5p6              | order_service          | 2023-12-12 14:00:00           | FAILURE                | 25.00                            |
| q7r8s9t0              | order_service          | 2023-12-12 14:55:00           | SUCCESS                | 25.00                            |

**Your Solution:**

```sql
-- Write your solution here

```

## Scenario 2: Identifying Flaky Test Suites

**Objective:** Flaky tests undermine developer confidence and slow down deployments. Your task is to identify test suites that are behaving unreliably for the same version of code.

**Task:** Write a query to find any `test_suite` that, for the *same* `commit_hash` and `service_name`, has recorded both a `TEST_SUCCESS` and a `TEST_FAILURE` event.

The report should show the `service_name`, `commit_hash`, the `test_suite` that is flaky, the timestamp of the `first_failure`, and the timestamp of the `first_success`.

**Expected Output:**

| **service_name** | **commit_hash** | **test_suite** | **first_failure** | **first_success** |
| ---------------------- | --------------------- | -------------------- | ----------------------- | ----------------------- |
| auth_service           | i9j0k1l2              | integration_tests    | 2023-12-11 09:20:00     | 2023-12-11 09:40:00     |

**Your Solution:**

```sql
-- Write your solution here

```

## Scenario 3: Calculating Mean Time To Recovery (MTTR)

**Objective:** A key DevOps metric is Mean Time To Recovery (MTTR), which measures how quickly a service can recover from a deployment failure. Your goal is to calculate this for each service.

**Task:** For each service that has experienced a `DEPLOY_FAILURE`, calculate its MTTR. MTTR is defined as the time difference between a `DEPLOY_FAILURE` event and the *next* `DEPLOY_SUCCESS` event for that same service (which may have a different `commit_hash`, representing a hotfix).

The report should show the `service_name`, the timestamp of the `failure_event`, the timestamp of the `recovery_event`, and the `time_to_recovery_minutes`.

**Expected Output:**

| **service_name** | **failure_event** | **recovery_event** | **time_to_recovery_minutes** |
| ---------------------- | ----------------------- | ------------------------ | ---------------------------------- |
| order_service          | 2023-12-12 14:25:00     | 2023-12-12 15:20:00      | 55.00                              |

**Your Solution:**

```sql
-- Write your solution here

```
