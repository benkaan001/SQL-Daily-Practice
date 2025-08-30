## Puzzle 1: The Machine State Chronicle

**The Scenario:** As a factory floor manager, you need a clear timeline of each machine's operational status. The raw `STATUS_CHANGE` events only tell you when a state begins, not how long it lasts.

**Your Task:** Write a query that transforms the `STATUS_CHANGE` events into a state log. For each machine, the report should show its `status`, the `start_time` of that status, and the `end_time`. The `end_time` is the timestamp of the next status change for that machine. The final state for each machine will not have an `end_time` and should be shown as `NULL`.

The final report should be ordered by `machine_id` and then `start_time`.

**Expected Output:**

| **machine_id** | **status** | **start_time** | **end_time**  |
| -------------------- | ---------------- | -------------------- | ------------------- |
| 101                  | RUNNING          | 2023-12-01 08:00:00  | 2023-12-01 09:30:00 |
| 101                  | IDLE             | 2023-12-01 09:30:00  | 2023-12-01 09:45:00 |
| 101                  | RUNNING          | 2023-12-01 09:45:00  | 2023-12-01 12:00:00 |
| 101                  | OFFLINE          | 2023-12-01 12:00:00  | NULL                |
| 102                  | RUNNING          | 2023-12-01 08:00:00  | 2023-12-01 08:31:05 |
| 102                  | ERROR            | 2023-12-01 08:31:05  | 2023-12-01 09:00:00 |
| 102                  | OFFLINE          | 2023-12-01 09:00:00  | NULL                |
| 103                  | RUNNING          | 2023-12-02 10:00:00  | 2023-12-02 10:16:00 |
| 103                  | SHUTDOWN_MANUAL  | 2023-12-02 10:16:00  | NULL                |
| 104                  | RUNNING          | 2023-12-02 11:00:00  | NULL                |

**Your Solution:**

```sql
-- Write your solution here

```

## Puzzle 2: The Correlated Anomaly Hunter

**The Scenario:** An engineer hypothesizes that critical failures are preceded by a combination of high temperature and high vibration. Your task is to find these specific moments of correlated risk.

**Task:** Identify all `SENSOR_READING` events where the `temperature` is above 100 degrees AND the `vibration` is greater than 1.0. For each of these anomalous readings, find the *immediately preceding* sensor reading from the same machine to see the state of the machine right before the spike.

The report should show the `machine_id`, the timestamp and values of the `anomalous_reading`, and the timestamp and values of the `previous_reading`.

**Expected Output:**

| **machine_id** | **anomalous_reading_time** | **anomalous_temp** | **anomalous_vibration** | **previous_reading_time** | **previous_temp** | **previous_vibration** |
| -------------------- | -------------------------------- | ------------------------ | ----------------------------- | ------------------------------- | ----------------------- | ---------------------------- |
| 102                  | 2023-12-01 08:30:45              | 115.0                    | 1.50                          | 2023-12-01 08:30:00             | 90.0                    | 0.30                         |

**Your Solution:**

```sql
-- Write your solution here

```

## Puzzle 3: The Missing Data Imputer

**The Scenario:** The temperature sensor on `machine_id = 104` is faulty and sometimes fails to report a value, resulting in `NULL`s. To create a continuous data stream for analysis, you need to impute (fill in) these missing values.

**Task:** Write a query that processes the sensor logs for `machine_id = 104`. For every log entry where `temperature` is `NULL`, you must replace the `NULL` with the value from the last known valid temperature reading for that machine.

The final report should show the `log_timestamp` and the `imputed_temperature` for all sensor readings from machine 104, demonstrating that the `NULL`s have been correctly filled.

**Expected Output:**

| **log_timestamp** | **imputed_temperature** |
| ----------------------- | ----------------------------- |
| 2023-12-02 11:10:00.000 | 92.00                         |
| 2023-12-02 11:10:30.000 | 92.00                         |
| 2023-12-02 11:11:00.000 | 92.50                         |
| 2023-12-02 11:11:30.000 | 92.50                         |
| 2023-12-02 11:12:00.000 | 93.00                         |

**Your Solution:**

```sql
-- Write your solution here

```
