## Puzzle: MRR Movement Analysis (SaaS Metrics)

**The Scenario:** As a Data Analyst for a SaaS company, leadership wants a breakdown of how the Monthly Recurring Revenue (MRR) changed from **January 2026** to  **February 2026** .

To do this, you need to classify the "MRR Movement" for every user who was active in either January, February, or both.

**Your Task:** Write a query to classify each user into one of the following categories based on their MRR change from January to February:

* **`NEW`** : The user had no MRR in Jan, but has MRR in Feb.
* **`CHURN`** : The user had MRR in Jan, but has no MRR in Feb.
* **`UPGRADE`** : The user's Feb MRR is strictly greater than their Jan MRR.
* **`DOWNGRADE`** : The user's Feb MRR is strictly less than their Jan MRR.
* **`RETAINED`** : The user's MRR in Jan is exactly equal to their MRR in Feb.

The report should show the `user_id`, the `jan_mrr` (if any, else 0), the `feb_mrr` (if any, else 0), the `mrr_delta` (Feb - Jan), and the `movement_category`. Exclude users who had no activity in *both* January and February.

| **user_id** | **jan_mrr** | **feb_mrr** | **mrr_delta** | **movement_category** |
| ----------------- | ----------------- | ----------------- | ------------------- | --------------------------- |
| 101               | 10.00             | 10.00             | 0.00                | RETAINED                    |
| 102               | 10.00             | 25.00             | 15.00               | UPGRADE                     |
| 103               | 50.00             | 15.00             | -35.00              | DOWNGRADE                   |
| 104               | 20.00             | 0.00              | -20.00              | CHURN                       |
| 105               | 0.00              | 30.00             | 30.00               | NEW                         |

### Tips for Approaching the Problem

1. **The MySQL `FULL OUTER JOIN` Problem:** Normally, you would do a `FULL OUTER JOIN` between January's records and February's records. However,  **MySQL does not support `FULL OUTER JOIN`** .
2. **The Pivot/Aggregation Workaround:** Instead of joining, you can filter the table for just January and February, and then `GROUP BY user_id`.
3. **Conditional Aggregation:** Inside your `GROUP BY`, use conditional aggregation to isolate the MRR for each month:
   * `SUM(CASE WHEN billing_month = '2026-01-01' THEN mrr_amount ELSE 0 END) AS jan_mrr`
   * `SUM(CASE WHEN billing_month = '2026-02-01' THEN mrr_amount ELSE 0 END) AS feb_mrr`
4. **Categorization:** Once you have `jan_mrr` and `feb_mrr` side-by-side on the same row, wrap your aggregated query in a CTE. In your final `SELECT`, use a standard `CASE` statement comparing the two columns to determine the `movement_category` and calculate the `mrr_delta`.

**Your Solution:**

```sql
-- Write your solution here
WITH jan_subscriptions AS (
	SELECT 
		user_id,
		mrr_amount AS jan_mrr
	FROM
		user_subscriptions
	WHERE
		MONTH(billing_month) = 01
		AND YEAR(billing_month) = 2026
),
feb_subscriptions AS (
		SELECT 
		user_id,
		mrr_amount AS feb_mrr
	FROM
		user_subscriptions
	WHERE
		MONTH(billing_month) = 02
		AND YEAR(billing_month) = 2026
),
all_users AS (
	SELECT DISTINCT 
		user_id 
	FROM 
		user_subscriptions
)
SELECT 
	au.user_id,
	COALESCE(js.jan_mrr, 0.00) AS jan_mrr,
	COALESCE(fs.feb_mrr, 0.00) AS feb_mrr,
	IFNULL(FS.feb_mrr, 0.00) - IFNULL(js.jan_mrr, 0.00) AS mrr_delta,
	CASE
		WHEN js.jan_mrr IS NULL AND fs.feb_mrr IS NOT NULL THEN 'NEW'
		WHEN js.jan_mrr IS NOT NULL AND fs.feb_mrr IS NULL THEN 'CHURN'
		WHEN js.jan_mrr < fs.feb_mrr THEN 'UPGRADE'
		WHEN js.jan_mrr > fs.feb_mrr THEN 'DOWNGRADE'
		WHEN js.jan_mrr = fs.feb_mrr THEN 'RETAINED'
	END AS movement_category
	
FROM
	all_users au 
LEFT JOIN 
	jan_subscriptions js ON au.user_id = js.user_id 
LEFT JOIN 
	feb_subscriptions fs ON au.user_id = fs.user_id 
WHERE 
	js.jan_mrr IS NOT NULL OR fs.feb_mrr IS NOT NULL
ORDER BY 
	au.user_id;
```
## More efficient alternative for larger datasets since the first solution scans the original table
   three times.

```sql
WITH monthly_mrr AS (
    SELECT 
        user_id,
        SUM(CASE WHEN billing_month = '2026-01-01' THEN mrr_amount ELSE 0 END) AS jan_mrr,
        SUM(CASE WHEN billing_month = '2026-02-01' THEN mrr_amount ELSE 0 END) AS feb_mrr
    FROM 
        user_subscriptions
    WHERE 
        billing_month IN ('2026-01-01', '2026-02-01')
    GROUP BY 
        user_id
)
SELECT 
    user_id,
    jan_mrr,
    feb_mrr,
    (feb_mrr - jan_mrr) AS mrr_delta,
    CASE
        WHEN jan_mrr = 0 AND feb_mrr > 0 THEN 'NEW'
        WHEN jan_mrr > 0 AND feb_mrr = 0 THEN 'CHURN'
        WHEN jan_mrr < feb_mrr THEN 'UPGRADE'
        WHEN jan_mrr > feb_mrr THEN 'DOWNGRADE'
        WHEN jan_mrr = feb_mrr THEN 'RETAINED'
    END AS movement_category
FROM 
    monthly_mrr
ORDER BY 
    user_id;
```