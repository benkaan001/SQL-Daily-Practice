# Advanced SQL Practice Questions - World Database

## Question 1: Top 3 Most Populous Cities per Continent
**Task:** For each continent, identify the top three most populous cities. Your result should include the continent name, the city name, the country name, and the city's population. The cities should be ranked by population in descending order for each continent.

**Expected Output:**
population |
| ------------- | ----------------- | ------------------------------------- | ---------- |
| Africa        | Cairo             | Egypt                                 | 6789479    |
| Africa        | Kinshasa          | Congo, The Democratic Republic of the | 5064000    |
| Africa        | Alexandria        | Egypt                                 | 3328196    |
| Asia          | Mumbai (Bombay)   | India                                 | 10500000   |
| Asia          | Seoul             | South Korea                           | 9981619    |
| Asia          | Shanghai          | China                                 | 9696300    |
| Europe        | Moscow            | Russian Federation                    | 8389200    |
| Europe        | London            | United Kingdom                        | 7285000    |
| Europe        | St Petersburg     | Russian Federation                    | 4694000    |
| North America | Ciudad de México  | Mexico                                | 8591309    |
| North America | New York          | United States                         | 8008278    |
| North America | Los Angeles       | United States                         | 3694820    |
| Oceania       | Sydney            | Australia                             | 3276207    |
| Oceania       | Melbourne         | Australia                             | 2865329    |
| Oceania       | Brisbane          | Australia                             | 1291117    |
| South America | São Paulo         | Brazil                                | 9968485    |
| South America | Lima              | Peru                                  | 6464693    |
| South America | Santafé de Bogotá | Colombia                              | 6260862    |

### SQL Solution
```sql
WITH most_populous_cities AS (
  SELECT
    co.continent,
    ci.name AS city_name,
    co.name AS country_name,
    ci.population,
    DENSE_RANK() OVER (PARTITION BY co.continent ORDER BY ci.population DESC) AS rnk
  FROM
    cities ci
  JOIN
    countries co ON co.code = ci.country_code
)
SELECT
  continent,
  city_name,
  country_name,
  population
FROM
  most_populous_cities
WHERE
  rnk <= 3
ORDER BY
  continent ASC,
  population DESC;
```

Question 2: Countries with No Official Languages
Task: Identify all countries that do not have any official languages listed in the country_languagies table. For these countries, also list their most spoken unofficial language (the one with the highest percentage).

Expected Output:
| country_name                          | most_spoken_unofficial_language | percentage |
| ------------------------------------- | ------------------------------- | ---------- |
| Angola                                | Ovimbundu                       | 37.2       |
| Cameroon                              | Fang                            | 19.7       |
| Congo, The Democratic Republic of the | Luba                            | 18.0       |
| Côte d’Ivoire                         | Akan                            | 30.0       |
| Ethiopia                              | Oromo                           | 31.0       |
| Ghana                                 | Akan                            | 52.4       |
| Guinea                                | Ful                             | 38.6       |
| Kenya                                 | Kikuyu                          | 20.9       |
| Mozambique                            | Makua                           | 27.8       |
| Nigeria                               | Joruba                          | 21.4       |
| Zambia                                | Bemba                           | 29.7       |

SQL Solution
```sql
WITH filtered_countries AS (
  SELECT
    country_code,
    SUM(CASE WHEN is_official = 'T' THEN 1 ELSE 0 END) AS official_language_count
  FROM
    country_languages
  GROUP BY
    country_code
  HAVING
    official_language_count = 0
),
unofficial_language_listing AS (
  SELECT
    co.name AS country_name,
    cl.language AS most_spoken_unofficial_language,
    cl.percentage,
    ROW_NUMBER() OVER (PARTITION BY co.name ORDER BY percentage DESC) AS rn
  FROM
    countries co
  JOIN
    country_languages cl ON cl.country_code = co.code
  JOIN
    filtered_countries fc ON co.code = fc.country_code
)
SELECT
  country_name,
  most_spoken_unofficial_language,
  percentage
FROM
  unofficial_language_listing
WHERE
  rn = 1;
```

Question 3: Continent Population Analysis
Task: Calculate the total population for each continent. Then, for each country, determine what percentage of its continent's total population it represents. List the country with the highest population percentage for each continent.

Expected Output:
| continent     | country_name       | country_population | continent_population | percentage_of_continent_pop |
| ------------- | ------------------ | ------------------ | -------------------- | --------------------------- |
| Africa        | Nigeria            | 111506000          | 603995000            | 18.46                       |
| Asia          | China              | 1277558000         | 3587208000           | 35.61                       |
| Europe        | Russian Federation | 146934000          | 614114600            | 23.93                       |
| North America | United States      | 278357000          | 428081000            | 65.02                       |
| Oceania       | Australia          | 18886000           | 18886000             | 100.00                      |
| South America | Brazil             | 170115000          | 330494000            | 51.47                       |

SQL Solution
```sql
WITH populations AS (
  SELECT
    continent,
    name AS country_name,
    population AS country_population,
    SUM(population) OVER (PARTITION BY continent) AS continent_population
  FROM
    countries
),
ranked_populations AS (
  SELECT
    continent,
    country_name,
    country_population,
    continent_population,
    ROUND(country_population * 100 / continent_population, 2) AS percentage_of_continent_pop,
    RANK() OVER (PARTITION BY continent ORDER BY country_population DESC) AS population_density
  FROM
    populations
)
SELECT
    continent,
    country_name,
    country_population,
    continent_population,
    percentage_of_continent_pop
FROM
  ranked_populations
WHERE
  population_density = 1;
```