## Puzzle: The Double-Booked Server

**The Scenario:** You are investigating a performance issue in your data center. The servers are designed to be single-threaded, meaning they should strictly run only one job at a time. However, a scheduler bug has caused some jobs to overlap. You need to identify these conflicts.

**Your Task:** Write a query to find every pair of jobs that overlapped in time on the same server.

An overlap occurs if two jobs on the same server share any period of time.

* **Edge Case:** If one job starts exactly when another ends (e.g., Job A ends at 10:30, Job B starts at 10:30), this is **NOT** considered an overlap.
* Strict overlap logic: `Job_A_Start < Job_B_End` AND `Job_A_End > Job_B_Start`.

The report should show the `server_id`, the `job_id_1` (the earlier starting job), the `job_id_2` (the later starting job), and the `overlap_duration_minutes`.

| server_id | job_id_1 | job_id_2 | overlap_duration_minutes |

| srv-B | 4 | 5 | 15.00 |

| srv-C | 6 | 7 | 15.00 |

| srv-D | 8 | 9 | 10.00 |

| srv-D | 9 | 10 | 5.00 |

### Tips for Approaching the Problem

1. **Self-Join:** The core of this problem is comparing every job against every other job. A self-join on the `server_job_log` table is required.
   * Alias the tables as `j1` and `j2`.
2. **Join Conditions:**
   * `j1.server_id = j2.server_id` (Same server).
   * `j1.job_id < j2.job_id` (This avoids comparing a job to itself AND avoids duplicate pairs like A-B and B-A).
3. **Overlap Logic:** Apply the overlap formula in your `WHERE` or `ON` clause:
   * `j1.start_time < j2.end_time`
   * AND `j1.end_time > j2.start_time`
4. **Calculate Duration:** To find the duration of the overlap, you need to find the specific slice of time shared by both jobs.
   * The overlap starts at the *later* of the two start times: `GREATEST(j1.start_time, j2.start_time)`.
   * The overlap ends at the *earlier* of the two end times: `LEAST(j1.end_time, j2.end_time)`.
   * Use `TIMESTAMPDIFF(MINUTE, ...)` between these two calculated points.

**Your Solution:**

```sql
-- Write your solution here
```
