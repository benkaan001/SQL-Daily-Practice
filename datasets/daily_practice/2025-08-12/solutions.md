## Scenario 1: Canary Deployment Performance Comparison

**Objective:** You are running a canary test for `version_id = 2` of the `image_processor` function alongside the stable `version_id = 1`. Your task is to compare their performance and reliability during the test window.

**Task:** For the `image_processor` function, analyze all invocations that occurred on '2023-12-01' between '10:00:00' and '10:01:00'. Create a report that shows the `version_id`, `total_invocations`, `error_rate_pct`, `avg_duration_ms`, and `avg_memory_used_mb`.

The final report should compare the two versions side-by-side.

**Expected Output:**

| version_id | total_invocations | error_count | avg_duration_ms | avg_memory_used_mb |
| ---------- | ----------------- | ----------- | --------------- | ------------------ |
| 1          | 3                 | 0.00        | 85.00           | 128.00             |
| 2          | 3                 | 33.33       | 173.33          | 135.00             |



**Your Solution:**

```sql
SELECT
    version_id,
    COUNT(invocation_id) AS total_invocations,
    ROUND(AVG(CASE WHEN status = 'ERROR' THEN 1 ELSE 0 END) * 100.0, 2) AS error_rate_pct,
    ROUND(AVG(duration_ms), 2) AS avg_duration_ms,
    ROUND(AVG(memory_used_mb), 2) AS avg_memory_used_mb
FROM
    function_invocations
WHERE
    function_name = 'image_processor'
    AND start_timestamp BETWEEN '2023-12-01 10:00:00' AND '2023-12-01 10:01:00'
GROUP BY
    version_id;
```


## Scenario 2: Identifying Chained Function Invocations

**Objective:** A "chained invocation" occurs when one function execution immediately triggers another execution of the same function, often resulting in a tight loop of activity. You need to identify these chains to investigate potential recursive bugs or inefficient workflows.

**Task:** Write a query to find all instances where an invocation of a function starts within 1 millisecond of the previous invocation of the *same function* ending.

For each link in a chain, the report should show the `function_name`, the `previous_invocation_id` (the trigger), the `chained_invocation_id` (the one that was triggered), and the exact `start_timestamp` of the chained call.

**Expected Output:**

| **function_name** | **previous_invocation_id** | **chained_invocation_id** | **chained_start_timestamp** |
| ----------------------- | -------------------------------- | ------------------------------- | --------------------------------- |
| user_auth               | inv_014                          | inv_015                         | 2023-12-02 09:00:00.051           |
| user_auth               | inv_015                          | inv_016                         | 2023-12-02 09:00:00.091           |

**Your Solution:**

```sql
WITH prev_invocations AS (
    SELECT
        function_name,
        invocation_id,
        start_timestamp,
        LAG(invocation_id, 1) OVER (PARTITION BY function_name ORDER BY start_timestamp) AS previous_invocation_id,
        LAG(end_timestamp, 1) OVER (PARTITION BY function_name ORDER BY start_timestamp) AS previous_end_timestamp
    FROM
        function_invocations
)
SELECT
    function_name,
    previous_invocation_id,
    invocation_id AS chained_invocation_id,
    start_timestamp AS chained_start_timestamp
FROM
    prev_invocations
WHERE
    previous_invocation_id IS NOT NULL
    AND TIMESTAMPDIFF(MICROSECOND, previous_end_timestamp, start_timestamp) BETWEEN 0 AND 1000;
```

```sql
-- Using self join
WITH chained_functions AS (
	SELECT
		f1.function_name,
		f1.invocation_id AS previous_invocation_id,
		f2.invocation_id AS chained_invocation_id,
		f2.start_timestamp AS chained_start_timestamp
	FROM
		function_invocations f1
	JOIN
		function_invocations f2 ON f1.invocation_id != f2.invocation_id
		AND f1.function_name = f2.function_name
		AND TIMESTAMPDIFF(MICROSECOND, f1.end_timestamp, f2.start_timestamp) BETWEEN 0 AND 1000
),
ordered_chains AS (
	SELECT
		function_name,
		previous_invocation_id,
		chained_invocation_id,
		chained_start_timestamp,
		ROW_NUMBER() OVER (PARTITION BY previous_invocation_id ORDER BY chained_start_timestamp) AS rn

	FROM
		chained_functions
)
SELECT
	function_name,
	previous_invocation_id,
	chained_invocation_id,
	chained_start_timestamp
FROM
	ordered_chains
WHERE
	rn = 1
```

## Scenario 3: Correlating Errors with High Invocation Frequency

**Objective:** You hypothesize that a sudden burst of traffic (high invocation frequency) is causing an increase in errors for the `data_enrichment` function. Your task is to find evidence of this correlation.

**Task:**

1. First, identify all 1-second windows where the `data_enrichment` function was invoked 3 or more times.
2. For each of these high-frequency windows, calculate the `invocation_count` and the `error_rate_pct`  *within that specific 1-second window* .

The final report should list the `window_start_time` (the timestamp truncated to the second), the `invocation_count`, and the `error_rate_pct` for each identified high-traffic second.

**Expected Output:**

| window_start_time   | invocation_count | error_rate_pct |
| ------------------- | ---------------- | -------------- |


**Your Solution:**

```sql
SELECT
    DATE_FORMAT(start_timestamp, '%Y-%m-%d %H:%i:%s') AS window_start_time,
    COUNT(*) AS invocation_count,
    ROUND(
      AVG(CASE WHEN status = 'ERROR' THEN 1 ELSE 0 END) * 100.0
    , 2) AS error_rate_pct
FROM
    function_invocations
WHERE
    function_name = 'data_enrichment'
GROUP BY
    window_start_time
HAVING
    COUNT(*) >= 3;
```
