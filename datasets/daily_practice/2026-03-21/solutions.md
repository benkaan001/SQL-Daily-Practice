## Puzzle: The Robo-Advisor Portfolio Rebalancing

**The Scenario:** You are a data engineer at a wealth management startup. You are building the core engine for a "robo-advisor." When an investor's portfolio drifts away from their target allocations, the system must automatically calculate exactly how many shares of each stock to buy or sell to get them perfectly balanced.

**Your Task:** Write a query that determines the trade actions for each investor.

1. Calculate the total current dollar value of each investor's portfolio.
2. Calculate the target dollar value for each ticker based on the investor's `target_allocations`.
3. Convert the target dollar value into `target_shares` using current market prices.
4. Determine the difference between `target_shares` and `current_shares`.
5. Recommend the `trade_action` ('BUY' or 'SELL') and the absolute number of `shares_to_trade`.

*(Note: If no action is needed, it should theoretically say 'HOLD', but all test scenarios require action here).*

The final report should show the `investor_id`, `ticker`, `current_shares`, `target_shares`, `trade_action`, and `shares_to_trade`. Order the results by `investor_id` and `ticker`.

**Expected Output:**

| **investor_id** | **ticker** | **current_shares** | **target_shares** | **trade_action** | **shares_to_trade** |

| 101 | AAPL | 50 | 40 | SELL | 10 |

| 101 | MSFT | 25 | 30 | BUY | 5 |

| 102 | AMZN | 0 | 40 | BUY | 40 |

| 102 | GOOG | 48 | 24 | SELL | 24 |

| 103 | AAPL | 0 | 90 | BUY | 90 |

| 103 | TSLA | 30 | 0 | SELL | 30 |

### Tips for Approaching the Problem

1.**The "Full Outer Join" Workaround:** An investor might need to buy a stock they don't currently own (it exists in targets but not holdings), or sell a stock down to zero (it exists in holdings but not targets). Because MySQL does not support `FULL OUTER JOIN`, you should start by creating a "master list" of all relevant `investor_id` and `ticker` combinations. You can easily do this with a `UNION` between the `portfolio_holdings` and `target_allocations` tables in a Common Table Expression (CTE).

2.**Calculate Total Portfolio Value:** Once you have your master list, `LEFT JOIN` it back to the `portfolio_holdings` and `stock_prices` tables. Calculate the value of each holding (`shares * price`). Then, use a window function like `SUM(holding_value) OVER (PARTITION BY investor_id)` to append the total portfolio value to every row for that investor.

3.**Calculate the Targets:** Now `LEFT JOIN` to the `target_allocations` table to get the desired percentage. The formula for the target shares is: `(total_portfolio_value * (target_pct / 100.0)) / price`.

4.**Handle NULLs Carefully:** Because you built a master list, many joins will result in `NULL` values (e.g., if they own 0 shares of a target stock, or if their target for a held stock is 0%). Wrap your columns in `COALESCE(..., 0)` to ensure the math works correctly.

5.**The Action Logic:** In your final `SELECT`, compare the `target_shares` to the `current_shares`. Use a `CASE` statement to label it 'BUY' if target > current, and 'SELL' if target < current. Use the `ABS()` function to ensure the `shares_to_trade` is always a positive number.

**Your Solution:**

```sql

-- Write your solution here

```
