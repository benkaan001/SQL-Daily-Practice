## Puzzle: The Missing Invoice Audit

**The Scenario:** You are assisting the accounting department with an end-of-quarter compliance audit. By company policy, `invoice_number`s are strictly sequential. A missing invoice number is a massive red flag indicating that a record may have been improperly deleted or that a transaction failed silently.

**Your Task:** Write a query to find all gaps in the `invoice_number` sequence. Your report must explicitly state the boundaries of each missing range.

The report should show the `missing_range_start` and the `missing_range_end` for every gap detected in the table. If a gap is only one number long, the start and end values will be the same.

**Expected Output:**

| **missing_range_start** | **missing_range_end** |
| ----------------------------- | --------------------------- |
| 1004                          | 1005                        |
| 1008                          | 1008                        |
| 1012                          | 1014                        |

### Tips for Approaching the Problem

This is a classic variation of the "Gaps and Islands" problem, focused purely on finding the gaps.

1. **Look Ahead to the Next Row:** You need to compare each invoice number to the *next* invoice number in the table. The `LEAD()` window function is exactly what you need. Order the window by `invoice_number`.
2. **Calculate the Next Expected Number:** In a perfect sequence, the next invoice number should simply be the `current_invoice_number + 1`.
3. **Identify the Gap Boundaries:** In a Common Table Expression (CTE), fetch the current `invoice_number` and the `next_invoice_number` (from your `LEAD` function).
   * A gap *starts* immediately after the current invoice number: `invoice_number + 1`.
   * A gap *ends* immediately before the next invoice number: `next_invoice_number - 1`.
4. **Filter for Gaps:** In your final `SELECT` statement, query from your CTE. Filter the results so you only keep rows where a gap actually exists. A gap exists if the `next_invoice_number` is strictly greater than the `current_invoice_number + 1`.

**Your Solution:**

```sql
-- Write your solution here
```
