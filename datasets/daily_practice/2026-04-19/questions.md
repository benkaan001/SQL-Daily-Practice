## Puzzle: The Password Sharing Crackdown (Peak Concurrency)

**The Scenario:** A major streaming service allows a maximum of **2 concurrent streams** per account on its standard plan. The security team wants to identify accounts that are likely sharing their passwords with friends or family outside their household.

**Your Task:** Write a query to find all accounts that had **3 or more** streams running at the exact same time.

Calculate the absolute maximum number of simultaneous streams (`max_concurrent_streams`) for every account, and only return the accounts that exceeded the allowed limit of 2.

Order the results by `max_concurrent_streams` in descending order.

**Expected Output:**

| **account_id** | **max_concurrent_streams** |

| 104 | 4 |

| 102 | 3 |

*(Note: Account 105 has one stream ending at exactly 11:00:00 and another starting at 11:00:00. This is considered sequential, not concurrent. The peak for 105 should be 1).*

### Tips for Approaching the Problem

Finding peak concurrency is notoriously difficult with standard joins because multiple intervals can overlap in complex ways. The most elegant solution is to convert the time intervals into a chronological "stream of events" using `UNION ALL`.

1. **Unpivot to a Timeline:** Break every single session into two separate rows:
   * A "Start" event (which adds +1 to the current stream count).
   * An "End" event (which adds -1 to the current stream count).
   * Create a CTE using `UNION ALL` that selects `account_id`, `stream_start AS event_time`, and `1 AS stream_change`, united with `stream_end AS event_time` and `-1 AS stream_change`.
2. **Handle Exact Overlaps:** What happens if a stream ends at the exact same second another begins (like Account 105)? To avoid falsely inflating the concurrency count, you must process the `-1` (End) *before* the `+1` (Start) if they share the exact same `event_time`.
3. **Calculate the Running Total:** Now that you have a single timeline of +1s and -1s, use a window function to calculate the running sum of streams for each account: `SUM(stream_change) OVER (PARTITION BY account_id ORDER BY event_time, stream_change ASC)`.
4. **Find the Peak:** In your final `SELECT`, group by `account_id` and find the `MAX()` of your running total.
5. **Filter the Violators:** Add a `HAVING` clause to only return accounts where this maximum peak is greater than 2.

**Your Solution:**

```sql
-- Write your solution here
```
