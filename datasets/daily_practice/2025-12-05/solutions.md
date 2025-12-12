## Puzzle: The Structuring Detection

**The Scenario:** Anti-Money Laundering (AML) laws usually require reporting cash deposits over $10,000. "Structuring" is when a user breaks a large sum into smaller deposits (e.g., $9,000 - $9,999) to avoid detection.

**Your Task:** Identify accounts that have made **3 or more** deposits between **$9,000 and $9,999** (inclusive) within a single day.

The report should show `account_id`, the `date`, and the `suspicious_deposit_count`.

| **account_id** | **date** | **suspicious_deposit_count** |
| -------------------- | -------------- | ---------------------------------- |
| 102                  | 2023-12-05     | 3                                  |

### Tips

1. **Filter Range:** `WHERE amount BETWEEN 9000 AND 9999` and `txn_type = 'DEPOSIT'`.
2. **Group and Count:** Group by account and date, then filter for counts >= 3.

**Your Solution:**

```sql
-- Write your solution here
```
