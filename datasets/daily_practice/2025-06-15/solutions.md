## Question 1: Neighboring Cities by Population

**Task:** For every city with a population over 3 million, find another city **in the same country** with a population that is within 20% (either higher or lower) of its own. List the primary city's name and population, alongside the neighboring city's name and population. Ensure you don't list a city paired with itself.

**Expected Output:**
| primary_city_name  | primary_city_population | neighboring_city_name | neighboring_city_pop |
| ------------------ | ----------------------- | --------------------- | -------------------- |
| Sydney             | 3276207                 | Melbourne             | 2865329              |
| Calcutta [Kolkata] | 4399819                 | Chennai (Madras)      | 3841396              |
| Chennai (Madras)   | 3841396                 | Calcutta [Kolkata]    | 4399819              |
| Peking             | 7472000                 | Chongqing             | 6351600              |
| Chongqing          | 6351600                 | Peking                | 7472000              |
| Chongqing          | 6351600                 | Tianjin               | 5286800              |
| Tianjin            | 5286800                 | Wuhan                 | 4344600              |
| Tianjin            | 5286800                 | Harbin                | 4289800              |
| Tianjin            | 5286800                 | Shenyang              | 4265200              |
| Tianjin            | 5286800                 | Kanton [Guangzhou]    | 4256300              |
| Wuhan              | 4344600                 | Harbin                | 4289800              |
| Wuhan              | 4344600                 | Shenyang              | 4265200              |
| Wuhan              | 4344600                 | Kanton [Guangzhou]    | 4256300              |
| Harbin             | 4289800                 | Wuhan                 | 4344600              |
| Harbin             | 4289800                 | Shenyang              | 4265200              |
| Harbin             | 4289800                 | Kanton [Guangzhou]    | 4256300              |
| Shenyang           | 4265200                 | Wuhan                 | 4344600              |
| Shenyang           | 4265200                 | Harbin                | 4289800              |
| Shenyang           | 4265200                 | Kanton [Guangzhou]    | 4256300              |
| Kanton [Guangzhou] | 4256300                 | Wuhan                 | 4344600              |
| Kanton [Guangzhou] | 4256300                 | Harbin                | 4289800              |
| Kanton [Guangzhou] | 4256300                 | Shenyang              | 4265200              |
| Chengdu            | 3361500                 | Nanking [Nanjing]     | 2870300              |
| Chengdu            | 3361500                 | Changchun             | 2812000              |
| Chengdu            | 3361500                 | Xi´an                 | 2761400              |
| Chengdu            | 3361500                 | Dalian                | 2697000              |

### SQL Solution
```sql
WITH crowded_cities AS (
  SELECT
    country_code,
    name AS primary_city_name,
    population AS primary_city_population
  FROM
    cities
  WHERE
    population > 3000000
)
SELECT
  primary_city_name,
  primary_city_population,
  ci.name AS neighboring_city_name,
  ci.population AS neighboring_city_pop
FROM
  crowded_cities cc
JOIN
  cities ci ON cc.country_code = ci.country_code
  AND cc.primary_city_name <> ci.name
  AND ci.population BETWEEN 0.8 * primary_city_population AND 1.2 * primary_city_population;

```
---

## Question 2: Countries with Unique Official Languages

**Task:** Identify countries that have exactly one official language recorded, where that same language is **not** an official language in any other country in the dataset. This will find countries with a truly unique official language.

**Expected Output:**
| country_name   | unique_official_language |
| -------------- | ------------------------ |
| Armenia        | Armenian                 |
| Azerbaijan     | Azerbaijani              |
| Bangladesh     | Bengali                  |
| Bulgaria       | Bulgariana               |
| Brazil         | Portuguese               |
| Czech Republic | Czech                    |
| Georgia        | Georgiana                |
| Hungary        | Hungarian                |
| India          | Hindi                    |
| Iran           | Persian                  |
| Italy          | Italian                  |
| Japan          | Japanese                 |
| Kazakstan      | Kazakh                   |
| Myanmar        | Burmese                  |
| Pakistan       | Urdu                     |
| Philippines    | Pilipino                 |
| Poland         | Polish                   |
| Thailand       | Thai                     |
| Turkey         | Turkish                  |
| Taiwan         | Mandarin Chinese         |
| Tanzania       | Swahili                  |
| Ukraine        | Ukrainian                |
| Uzbekistan     | Uzbek                    |
| Vietnam        | Vietnamese               |
| Yugoslavia     | Serbo-Croatian           |


### SQL Solution
```sql
WITH unique_official_language_countries AS (
  SELECT
    co.name,
    co.code,
    COUNT(cl.language) AS official_language_count
  FROM
    countries co
  JOIN
    country_languages cl ON co.code = cl.country_code
  WHERE
    cl.is_official = 'T'
  GROUP BY
    co.name,
    co.code
  HAVING
    official_language_count = 1
)
SELECT
  uolc.name AS country_name,
  cl.language AS unique_official_language
FROM
  unique_official_language_countries uolc
JOIN
  country_languages cl ON cl.country_code = uolc.code
WHERE
  cl.is_official = 'T'
  AND NOT EXISTS (
    SELECT
      1
    FROM
      countries co2
    JOIN
      country_languages cl2 ON cl2.country_code = co2.code
    WHERE
      cl2.is_official = 'T'
      AND co2.name != uolc.name
      AND cl2.language = cl.language
  );
```
---

## Question 3: Continent City Population Distribution

**Task:** For each continent, categorize its total city population into three buckets: 'Small' (cities under 1 million), 'Medium' (cities from 1 million to 5 million), and 'Large' (cities over 5 million). The final output should have one row per continent with the total population for each category.

**Expected Output:**
| continent     | small_city_population | medium_city_population | large_city_population |
| ------------- | --------------------- | ---------------------- | --------------------- |
| Asia          | 0                     | 218471136              | 110279894             |
| Africa        | 0                     | 38695859               | 11853479              |
| South America | 0                     | 40811659               | 28292993              |
| Oceania       | 0                     | 8529482                | 0                     |
| Europe        | 0                     | 54593412               | 15674200              |
| North America | 0                     | 31335517               | 16599587              |


### SQL Solution
```sql
SELECT
  co.continent,
  SUM(CASE WHEN ci.population < 1000000 THEN ci.population ELSE 0 END) AS small_city_population,
  SUM(CASE WHEN ci.population BETWEEN 1000000 AND 5000000 THEN ci.population ELSE 0 END) AS medium_city_population,
  SUM(CASE WHEN ci.population > 5000000 THEN ci.population ELSE 0 END) AS large_city_population
FROM
  countries co
JOIN
  cities ci ON ci.country_code = co.code
GROUP BY
  co.continent;
```