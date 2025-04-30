## Question 1: Cities with Above National Average Home Prices

Find all cities where the **average home price** is higher than the **national average home price**.
Output the city names.

**Expected Output:**

| city          |
| ------------- |
| San Francisco |
| Santa Clara   |
| Mountain View |

**Your Solution:**
```sql
WITH national_avg AS (
  SELECT
  	AVG(mkt_price) AS national_avg_price
  FROM
  	home_prices
), city_avg AS(
  SELECT
      city,
  	  AVG(mkt_price) AS city_avg_price
  FROM
      home_prices
  GROUP BY
  	  city
)
SELECT
	city
FROM
	city_avg
WHERE
	city_avg_price > (SELECT national_avg_price FROM national_avg);
```
---

## Question 2: State with the Highest Median Home Price

Find the state(s) with the **highest median home price** across all homes.
Output state and median_price.

**Expected Output:**

| state | median_price |
| ----- | ------------ |
| CA    | 679297       |

**Your Solution:**
```sql
WITH state_ranks AS (
  SELECT
  	state,
  	mkt_price,
  	ROW_NUMBER() OVER (PARTITION BY state ORDER BY mkt_price) AS state_rnk,
  	COUNT(*) OVER (PARTITION BY state) AS state_count
  FROM
  	home_prices
), state_median_candidates AS (
  SELECT
  	state,
  	mkt_price
  FROM
  	state_ranks
  WHERE
  	state_rnk <= CEILING((state_count+1) / 2.0)
  	AND state_rnk >= FLOOR((state_count+1) / 2.0)
), state_medians AS (
  SELECT
  	state,
  	ROUND(AVG(mkt_price)) AS actual_median_price
  FROM
  	state_median_candidates
  GROUP BY
  	state
), ranked_state_medians AS (
  SELECT
  	state,
  	actual_median_price AS median_price,
  	DENSE_RANK() OVER (ORDER BY actual_median_price DESC) AS rnk
  FROM
  	state_medians
)
SELECT
	state,
    median_price
FROM
	ranked_state_medians
WHERE
	rnk = 1;
```
---

## Question 3: City with the Largest Price Range

Find the city (or cities) with the **largest difference** between the highest and lowest home prices.
Output city and price_range.

**Expected Output:**

| city          | price_range |
| ------------- | ----------- |
| San Francisco | 1765997     |

**Your Solution:**
```sql
WITH price_ranges AS(
  SELECT
  	city,
  	MAX(mkt_price) - MIN(mkt_price) AS price_range
  FROM
  	home_prices
  GROUP BY
  	city
), ranked_price_ranges AS (
  SELECT
  	city,
  	price_range,
  	DENSE_RANK() OVER (ORDER BY price_range DESC) AS rnk
  FROM
  	price_ranges
)
SELECT
	city,
    price_range
FROM
	ranked_price_ranges
WHERE
	rnk = 1;
```
---

