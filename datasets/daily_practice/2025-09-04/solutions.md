## Puzzle 1: The Brute-Force Detector

**The Scenario:** As a security analyst, you need to identify potential brute-force attacks against user accounts. An alert should be triggered whenever a user has 5 or more `LOGIN_FAILURE` events within any continuous 10-minute window.

**Your Task:** Write a query to find all such brute-force incidents. The report should show the `user_id`, the `incident_start_time` (the timestamp of the first failed login in the sequence), the `incident_end_time` (the timestamp of the last failed login in the sequence), and the `failed_attempt_count`.

| user_id | incident_start_time | incident_end_time   | failed_attempt_count |
| ------- | ------------------- | ------------------- | -------------------- |
| 103     | 2023-10-11 11:00:00 | 2023-10-11 11:02:00 | 5                    |
**Your Solution:**

```sql
WITH failures AS (
	SELECT
		user_id,
		event_timestamp
	FROM
		auth_events
	WHERE
		event_type = 'LOGIN_FAILURE'
		AND JSON_UNQUOTE(JSON_EXTRACT(details, '$.reason')) = 'INVALID_PASSWORD'
),
filtered_failures AS (
	SELECT
		f1.user_id,
		f1.event_timestamp AS window_start,
		MAX(f2.event_timestamp) AS last_failure_in_window,
		COUNT(f2.event_timestamp) AS failed_attempt_count
	FROM
		failures f1
	JOIN
		failures f2 ON f1.user_id = f2.user_id
		AND f2.event_timestamp BETWEEN f1.event_timestamp AND DATE_ADD(f1.event_timestamp, INTERVAL 10 MINUTE)
	GROUP BY
		f1.user_id,
		f1.event_timestamp

),
ranked_filtered_failures AS (
	SELECT
		user_id,
		window_start AS incident_start_time,
		last_failure_in_window AS incident_end_time,
		failed_attempt_count,
		ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY window_start) AS rn
	FROM
		filtered_failures
	WHERE
		failed_attempt_count >= 5
)
SELECT
	user_id,
	incident_start_time,
	incident_end_time,
	failed_attempt_count
FROM
	ranked_filtered_failures
WHERE
	rn = 1;
```
## Solution explanation
```sql
-- Step 1: Isolate only the relevant login failure events.
WITH LoginFailures AS (
    SELECT
        user_id,
        event_timestamp
    FROM
        auth_events
    WHERE
        event_type = 'LOGIN_FAILURE'
),

-- Step 2: For each failure, find all other failures from the same user within the next 10 minutes.
-- This identifies all possible 10-minute windows that could contain a brute-force attack.
BruteForceWindows AS (
    SELECT
        f1.user_id,
        -- The start of the window is the timestamp of the first failure in the group.
        f1.event_timestamp AS window_start,
        -- Count how many failures (f2) occurred within this window.
        COUNT(f2.event_timestamp) AS failed_attempt_count,
        -- Find the timestamp of the last failure in the window.
        MAX(f2.event_timestamp) AS last_failure_in_window
    FROM
        LoginFailures f1
    JOIN
        LoginFailures f2 ON f1.user_id = f2.user_id
        -- This join condition IS the 10-minute rolling window.
        AND f2.event_timestamp BETWEEN f1.event_timestamp AND DATE_ADD(f1.event_timestamp, INTERVAL 10 MINUTE)
    GROUP BY
        f1.user_id,
        f1.event_timestamp
),

-- Step 3: Filter for only the windows that meet the brute-force criteria (>= 5 failures)
-- and find the very first one for each incident to avoid duplicate alerts.
RankedIncidents AS (
    SELECT
        user_id,
        window_start AS incident_start_time,
        last_failure_in_window AS incident_end_time,
        failed_attempt_count,
        -- Rank the incidents for each user to find the first one.
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY window_start) as rn
    FROM
        BruteForceWindows
    WHERE
        failed_attempt_count >= 5
)

-- Final Step: Select the first ranked incident for each user.
SELECT
    user_id,
    incident_start_time,
    incident_end_time,
    failed_attempt_count
FROM
    RankedIncidents
WHERE
    rn = 1;
```

## Puzzle 2: The Concurrent Session Alert

**The Scenario:** A key fraud indicator is when a single user account is logged in from multiple locations simultaneously. Your task is to detect these potentially fraudulent concurrent sessions.

**Your Task:** Identify every `LOGIN_SUCCESS` event that occurs for a user who is already considered "active." An active session is defined as one that started with a `LOGIN_SUCCESS` and has not yet been followed by a `LOGOUT` event for that user. Furthermore, the new login must be from a different `ip_address` than the previous one.

The report should show the `user_id`, the `first_login_ip`, the `first_login_time`, the `concurrent_login_ip`, and the `concurrent_login_time`.

| user_id | first_login_ip | first_login_time    | concurrent_login_ip | concurrent_login_time |
| ------- | -------------- | ------------------- | ------------------- | --------------------- |
| 101     | 192.168.1.10   | 2023-10-10 09:00:00 | 203.0.113.55        | 2023-10-10 09:02:30   |

**Your Solution:**

```sql
WITH prev_logins AS (
    SELECT
        user_id,
        event_timestamp,
        event_type,
        ip_address,
        LAG(event_type, 1) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS prev_event_type,
        LAG(ip_address, 1) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS prev_ip_address,
        LAG(event_timestamp, 1) OVER (PARTITION BY user_id ORDER BY event_timestamp) AS prev_event_timestamp
    FROM
        auth_events
)
SELECT
    user_id,
    prev_ip_address AS first_login_ip,
    prev_event_timestamp AS first_login_time,
    ip_address AS concurrent_login_ip,
    event_timestamp AS concurrent_login_time
FROM
    prev_logins
WHERE
    event_type = 'LOGIN_SUCCESS'
    AND prev_event_type = 'LOGIN_SUCCESS'
    AND ip_address <> prev_ip_address;
```
