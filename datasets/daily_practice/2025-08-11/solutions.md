## Scenario 1: Root Cause Analysis of Service Restarts

**Objective:** As a Site Reliability Engineer, you suspect that service restarts are often preceded by a period of high CPU usage. Your task is to validate this hypothesis by finding direct correlations between high CPU events and subsequent restarts.

**Task:** Write a query that identifies every `SERVICE_RESTART` event and finds the most recent `CPU_USAGE` event that occurred on the same `node_id` and `service_name` within the 10 minutes *prior* to the restart. The CPU usage must have a `metric_value` greater than 90.

The final report should include the `node_id`, `service_name`, the `restart_time`, the timestamp of the `last_high_cpu_event`, and the `max_cpu_before_restart`.

**Expected Output:**

| node_id | service_name  | restart_time        | last_high_cpu_event | max_cpu_before_restart |
| ------- | ------------- | ------------------- | ------------------- | ---------------------- |
| 1       | api_gateway   | 2023-11-20 10:01:00 | 2023-11-20 09:55:00 | 95.80                  |
| 2       | user_database | 2023-11-21 14:20:00 | 2023-11-21 14:15:00 | 98.00                  |
| 1       | api_gateway   | 2023-11-23 18:08:00 | 2023-11-23 18:02:00 | 94.00                  |

**Your Solution:**

```sql
WITH restart_events AS (
	SELECT
		event_id,
		node_id,
		service_name,
		event_timestamp AS restart_time
	FROM
		system_events
	WHERE
		event_type = 'SERVICE_RESTART'
),
cpu_events  AS (
	SELECT
		event_id,
		node_id,
		service_name,
		event_timestamp AS high_cpu_event,
		metric_value AS cpu_before_restart
	FROM
		system_events
	WHERE
		event_type = 'CPU_USAGE'
		AND metric_value > 90
),
correlated_events AS (
	SELECT
		r.node_id,
		r.service_name,
		r.restart_time,
		c.cpu_before_restart,
		c.high_cpu_event,
		ROW_NUMBER() OVER (
			PARTITION BY r.event_id
			ORDER BY c.high_cpu_event DESC
		) AS rn
	FROM
		cpu_events c
	JOIN
		restart_events r ON c.node_id  = r.node_id
		AND c.service_name = r.service_name
	WHERE
		TIMESTAMPDIFF(MINUTE, c.high_cpu_event, r.restart_time) BETWEEN 0 AND 10

)
SELECT
	node_id,
	service_name,
	restart_time,
	high_cpu_event AS last_high_cpu_event,
	cpu_before_restart AS max_cpu_before_restart
FROM
	correlated_events
WHERE
	rn = 1;
```

## Scenario 2: Investigating Deployment Failure Blast Radius

**Objective:** A failed deployment on one service might be causing instability in other services running on the same node. You need to identify these "cascade failures" to understand the blast radius of a bad deployment.

**Task:** For every `DEPLOYMENT_FAILURE` event, find all `SERVICE_RESTART` events that occurred on any other service on the *same node* within 1 hour *after* the failure.

The report should list the `failed_service`, the `failed_deployment_time`, the `node_id`, the `cascading_service_name` that restarted, and the `cascading_restart_time`.

**Expected Output:**

| failed_service | failed_deployment_time | node_id | cascading_service_name | cascading_restart_time |
| -------------- | ---------------------- | ------- | ---------------------- | ---------------------- |
| data_pipeline  | 2023-11-21 14:10:00    | 2       | user_database          | 2023-11-21 14:20:00    |
**Your Solution:**

```sql
WITH failures AS (
	SELECT
		event_id,
		node_id,
		service_name AS failed_service,
		event_timestamp AS failed_deployment_time
	FROM
		system_events
	WHERE
		event_type = 'DEPLOYMENT_FAILURE'
),
service_restarts AS (
	SELECT
		event_id,
		node_id,
		service_name AS cascading_service_name,
		event_timestamp AS cascading_restart_time
	FROM
		system_events
	WHERE
		event_type = 'SERVICE_RESTART'
)
SELECT
	f.failed_service,
	f.failed_deployment_time,
	f.node_id,
	sr.cascading_service_name,
	sr.cascading_restart_time
FROM
	failures f
JOIN
	service_restarts sr ON f.node_id = sr.node_id
WHERE
	TIMESTAMPDIFF(HOUR, f.failed_deployment_time, sr.cascading_restart_time) BETWEEN 0 AND 1
	AND f.failed_service != sr.cascading_service_name;
```

## Scenario 3: Detecting "Flapping" Services

**Objective:** A "flapping" service is one that restarts multiple times in a short period, indicating a serious underlying issue that isn't being resolved. Your goal is to create an alert that detects this specific pattern.

**Task:** Write a query to identify any service on any node that has restarted 3 or more times within any continuous 60-minute window.

The report should show the `node_id`, `service_name`, the `first_restart_in_window`, the `last_restart_in_window`, and the `restart_count` for each identified flapping incident.

**Expected Output:**

| node_id | service_name | first_restart_in_window | last_restart_in_window | restart_count |
| ------- | ------------ | ----------------------- | ---------------------- | ------------- |
| 1       | api_gateway  | 2023-11-20 10:01:00     | 2023-11-20 10:50:00    | 3             |
                    |

**Your Solution:**

```sql                   |
WITH restarts AS (
	SELECT
		node_id,
		service_name,
		event_timestamp
	FROM
		system_events
	WHERE
		event_type = 'SERVICE_RESTART'
),
flaps AS (
	SELECT
		r1.node_id,
		r1.service_name ,
		r1.event_timestamp AS first_restart_in_window,
		MAX(r2.event_timestamp) AS last_restart_in_window,
		COUNT(r2.event_timestamp) AS restart_count
	FROM
		restarts r1
	JOIN
		restarts r2 ON r1.node_id = r2.node_id
		AND r1.service_name = r2.service_name
		AND TIMESTAMPDIFF(MINUTE, r1.event_timestamp, r2.event_timestamp) BETWEEN 0 AND 60
	GROUP BY
		r1.node_id,
		r1.service_name,
		r1.event_timestamp
	HAVING
		restart_count >= 3
),
previous_flaps AS (
	SELECT
		node_id,
		service_name,
		first_restart_in_window,
		last_restart_in_window,
		restart_count,
		LAG(first_restart_in_window, 1) OVER (PARTITION BY node_id, service_name ORDER BY first_restart_in_window) AS prev_flap_start
	FROM
		flaps
)
SELECT
	node_id,
	service_name,
	first_restart_in_window,
	last_restart_in_window,
	restart_count
FROM
	previous_flaps
WHERE
	prev_flap_start IS NULL;
```
