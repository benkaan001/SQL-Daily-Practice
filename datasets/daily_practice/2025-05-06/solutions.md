## Question 1: Top 2 Purposes by Total Miles

Find the top 2 business purpose categories by total mileage.
Output the purpose and total miles, ordered by total miles descending.

**Expected Output:**

| purpose         | total_miles |
| --------------  | ----------- |
| Customer Visit  | 47.2        |
| Airport/Travel  | 42.5        |

**Your Solution:**
```sql
SELECT
	purpose,
    ROUND(SUM(miles), 2) AS total_miles
FROM
	rides
GROUP BY
	purpose
ORDER BY
	total_miles DESC
LIMIT 2;
```

---

## Question 2: Average Miles per Purpose

For each business purpose, calculate the average miles per ride.
Output the purpose and average_miles, rounded to two decimal places.

**Expected Output:**

| purpose         | average_miles |
| --------------- | ------------- |
| Airport/Travel  | 14.17         |
| Meeting         | 7.53          |
| Meal/Entertain  | 8.02          |
| Customer Visit  | 15.73         |
| Errand/Supplies | 4.15          |

**Your Solution:**
```sql
SELECT
	purpose,
    ROUND(AVG(miles), 2) AS average_miles
FROM
	rides
GROUP BY
	purpose;
```

---

## Question 3: Days with Multiple Purposes

Find all dates where there were at least 2 different business purposes for rides.
Output the date and the count of distinct purposes.

**Expected Output:**

| ride_date  | purpose_count |
|------------|--------------|
| 2022-01-01 | 3            |
| 2022-01-02 | 2            |
| 2022-01-03 | 2            |
| 2022-01-04 | 2            |
| 2022-01-05 | 2            |
| 2022-01-06 | 2            |
| 2022-01-07 | 2            |

**Your Solution:**
```sql
SELECT
	DATE(start_date) AS start_date,
    COUNT(DISTINCT purpose) AS purpose_count
FROM
	rides
GROUP BY
	DATE(start_date)
HAVING
	COUNT(DISTINCT purpose) >= 2;
```