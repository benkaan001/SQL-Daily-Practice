## Puzzle: The Server State Duration

**The Scenario:** As a Site Reliability Engineer (SRE), you don't just care about *when* a server's state changes, but how *long* it spends in each state. The raw log table only provides the start time of a new state.

**Your Task:** Write a query that transforms the `server_state_logs` into a "state duration" report. The report must show, for each server, every state it was in, the `start_time` of that state, and the `end_time` of that state.

The `end_time` for a given state is the `log_timestamp` of the *next* state-changing event for that server. The very last event for each server will not have an `end_time` (it should be `NULL`).

The final report should be ordered by `server_id` and then `start_time`.

| server_id | state | start_time | end_time |

| server-101 | RUNNING | 2023-11-20 09:00:00.000 | 2023-11-20 14:30:00.000 |

| server-101 | STOPPED | 2023-11-20 14:30:00.000 | 2023-11-21 08:00:00.000 |

| server-101 | RUNNING | 2023-11-21 08:00:00.000 | 2023-11-21 17:00:00.000 |

| server-101 | STOPPED | 2023-11-21 17:00:00.000 | 2023-11-22 09:30:00.000 |

| server-101 | RUNNING | 2023-11-22 09:30:00.000 | NULL |

| server-102 | RUNNING | 2023-11-20 10:00:00.000 | 2023-11-20 10:05:00.000 |

| server-102 | REBOOTING | 2023-11-20 10:05:00.000 | 2023-11-20 10:07:00.000 |

| server-102 | RUNNING | 2023-11-20 10:07:00.000 | 2023-11-20 10:10:00.000 |

| server-102 | ERROR | 2023-11-20 10:10:00.000 | 2023-11-20 10:12:00.000 |

| server-102 | REBOOTING | 2023-11-20 10:12:00.000 | 2023-11-20 10:14:00.000 |

| server-102 | RUNNING | 2023-11-20 10:14:00.000 | NULL |

| server-103 | RUNNING | 2023-11-22 09:00:00.000 | NULL |

### Tips for Approaching the Problem

1. **Find the Next Event:** The key to this problem is to find the timestamp of the *next* event for each server. The `LEAD()` window function is the perfect tool for this.
2. **Partition and Order:** When using `LEAD()`, you need to look at each server's history separately, so you must `PARTITION BY server_id`. The history must be in chronological order, so you must `ORDER BY log_timestamp`.
3. **Construct the State Record:** In a Common Table Expression (CTE), select the `server_id`, the `state`, and the `log_timestamp` (which will serve as the `start_time`). Then, add your `LEAD()` function to get the `end_time`.
   * The function will look like:
     LEAD(log_timestamp, 1) OVER (PARTITION BY server_id ORDER BY log_timestamp) AS end_time
4. **Final Selection:** Your final `SELECT` statement can just query directly from the CTE, as all the data has been prepared.

**Your Solution:**

```sql
-- Write your solution here
```
