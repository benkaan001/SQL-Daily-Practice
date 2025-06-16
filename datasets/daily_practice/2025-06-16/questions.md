## Question 1: Neighboring Cities by Population

**Task:** For every city with a population over 3 million, find another city **in the same country** with a population that is within 20% (either higher or lower) of its own. List the primary city's name and population, alongside the neighboring city's name and population. Ensure you don't list a city paired with itself.

**Expected Output:**
| primary_city_name | primary_city_pop | neighboring_city_name | neighboring_city_pop |
|-------------------|------------------|------------------------|-----------------------|
| Sydney            | 3276207          | Melbourne              | 2865329               |
| Melbourne         | 2865329          | Sydney                 | 3276207               |
| Calcutta [Kolkata] | 4399819          | Chennai (Madras)       | 3841396               |
| Chennai (Madras)  | 3841396          | Calcutta [Kolkata]     | 4399819               |
| Shanghai          | 9696300          | Peking                 | 7472000               |
| Peking            | 7472000          | Shanghai               | 9696300               |
| Peking            | 7472000          | Chongqing              | 6351600               |
| Chongqing         | 6351600          | Peking                 | 7472000               |

### SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 2: Countries with Unique Official Languages

**Task:** Identify countries that have exactly one official language recorded, where that same language is **not** an official language in any other country in the dataset. This will find countries with a truly unique official language.

**Expected Output:**
| country_name | unique_official_language |
|--------------|--------------------------|
| Bangladesh   | Bengali                  |
| Iran         | Persian                  |
| Japan        | Japanese                 |
| Poland       | Polish                   |
| Thailand     | Thai                     |
| Turkey       | Turkish                  |
| Vietnam      | Vietnamese               |

### SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 3: Continent City Population Distribution

**Task:** For each continent, categorize its total city population into three buckets: 'Small' (cities under 1 million), 'Medium' (cities from 1 million to 5 million), and 'Large' (cities over 5 million). The final output should have one row per continent with the total population for each category.

**Expected Output:**
| continent     | small_city_population | medium_city_population | large_city_population |
|---------------|-----------------------|------------------------|-----------------------|
| Africa        | 0                     | 16733600               | 11853479              |
| Asia          | 0                     | 120531454              | 104253100             |
| Europe        | 0                     | 26644026               | 28459200              |
| North America | 0                     | 18788914               | 28284581              |
| Oceania       | 0                     | 8530164                | 0                     |
| South America | 0                     | 19729868               | 39626090              |

### SQL Solution
```sql
-- Write your SQL query here
```