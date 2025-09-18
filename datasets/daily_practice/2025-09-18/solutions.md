## Puzzle: The Realized Gains Calculator (FIFO)

**The Scenario:** As a financial data analyst, you need to calculate the "realized capital gains" for each user and for each stock they have traded. A realized gain occurs only when a stock is sold. The calculation must follow the First-In, First-Out (FIFO) accounting principle. This means that when shares are sold, they are assumed to be the ones that were purchased earliest.

**Your Task:** Write a query that calculates the total `realized_gain` for each `user_id` and `ticker_symbol` pair. The gain from a sale is calculated as `(sell_price - buy_price) * quantity_sold`. You must correctly match the shares sold against the shares bought using the FIFO method.

The final report should show the `user_id`, `ticker_symbol`, and the total `realized_gain`. Only include users and tickers where at least one sale has occurred.

| **user_id** | **ticker_symbol** | **realized_gain** |
| ----------------- | ----------------------- | ----------------------- |
| 101               | AAPL                    | 160.00                  |
| 101               | TSLA                    | 60.00                   |
| 102               | GOOG                    | 200.00                  |
| 103               | MSFT                    | 1150.00                 |

**Your Solution:**

```sql
-- Write your solution here
```
