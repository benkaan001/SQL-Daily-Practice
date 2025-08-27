## Scenario 1: Simulating a Data Lifecycle Policy

**Objective:** As a cloud administrator, you need to identify objects that are candidates for deletion based on a new data lifecycle policy. The policy states that any object in the `backups` bucket that has not been accessed (i.e., no `GET` events) for over 30 days should be flagged.

**Task:** Write a query that finds all objects in the `backups` bucket that are deletion candidates as of '2023-11-30'. For each candidate, the report should show the `object_key`, the date it was `last_modified` (the most recent 'PUT' event), and the date it was `last_accessed` (the most recent 'GET' event, which will be NULL if never accessed).

**Expected Output:**

| object_key           | last_modified       | last_accessed       |
| -------------------- | ------------------- | ------------------- |
| db_dump_20231001.gz  | 2023-10-01 03:00:00 | 2023-10-02 04:00:00 |
| app_log_20231005.log | 2023-10-05 10:00:00 |                     |

**Your Solution:**

```sql
WITH objects AS (
    SELECT
        object_key,
        MAX(CASE WHEN event_type = 'PUT' THEN event_timestamp END) AS last_modified,
        MAX(CASE WHEN event_type = 'GET' THEN event_timestamp END) AS last_accessed
    FROM
        cloud_storage_logs
    WHERE
        bucket_name = 'backups'
    GROUP BY
        object_key
)
SELECT
    object_key,
    last_modified,
    last_accessed
FROM
    objects
WHERE
    last_accessed IS NULL
    OR DATEDIFF('2023-11-30', last_accessed) > 30;
```

## Scenario 2: Detecting Egress Cost Anomalies

**Objective:** A significant portion of cloud costs comes from data egress (data transferred out via `GET` requests). You need to build an alert to detect users whose daily egress traffic spikes suspiciously.

**Task:** For each user, calculate their daily total egress in gigabytes (GB). Then, for each day, calculate the user's average daily egress over the previous 7 days (a 7-day rolling average). An "anomaly" is a day where the user's total egress is more than 10 times their rolling 7-day average.

The report should list the `alert_date`, `user_id`, the `anomalous_egress_gb`, and the `avg_egress_gb_last_7_days` for each detected anomaly.

**Expected Output:**

| alert_date | user_id | anomalous_egress_gb | avg_egress_gb_last_7_days |
| ---------- | ------- | ------------------- | ------------------------- |
| 2023-11-17 | 904     | 0.47                | 0.01                      |


**Your Solution:**

```sql
WITH egress AS (
    SELECT
        user_id,
        DATE(event_timestamp) AS event_date,
        SUM(bytes_transferred) AS total_bytes
    FROM
        cloud_storage_logs
    WHERE
        event_type = 'GET'
    GROUP BY
        user_id,
        DATE(event_timestamp)
),
rolling_averages AS (
    SELECT
        user_id,
        event_date,
        total_bytes,
        AVG(total_bytes) OVER (
            PARTITION BY user_id
            ORDER BY event_date
            ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING
        ) AS seven_day_avg_bites
    FROM
        egress
)
SELECT
    event_date AS alert_date,
    user_id,
    ROUND(total_bytes / 1073741824, 2) AS anomalous_egress_gb,
    ROUND(seven_day_avg_bites / 1073741824, 2) AS avg_egress_gb_last_7_days
FROM
    rolling_averages
WHERE
    seven_day_avg_bites IS NOT NULL
    AND total_bytes > seven_day_avg_bites * 10;
```

## Scenario 3: Identifying "Leaky" Buckets

**Objective:** As a security engineer, you must identify storage buckets that have had their security posture weakened over time. A "leaky" bucket is one that was initially created for private objects but later had a public object added to it.

**Task:** Write a query to find all `bucket_name`s that have at least one object `PUT` with `is_public = false` and, at a later time, another object `PUT` with `is_public = true`.

The report should show the `bucket_name`, the timestamp of the `first_private_upload`, and the timestamp of the `first_public_upload` that occurred after it.

**Expected Output:**

| alert_date | user_id | anomalous_egress_gb | avg_egress_gb_last_7_days |
| ---------- | ------- | ------------------- | ------------------------- |
| 2023-11-17 | 904     | 0.47                | 0.01                      |

**Your Solution:**

```sql
WITH uploads AS (
    SELECT
        bucket_name,
        MIN(CASE WHEN is_public = 0 THEN event_timestamp END) AS first_private_upload,
        MIN(CASE WHEN is_public = 1 THEN event_timestamp END) AS first_public_upload
    FROM
        cloud_storage_logs
    WHERE
        event_type = 'PUT'
    GROUP BY
        bucket_name
)
SELECT
    bucket_name,
    first_private_upload,
    first_public_upload
FROM
    uploads
WHERE
    first_private_upload IS NOT NULL
    AND first_public_upload IS NOT NULL
    AND first_public_upload > first_private_upload;
```
