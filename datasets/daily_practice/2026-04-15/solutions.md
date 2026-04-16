## Puzzle: The Progressive Commission Structure

**The Scenario:** It's payout time for Q1! The company uses a progressive, tiered commission structure to incentivize high performance. Similar to how tax brackets work, a sales representative does not earn a flat rate on their entire sales amount. Instead, their sales are "sliced" into brackets, and they earn the specific rate applied only to the amount within each bracket.

**Your Task:** Write a query to calculate the exact `total_commission` for each sales representative.

The final report should show the `rep_id`, `rep_name`, `total_q1_sales`, and the calculated `total_commission` (rounded to 2 decimal places). Order the results by `total_q1_sales` in descending order.

**Expected Output:**

| **rep_id** | **rep_name** | **total_q1_sales** | **total_commission** |

| 105 | Evan | 300000.00 | 32000.00 |

| 103 | Charlie | 150000.00 | 12500.00 |

| 102 | Bob | 80000.00 | 4900.00 |

| 101 | Alice | 40000.00 | 2000.00 |

| 104 | Diana | 0.00 | 0.00 |

*(Math check for Bob: His first $50,000 earns 5% = $2,500. His remaining $30,000 falls into the second bracket and earns 8% = $2,400. Total = $4,900).*

### Tips for Approaching the Problem

This is a classic problem that can be solved elegantly using a non-equi join and some clever `LEAST()` and `GREATEST()` math!

1. **The Non-Equi Join:** You need to split a single rep's row into multiple rows—one for each commission bracket they touched. `LEFT JOIN` the `sales_team` table to the `commission_brackets` table. The join condition should be `sales_team.total_q1_sales > commission_brackets.tier_start`. (Using a `LEFT JOIN` ensures Diana isn't dropped from the report!).
2. **Calculate the "Slice":** For every matched bracket, you need to figure out how much of the rep's total sales fall *inside* that specific bracket.
   * The "top" of their slice is either their total sales OR the end of the bracket, whichever is smaller. `LEAST(total_q1_sales, tier_end)`.
   * The "bottom" of their slice is the start of the bracket.
   * Subtract the bottom from the top to get the exact dollar amount that belongs in this bracket!
3. **Calculate the Commission:** Multiply the calculated slice by the `commission_rate` for that row.
4. **Aggregate:** Finally, `GROUP BY rep_id, rep_name, total_q1_sales` and `SUM()` the commissions across all the brackets the rep touched. Wrap it in `COALESCE(..., 0)` to handle Diana's $0 payout.

**Your Solution:**

```sql
-- Write your solution here
```

