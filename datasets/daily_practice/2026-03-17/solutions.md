## Puzzle: The True Middle (Calculating the Median)

**The Scenario:** The CEO wants a report on the "typical" salary within each department to help with budget planning. However, the Finance Director pointed out that using the standard `AVG()` function is misleading because a few extremely highly-paid executives are skewing the averages upward. To get a true picture of a typical employee's pay, they need the **Median** salary.

**Your Task:** Write a query to calculate the exact median salary for each department.

*Rules:*

1. If a department has an **odd** number of employees, the median is the exact middle salary.
2. If a department has an **even** number of employees, the median is the average of the *two* middle salaries.
3. **You may not use any hypothetical built-in median functions.** You must derive the answer using standard window functions and aggregations.

The final report should show the `department` and the `median_salary` (rounded to two decimal places). Order the results alphabetically by department.

**Expected Output:**

| **department** | **median_salary** |
| -------------------- | ----------------------- |
| Engineering          | 105000.00               |
| HR                   | 55000.00                |
| Marketing            | 75000.00                |
| Sales                | 60000.00                |

### Tips for Approaching the Problem

This is a classic technical interview question designed to test your mastery of window functions!

1. **Rank the Salaries:** First, you need to order the salaries within each department from lowest to highest. Use the `ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary ASC)` window function to assign a sequential rank to every employee in a department. Let's call this `row_num`.
2. **Count the Total Employees:** In the exact same Common Table Expression (CTE), you also need to know the total number of people in that department. Use `COUNT(*) OVER (PARTITION BY department)` to attach the total headcount to every row. Let's call this `total_count`.
3. **Find the Middle Target(s):** The mathematical trick to finding the median row index (or indices) relies on the `total_count`.
   * The "lower" middle row is at `FLOOR((total_count + 1) / 2.0)`.
   * The "upper" middle row is at `CEIL((total_count + 1) / 2.0)`.
   * *Note: If the count is odd (e.g., 5), both of these formulas will resolve to exactly 3. If the count is even (e.g., 6), they will resolve to 3 and 4, respectively.*
4. **Filter for the Middle:** In your main query, select from your CTE and filter the rows using a `WHERE` clause. Keep only the rows where the `row_num` equals either the lower middle calculation OR the upper middle calculation.
5. **Average the Results:** Finally, `GROUP BY department` and take the `AVG(salary)`. Because of your filter, this average will only be calculating against the 1 or 2 middle rows you isolated, perfectly satisfying the rules for both odd and even counts!

**Your Solution:**

```sql
-- Write your solution here
```
