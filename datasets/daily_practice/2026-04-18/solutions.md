## Puzzle: The Z-Score Anomaly Detector (Fraud Prevention)

**The Scenario:** You work on the Fraud Detection team at a bank. A common indicator of a stolen credit card is a transaction that is significantly larger than the user's typical spending habits. You need to build a dynamic alert system that flags statistical outliers based on each user's unique history.

**Your Task:** Write a query to flag any transaction that is mathematically anomalous compared to the user's past behavior.

An anomalous transaction must meet **both** of the following rules:

1. **Sufficient History:** The user must have at least **5 strictly prior** transactions in their history before a baseline can be established.
2. **Statistical Outlier:** The current transaction's `amount` must be strictly greater than the user's historical average *plus* 2 times their historical standard deviation.
   *(Formula: `amount > prior_avg + (2 * prior_stddev)`)* .

The final report should show the `transaction_id`, `user_id`, `transaction_timestamp`, `merchant_name`, `amount`, and the dynamically calculated `z_score_threshold` (the prior average + 2 * prior standard deviation, rounded to 2 decimal places). Order the results by `transaction_id`.

**Expected Output:**

| **transaction_id** | **user_id** | **transaction_timestamp** | **merchant_name** | **amount** | **z_score_threshold** |

| 7 | 101 | 2026-04-18 14:00:00 | Electronics Store | 450.00 | 13.63 |

| 18 | 104 | 2026-04-18 11:00:00 | Luxury Travel | 1500.00 | 106.12 |

*(Note: The exact threshold decimal might vary by a few pennies depending on whether your SQL dialect defaults to a sample or population standard deviation function. For this puzzle, default to `STDDEV()` or `STDDEV_POP()`).*

### Tips for Approaching the Problem

1. **Beware Data Leakage!** You cannot simply `AVG(amount) OVER (PARTITION BY user_id)`. If you do that, the $1500 anomaly itself will be factored into the user's average, dragging the threshold up and potentially hiding the fraud! You must only look at *past* data.
2. **The "Look-Back" Window Frame:** Use window functions with a specific frame clause to look only at prior history: `ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING`. This evaluates all rows from the beginning of the user's history  *up to the row just before the current one* .
3. **Calculate the Baselines:** In a Common Table Expression (CTE), calculate three rolling metrics for every transaction using the frame clause from Tip 2:
   * `COUNT(amount)` to get the `prior_transaction_count`.
   * `AVG(amount)` to get the `prior_avg`.
   * `STDDEV(amount)` to get the `prior_stddev`.
4. **Apply the Rules:** In your final `SELECT` statement, query from your CTE.
   * Filter out rows where `prior_transaction_count < 5`.
   * Filter for rows where the `amount` is greater than `prior_avg + (2 * prior_stddev)`.

**Your Solution:**

```sql
-- Write your solution here
```

