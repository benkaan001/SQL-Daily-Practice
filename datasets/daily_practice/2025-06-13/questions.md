## Question 1: Linguistic Diversity Hotspots

**Task:** Identify countries with high linguistic diversity, defined here as having more unofficial languages spoken than official languages. For these countries, list their name, the count of official languages, and the count of unofficial languages.

**Expected Output:**
| country_name | official_lang_count | unofficial_lang_count |
|--------------|---------------------|-----------------------|
| Canada       | 2                   | 10                    |
| India        | 1                   | 11                    |
| Mozambique   | 0                   | 10                    |
| Nigeria      | 0                   | 10                    |
| Tanzania     | 1                   | 10                    |
| Zambia       | 0                   | 6                     |

SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 2: Capital vs. Largest City

**Task:** Find all countries where the capital city is *not* the most populous city in that country. For these countries, display the country name, the capital's name and population, and the largest city's name and population.

**Expected Output:**
| country_name       | capital_name | capital_population | largest_city_name | largest_city_population |
|--------------------|--------------|--------------------|-------------------|-------------------------|
| Australia          | Canberra     | NULL               | Sydney            | 3276207                 |
| Brazil             | Brasília     | 1969868            | São Paulo         | 9968485                 |
| Canada             | Ottawa       | NULL               | Montréal          | 1016376                 |
| China              | Peking       | 7472000            | Shanghai          | 9696300                 |
| India              | New Delhi    | NULL               | Mumbai (Bombay)   | 10500000                |
| Nigeria            | Abuja        | NULL               | Lagos             | 1518000                 |
| Pakistan           | Islamabad    | NULL               | Karachi           | 9269265                 |
| South Africa       | Pretoria     | NULL               | Cape Town         | 2352121                 |
| Turkey             | Ankara       | 3038159            | Istanbul          | 8787958                 |
| United States      | Washington   | NULL               | New York          | 8008278                 |
| Vietnam            | Hanoi        | 1410000            | Ho Chi Minh City  | 3980000                 |

SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 3: Government Forms and Life Expectancy

**Task:** For each distinct `government_form`, calculate the average life expectancy. Only include government forms that are present in at least 3 countries. Order the results by the average life expectancy in descending order.

**Expected Output:**
| government_form                        | count_countries | avg_life_expectancy |
|----------------------------------------|-----------------|---------------------|
| Constitutional Monarchy, Federation    | 3               | 76.67               |
| Constitutional Monarchy                | 9               | 75.59               |
| Federal Republic                       | 9               | 70.82               |
| Republic                               | 67              | 66.38               |
| Islamic Republic                       | 4               | 62.10               |

SQL Solution
```sql
-- Write your SQL query here
```