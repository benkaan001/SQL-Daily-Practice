## Question 1: Countries with No Megacities

**Task:** Find all countries that do not have any cities with a population of 1 million or more listed in the `cities` table. For these countries, also list their most populous city (if any city is listed for them at all).

**Expected Output:**
| country_name                 | country_population | most_populous_city_name | city_population |
|------------------------------|--------------------|-------------------------|-----------------|

### SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 2: GNP Gap Analysis Within Continents

**Task:** For each continent, find the country with the highest Gross National Product (GNP). Then, for all other countries on the same continent, calculate the difference between their GNP and the highest GNP. From this list, identify the 5 largest GNP differences globally

**Expected Output:**
| continent     | country_name  | gnp      | top_country_gnp | gnp_gap    |
| ------------- | ------------- | -------- | --------------- | ---------- |
| Africa        | South Africa  | 2352.00  | 116729.00       | 114377.00  |
| Asia          | Japan         | 1813.00  | 3787042.00      | 3785229.00 |
| Europe        | Germany       | 12178.00 | 2133367.00      | 2121189.00 |
| North America | United States | 15846.00 | 8510700.00      | 8494854.00 |
| South America | Brazil        | 19770.00 | 776739.00       | 756969.00  |

### SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 3: Urbanization Concentration Analysis

**Task:** Calculate the total population of all listed cities for each country. Then, calculate an "Urbanization Ratio" by dividing this total city population by the country's total population. Find all countries where this urbanization ratio is greater than 25% and their total country population is less than the average population of all countries in their continent.

**Expected Output:**
| country_name           | continent     | urbanization_ratio | country_population | continent_avg_population |
| ---------------------- | ------------- | ------------------ | ------------------ | ------------------------ |
| Armenia                | Asia          | 0.35               | 3520000            | 123,696,828              |
| Chile                  | South America | 0.31               | 15211000           | 41,311,750               |
| Ecuador                | South America | 0.29               | 12646000           | 41,311,750               |
| Hong Kong              | Asia          | 0.49               | 6782000            | 123,696,828              |
| South Korea            | Asia          | 0.49               | 46844000           | 123,696,828              |
| Lebanon                | Asia          | 0.34               | 3282000            | 123,696,828              |
| Libyan Arab Jamahiriya | Africa        | 0.30               | 5605000            | 31,789,211               |
| Peru                   | South America | 0.25               | 25662000           | 41,311,750               |
| Singapore              | Asia          | 1.13               | 3567000            | 123,696,828              |
| Uruguay                | South America | 0.37               | 3337000            | 41,311,750               |

### SQL Solution
```sql
-- Write your SQL query here
```