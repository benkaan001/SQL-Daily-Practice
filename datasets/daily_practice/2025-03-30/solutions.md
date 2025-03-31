## Question 1: Loan Balance Contribution by Rate Type
Write a query that returns the rate_type, loan_id, balance, and a column that shows the percentage that the loan's balance contributes to the total balance for loans of the same rate type.  
Output the following columns: rate_type, loan_id, balance, and balance_percentage (rounded to two decimal places).

**Expected Output Format:**

| rate_type | loan_id | balance  | balance_percentage |
| --------- | ------- | -------- | ------------------ |
| variable  | 2       | 5229.12  | 16.17              |
| variable  | 7       | 21149.00 | 65.47              |
| variable  | 5       | 14379.00 | 44.47*             |
| variable  | 11      | 6221.12  | 19.26*             |
| fixed     | 4       | 12727.52 | 45.45              |
| fixed     | 9       | 14996.58 | 54.55              |

*Note: Percentages for 'variable' loans must sum to 100%.

**Your Solution:**
```sql
-- Write your solution here
```


## Question 2: Rate Type Summary Statistics
For each rate_type, calculate the total loan balance and the average interest_rate among loans of that rate_type.  
Return the following columns: rate_type, total_balance, and avg_interest_rate (rounded to two decimal places).

**Expected Output Format:**

| rate_type | total_balance | avg_interest_rate |
| --------- | ------------- | ----------------- |
| fixed     | 27724.10      | 9.81              |
| variable  | 47878.24      | 6.48              |

**Your Solution:**
```sql
-- Write your solution here
```


## Question 3: Loan Balance Percentile Rank within Rate Type
For each loan, compute its percentile rank (as a decimal rounded to two decimal places) of the loan's balance within its rate_type group.  
Assume the highest balance has a rank of 1.00 and the lowest is 0.00.  
Return the following columns: rate_type, loan_id, balance, and percentile_rank.

**Expected Output Format:**

| rate_type | loan_id | balance  | percentile_rank |
| --------- | ------- | -------- | --------------- |
| fixed     | 4       | 12727.52 | 0.00            |
| fixed     | 9       | 14996.58 | 1.00            |
| variable  | 2       | 5229.12  | 0.00            |
| variable  | 11      | 6221.12  | 0.25            |
| variable  | 5       | 14379.00 | 0.50            |
| variable  | 7       | 21149.00 | 1.00            |

**Your Solution:**
```sql
-- Write your solution here
```