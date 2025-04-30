## Question 1: Cities with Population Density Above Average

Find all cities where the population density (population / area, rounded to the nearest integer) is **above the average density** (excluding cities with area = 0).
Output city, country, and density.

**Expected Output:**

| city        | country     | density |
| ----------- | ----------- | ------- |
| Metropolis  | Countryland | 2000    |
| Gotham      | Islander    | 5000    |

**Your Solution:**
```sql
WITH overall_density AS (
  SELECT
  	ROUND(AVG(population/area)) AS overall_avg_density
  FROM
  	cities
  WHERE
  	area IS NOT NULL
  	AND area <> 0
), city_averages AS (
  SELECT
  	city,
  	country,
    ROUND(AVG(population/area)) AS density
  FROM
  	cities
  WHERE
  	area IS NOT NULL AND area <> 0
  GROUP BY
  	city,
  	country
)
SELECT
	ca.city,
    ca.country,
    ca.density
FROM
	city_averages ca
WHERE
	ca.density > (SELECT overall_avg_density FROM overall_density);
```

---

## Question 2: Country with the Highest Total Population

Find the country (or countries) with the highest total population across all its cities.
Output country and total_population.

**Expected Output:**

| country     | total_population |
| ----------- | ---------------- |
| Islander    | 15000000         |

**Your Solution:**
```sql
WITH ranked_population AS (
  SELECT
      country,
      SUM(population) AS total_population,
  	  DENSE_RANK() OVER (ORDER BY SUM(population) DESC) AS rnk
  FROM
      cities
  GROUP BY
      country
)
SELECT
	country,
    total_population
FROM
	ranked_population
WHERE
	rnk = 1;
```

---

## Question 3: Cities with Zero or Undefined Density

Find all cities where the area is zero (so density is undefined or infinite).
Output city and country.

**Expected Output:**

| city      | country   |
| --------- | --------- |
| Coastcity | Oceanland |
| Oceanview | Seaside   |

**Your Solution:**
```sql
SELECT
	city,
    country
FROM
	cities
WHERE
	area = 0;
```

---
