## Puzzle 1: The Brute-Force Detector

**The Scenario:** As a security analyst, you need to identify potential brute-force attacks against user accounts. An alert should be triggered whenever a user has 5 or more `LOGIN_FAILURE` events within any continuous 10-minute window.

**Your Task:** Write a query to find all such brute-force incidents. The report should show the `user_id`, the `incident_start_time` (the timestamp of the first failed login in the sequence), the `incident_end_time` (the timestamp of the last failed login in the sequence), and the `failed_attempt_count`.

| **user_id** | **incident_start_time** | **incident_end_time** | **failed_attempt_count** |
| ----------------- | ----------------------------- | --------------------------- | ------------------------------ |
| 103               | 2023-10-11 11:00:00.000       | 2023-10-11 11:02:00.000     | 5                              |

**Your Solution:**

```sql
-- Write your solution here
```

## Puzzle 2: The Concurrent Session Alert

**The Scenario:** A key fraud indicator is when a single user account is logged in from multiple locations simultaneously. Your task is to detect these potentially fraudulent concurrent sessions.

**Your Task:** Identify every `LOGIN_SUCCESS` event that occurs for a user who is already considered "active." An active session is defined as one that started with a `LOGIN_SUCCESS` and has not yet been followed by a `LOGOUT` event for that user. Furthermore, the new login must be from a different `ip_address` than the previous one.

The report should show the `user_id`, the `first_login_ip`, the `first_login_time`, the `concurrent_login_ip`, and the `concurrent_login_time`.

| **user_id** | **first_login_ip** | **first_login_time** | **concurrent_login_ip** | **concurrent_login_time** |
| ----------------- | ------------------------ | -------------------------- | ----------------------------- | ------------------------------- |
| 101               | 192.168.1.10             | 2023-10-10 09:00:00.000    | 203.0.113.55                  | 2023-10-10 09:02:30.000         |

**Your Solution:**

```sql
-- Write your solution here
```
