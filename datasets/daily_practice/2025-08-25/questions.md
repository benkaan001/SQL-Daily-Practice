## Scenario 1: Simulating a Data Lifecycle Policy

**Objective:** As a cloud administrator, you need to identify objects that are candidates for deletion based on a new data lifecycle policy. The policy states that any object in the `backups` bucket that has not been accessed (i.e., no `GET` events) for over 30 days should be flagged.

**Task:** Write a query that finds all objects in the `backups` bucket that are deletion candidates as of '2023-11-30'. For each candidate, the report should show the `object_key`, the date it was `last_modified` (the most recent 'PUT' event), and the date it was `last_accessed` (the most recent 'GET' event, which will be NULL if never accessed).

**Expected Output:**

| **object_key** | **last_modified** | **last_accessed** |
| -------------------- | ----------------------- | ----------------------- |
| app_log_20231005.log | 2023-10-05 10:00:00     | NULL                    |
| db_dump_20231001.gz  | 2023-10-01 03:00:00     | 2023-10-02 04:00:00     |

**Your Solution:**

```sql
-- Write your solution here

```

## Scenario 2: Detecting Egress Cost Anomalies

**Objective:** A significant portion of cloud costs comes from data egress (data transferred out via `GET` requests). You need to build an alert to detect users whose daily egress traffic spikes suspiciously.

**Task:** For each user, calculate their daily total egress in gigabytes (GB). Then, for each day, calculate the user's average daily egress over the previous 7 days (a 7-day rolling average). An "anomaly" is a day where the user's total egress is more than 10 times their rolling 7-day average.

The report should list the `alert_date`, `user_id`, the `anomalous_egress_gb`, and the `avg_egress_gb_last_7_days` for each detected anomaly.

**Expected Output:**

| **alert_date** | **user_id** | **anomalous_egress_gb** | **avg_egress_gb_last_7_days** |
| -------------------- | ----------------- | ----------------------------- | ----------------------------------- |
| 2023-11-17           | 904               | 0.50                          | 0.01                                |

**Your Solution:**

```sql
-- Write your solution here

```

## Scenario 3: Identifying "Leaky" Buckets

**Objective:** As a security engineer, you must identify storage buckets that have had their security posture weakened over time. A "leaky" bucket is one that was initially created for private objects but later had a public object added to it.

**Task:** Write a query to find all `bucket_name`s that have at least one object `PUT` with `is_public = false` and, at a later time, another object `PUT` with `is_public = true`.

The report should show the `bucket_name`, the timestamp of the `first_private_upload`, and the timestamp of the `first_public_upload` that occurred after it.

**Expected Output:**

| **bucket_name** | **first_private_upload** | **first_public_upload** |
| --------------------- | ------------------------------ | ----------------------------- |
| public-assets         | 2023-10-15 11:00:00            | 2023-10-20 14:00:00           |

**Your Solution:**

```sql
-- Write your solution here

```
