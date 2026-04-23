## Puzzle: The Business Days SLA Calculator

**The Scenario:** Customer support has a strict Service Level Agreement (SLA) to resolve tickets as quickly as possible. However, the SLA timer pauses on weekends (Saturdays and Sundays) and official company holidays. The Operations Manager needs a report showing exactly how many actual *business days* each ticket took to resolve.

**Your Task:** Write a query to calculate the `business_days_taken` to resolve each ticket.

*Rules for the calculation:*

1. The `created_date` itself is considered "Day 0" and does not count towards the total.
2. Count every valid business day *after* the `created_date` up to and including the `resolved_date`.
3. If a ticket is created and resolved on the exact same day, it took `0` business days.
4. Exclude weekends. In MySQL, you can use `DAYOFWEEK(date)` where 1 = Sunday, 7 = Saturday.
5. Exclude dates found in the `company_holidays` table.

The final report should show the `ticket_id`, `created_date`, `resolved_date`, and the `business_days_taken`. Order by `ticket_id`.

**Expected Output:**

| **ticket_id** | **created_date** | **resolved_date** | **business_days_taken** |

| 1 | 2026-04-06 | 2026-04-07 | 1 |

| 2 | 2026-04-10 | 2026-04-14 | 2 |

| 3 | 2026-04-01 | 2026-04-06 | 2 |

| 4 | 2026-04-29 | 2026-05-06 | 4 |

| 5 | 2026-04-15 | 2026-04-15 | 0 |

*(Example Check for Ticket 3: Days to evaluate are Apr 2, Apr 3, Apr 4, Apr 5, Apr 6. Apr 3 is a Holiday. Apr 4 & 5 are the weekend. That leaves Apr 2 and Apr 6, making 2 valid business days).*

### Tips for Approaching the Problem

Since MySQL does not have a built-in `NETWORKDAYS` function like Excel, calculating this dynamically requires generating the days between the start and end dates.

1. **The Recursive "Date Exploder":** Create a `WITH RECURSIVE` CTE to generate a row for every single day a ticket was open.
   * Your anchor query should select the `ticket_id` and `created_date + INTERVAL 1 DAY AS check_date` from `support_tickets` where `created_date < resolved_date`.
   * Your recursive query should add 1 day to `check_date` until it matches the `resolved_date`.
2. **Filter the Exploded Dates:** Once you have a CTE containing every intermediate day for every ticket, use a `LEFT JOIN` against the `company_holidays` table on your `check_date`.
3. **Count the Valid Days:** `GROUP BY ticket_id`. When calculating your count, use conditional logic to only count the days that are valid:
   * `SUM(CASE WHEN DAYOFWEEK(check_date) NOT IN (1, 7) AND holiday_date IS NULL THEN 1 ELSE 0 END)`
4. **Rejoin and Handle Same-Day Resolutions:** Because tickets resolved on the exact same day were excluded from the recursive CTE (since they have 0 days in between), `LEFT JOIN` your aggregated counts back to the main `support_tickets` table. Use `COALESCE` to output `0` for any missing counts!

**Your Solution:**

```sql
-- Write your solution here
```

