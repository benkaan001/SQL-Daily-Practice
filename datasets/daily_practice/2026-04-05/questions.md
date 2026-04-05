## Puzzle: The Prorated Monthly Revenue (Cross-Month Bookings)

**The Scenario:** The Finance team needs to close the books and report on recognized revenue for the spring season. However, many hotel guests have stays that bridge across multiple calendar months.

Revenue is recognized on a nightly basis. For example, if a guest checks in on March 30th and checks out on April 2nd, March should receive 2 nights of revenue (the 30th and 31st), and April should receive 1 night (the 1st). *(Note: Guests are not billed for their checkout day).*

**Your Task:** Write a query to calculate the total recognized revenue and the total nights stayed for every calendar month represented in the database.

The final report should show the `revenue_month` (formatted as 'YYYY-MM'), the `total_nights_stayed` across all guests for that month, and the `recognized_revenue`. Order the results chronologically.

**Expected Output:**

| **revenue_month** | **total_nights_stayed** | **recognized_revenue** |

| 2026-03 | 10 | 1110.00 |

| 2026-04 | 40 | 4060.00 |

| 2026-05 | 3 | 280.00 |

### Tips for Approaching the Problem

1. **The Problem with Ranges:** The data is stored as a date range (`check_in_date` to `check_out_date`), but you need to aggregate by the individual calendar months those dates touch.
2. **Explode the Dates (WITH RECURSIVE):** Use a `WITH RECURSIVE` Common Table Expression (CTE) to generate a row for *every single night* a guest stays.
   * Your anchor query should select the `check_in_date` as the `stay_date`.
   * Your recursive query should add 1 day to the `stay_date` until it reaches the day *before* the `check_out_date` (since the checkout day itself is not a billable stay night).
3. **Extract the Month:** Now that you have a "skeleton" table where every single row represents one billed night for a guest, you can use `DATE_FORMAT(stay_date, '%Y-%m')` to figure out exactly which month that specific night belongs to.
4. **Aggregate:** Finally, `GROUP BY` the formatted month string. Use `COUNT(*)` to get the `total_nights_stayed` and `SUM(room_rate)` to get the `recognized_revenue` for that month.

**Your Solution:**

```sql
-- Write your solution here
```
