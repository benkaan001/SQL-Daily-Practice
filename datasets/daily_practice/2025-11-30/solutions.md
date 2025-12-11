## Puzzle: The Peak Concurrency Analyzer

**The Scenario:** As a Database Administrator (DBA), you need to capacity plan for your servers. The average number of connections isn't enough; you need to know the *absolute maximum* number of simultaneous connections (Peak Concurrency) each server handled and exactly *when* that peak occurred.

**Your Task:** Write a query to calculate the `peak_concurrent_connections` for each server and the `peak_start_time` when that maximum concurrency level was first reached on  **'2023-11-30'** .

The final report should show the `server_name`, the `peak_concurrent_connections`, and the `peak_start_time`.

| **server_name** | **peak_concurrent_connections** | **peak_start_time** |
| --------------------- | ------------------------------------- | ------------------------- |
| DB-01                 | 3                                     | 2023-11-30 10:10:00.000   |
| DB-02                 | 3                                     | 2023-11-30 14:20:00.000   |
| DB-03                 | 1                                     | 2023-11-30 16:00:00.000   |

### Tips for Approaching the Problem

1. **Unpivot Events:** The core difficulty here is that "overlap" isn't a single row. To measure concurrency, you must treat time as a stream of events.
   * Create a CTE that splits every row into two separate events: a **+1** event at `connect_time` and a **-1** event at `disconnect_time`.
   * Use `UNION ALL` to combine these into a single list of `(server_name, event_time, change_value)`.
2. **Calculate Running Total:** Use a window function (`SUM()`) over the unified stream of events. Partition by `server_name` and order by `event_time`.
   * *Crucial Detail:* If a connect and disconnect happen at the exact same millisecond, process the **connect (+1)** first to capture the peak, or the **disconnect (-1)** first if you want to be conservative. Usually, ordering `change_value` descending puts +1 before -1.
3. **Identify the Peak:** Once you have the running total (current connections) for every single second where a change occurred, simply rank them.
   * Use `RANK()` or `ROW_NUMBER()` ordered by the `running_total` DESC to find the highest number.
4. **Aggregate per Server:** In your final query, filter for the top-ranked moment (Rank = 1) for each server to get the `peak_concurrent_connections` and the `peak_start_time`.

**Your Solution:**

```sql
-- Write your solution here
```
