## Puzzle: The Wash Trading Detector

**The Scenario:** Market integrity is paramount. You are tasked with writing a query for the compliance department to identify "Wash Trading." This occurs when a user buys and sells the same asset in a short window of time with roughly the same volume to fake liquidity.

**Your Task:** Write a query to identify all pairs of trades that constitute a "Wash Trade."

**The Rules:**

A pair of trades $(T_1, T_2)$ for the same `user_id` and `asset_id` is a Wash Trade if:

1. $T_1$ and $T_2$ are of opposite types (one is `BUY`, the other is `SELL`).
2. $T_2$ occurs strictly after $T_1$, but within **5 minutes** of $T_1$'s timestamp.
3. The `quantity` of $T_2$ is within **10%** of the `quantity` of $T_1$.
   * (Formula: $0.9 \times Q_1 \le Q_2 \le 1.1 \times Q_1$).

The final report should show the `user_id`, the `asset_id`, the `first_trade_id`, the `second_trade_id`, and the `time_gap_seconds`.

**Expected Output:**

| **user_id** | **asset_id** | **first_trade_id** | **second_trade_id** | **time_gap_seconds** |
| ----------------- | ------------------ | ------------------------ | ------------------------- | -------------------------- |
| 101               | BTC                | 1                        | 2                         | 150                        |
| 101               | ETH                | 3                        | 4                         | 299                        |
| 104               | ETH                | 9                        | 10                        | 60                         |
| 104               | ETH                | 11                       | 12                        | 120                        |

### Tips for Approaching the Problem

1. **Self-Join Strategy:** Since you are looking for pairs of rows within the same table, a self-join is the most direct approach.
   * `JOIN trade_ledger t1 ON trade_ledger t2`
2. **Filtering in the Join:** Apply as many rules as possible in the `ON` or `WHERE` clause:
   * Match `user_id` and `asset_id`.
   * Ensure `t1.trade_type != t2.trade_type`.
   * Ensure `t2.trade_timestamp > t1.trade_timestamp`.
3. **Handle Time Constraints:** Use `TIMESTAMPDIFF(SECOND, t1.trade_timestamp, t2.trade_timestamp)` to ensure the gap is $\le 300$ seconds.
4. **Volume Tolerance:** Use mathematical comparisons to check if the second quantity is within the $\pm 10\%$ range of the first.
5. **Eliminating Overlaps:** In a real-world scenario, one trade might trigger multiple "wash" pairs if the user is trading very fast. For this exercise, simple logic focusing on the time and quantity constraints will suffice.

**Your Solution:**

```sql
-- Write your solution here
```

