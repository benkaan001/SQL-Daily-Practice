# Advanced SQL Practice Questions - World Database

## Question 1: Top 3 Most Populous Cities per Continent
**Task:** For each continent, identify the top three most populous cities. Your result should include the continent name, the city name, the country name, and the city's population. The cities should be ranked by population in descending order for each continent.

**Expected Output:**
| continent     | city_name          | country_name | population |
|---------------|--------------------|--------------|------------|
| Asia          | Mumbai (Bombay)    | India        | 10500000   |
| Asia          | Shanghai           | China        | 9696300    |
| Asia          | Jakarta            | Indonesia    | 9604900    |
| Africa        | Cairo              | Egypt        | 6789479    |
| Africa        | Kinshasa           | Congo, The Democratic Republic of the | 5064000    |
| Africa        | Lagos              | Nigeria      | 1518000    |
| Europe        | Moscow             | Russian Federation | 8389200    |
| Europe        | London             | United Kingdom | 7285000    |
| Europe        | St Petersburg      | Russian Federation | 4694000    |
| North America | Ciudad de México   | Mexico       | 8591309    |
| North America | New York           | United States| 8008278    |
| North America | Los Angeles        | United States| 3694820    |
| Oceania       | Sydney             | Australia    | 3276207    |
| Oceania       | Melbourne          | Australia    | 2865329    |
| Oceania       | Brisbane           | Australia    | 1291117    |
| South America | São Paulo          | Brazil       | 9968485    |
| South America | Lima               | Peru         | 6464693    |
| South America | Santafé de Bogotá  | Colombia     | 6260862    |

### SQL Solution
```sql
-- Write your SQL query here
```

Question 2: Countries with No Official Languages
Task: Identify all countries that do not have any official languages listed in the country_languagies table. For these countries, also list their most spoken unofficial language (the one with the highest percentage).

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
-- Write your SQL query here
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
-- Write your SQL query here
```