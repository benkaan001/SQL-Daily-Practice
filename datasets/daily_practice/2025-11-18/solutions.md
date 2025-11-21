## Puzzle: The "Double Click" Detector

**The Scenario:** As a UX researcher, you are investigating user frustration. One common signal is "rage clicking" or accidental double-clicking, where a user clicks the same button multiple times in very rapid succession. This often indicates that the UI is unresponsive or confusing.

**Your Task:** Write a query to identify all "Double Click" events. A double click is defined as a `CLICK` event that occurs **less than 500 milliseconds** (0.5 seconds) after a *previous* `CLICK` event by the **same user** on the **same `element_id`** within the  **same session** .

The final report should show the `user_id`, `session_id`, `element_id`, the `timestamp_of_first_click`, the `timestamp_of_double_click`, and the `time_diff_ms` (the difference in milliseconds).

| user_id | session_id | element_id | timestamp_of_first_click | timestamp_of_double_click | time_diff_ms |

| 101 | sess_A | submit_btn | 2023-11-28 10:00:01.000 | 2023-11-28 10:00:01.250 | 250 |

| 103 | sess_C | refresh_icon | 2023-11-28 12:00:00.000 | 2023-11-28 12:00:00.100 | 100 |

| 103 | sess_C | refresh_icon | 2023-11-28 12:00:00.100 | 2023-11-28 12:00:00.300 | 200 |

| 105 | sess_E | read_more_link | 2023-11-28 14:00:00.000 | 2023-11-28 14:00:00.450 | 450 |

### Tips for Approaching the Problem

1. **Isolate Clicks:** First, filter the table to only include rows where `interaction_type = 'CLICK'`.
2. **Look Back:** The core of the problem is comparing a click to the one that happened immediately before it. The `LAG()` window function is perfect for this.
3. **Partition Correctly:** You need to compare clicks that share the same `user_id`, `session_id`, and `element_id`. These columns should be in your `PARTITION BY` clause. Order by `interaction_timestamp`.
4. **Calculate Difference in Milliseconds:** Use `LAG()` to get the `previous_click_timestamp`. Then, calculate the difference. In MySQL/MariaDB, `TIMESTAMPDIFF(MICROSECOND, prev_ts, current_ts) / 1000` gives milliseconds.
5. **Filter:** In the outer query, select only the rows where `time_diff_ms` is less than 500.

**Your Solution:**

```sql
-- Write your solution here
```