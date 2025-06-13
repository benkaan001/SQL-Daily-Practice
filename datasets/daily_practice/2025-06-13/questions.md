## Question 1: Linguistic Diversity Hotspots

**Task:** Identify countries with high linguistic diversity, defined here as having more unofficial languages spoken than official languages. For these countries, list their name, the count of official languages, and the count of unofficial languages.

**Expected Output:**
| country_name                          | official_lang_count | unofficial_lang_count |
| ------------------------------------- | ------------------- | --------------------- |
| Afghanistan                           | 2                   | 3                     |
| Angola                                | 0                   | 9                     |
| Argentina                             | 1                   | 2                     |
| Australia                             | 1                   | 7                     |
| Austria                               | 1                   | 7                     |
| Azerbaijan                            | 1                   | 3                     |
| Bangladesh                            | 1                   | 6                     |
| Bulgaria                              | 1                   | 3                     |
| Brazil                                | 1                   | 4                     |
| Canada                                | 2                   | 10                    |
| Chile                                 | 1                   | 3                     |
| China                                 | 1                   | 11                    |
| Côte d’Ivoire                         | 0                   | 5                     |
| Cameroon                              | 0                   | 8                     |
| Congo, The Democratic Republic of the | 0                   | 10                    |
| Colombia                              | 1                   | 4                     |
| Czech Republic                        | 1                   | 7                     |
| Germany                               | 1                   | 5                     |
| Spain                                 | 1                   | 3                     |
| Ethiopia                              | 0                   | 7                     |
| France                                | 1                   | 5                     |
| United Kingdom                        | 1                   | 2                     |
| Georgia                               | 1                   | 5                     |
| Ghana                                 | 0                   | 6                     |
| Guinea                                | 0                   | 7                     |
| Hong Kong                             | 1                   | 4                     |
| Hungary                               | 1                   | 5                     |
| Indonesia                             | 1                   | 8                     |
| India                                 | 1                   | 11                    |
| Iran                                  | 1                   | 9                     |
| Iraq                                  | 1                   | 4                     |
| Italy                                 | 1                   | 7                     |
| Jordan                                | 1                   | 2                     |
| Japan                                 | 1                   | 5                     |
| Kazakstan                             | 1                   | 5                     |
| Kenya                                 | 0                   | 10                    |
| Lebanon                               | 1                   | 2                     |
| Mexico                                | 1                   | 5                     |
| Myanmar                               | 1                   | 7                     |
| Mozambique                            | 0                   | 10                    |
| Malaysia                              | 1                   | 5                     |
| Nigeria                               | 0                   | 10                    |
| Pakistan                              | 1                   | 7                     |
| Philippines                           | 1                   | 9                     |
| Poland                                | 1                   | 3                     |
| Romania                               | 2                   | 4                     |
| Russian Federation                    | 1                   | 11                    |
| Sudan                                 | 1                   | 9                     |
| Thailand                              | 1                   | 5                     |
| Turkey                                | 1                   | 2                     |
| Taiwan                                | 1                   | 5                     |
| Tanzania                              | 1                   | 10                    |
| Ukraine                               | 1                   | 6                     |
| United States                         | 1                   | 11                    |
| Uzbekistan                            | 1                   | 5                     |
| Venezuela                             | 1                   | 2                     |
| Vietnam                               | 1                   | 8                     |
| Yugoslavia                            | 1                   | 5                     |
| South Africa                          | 4                   | 7                     |
| Zambia                                | 0                   | 6                     |
| Zimbabwe                              | 1                   | 3                     |

SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 2: Capital vs. Largest City

**Task:** Find all countries where the capital city is *not* the most populous city in that country. For these countries, display the country name, the capital's name and population, and the largest city's name and population.

**Expected Output:**
| country_name  | capital_name | capital_population | largest_city_name       | largest_city_population |
| ------------- | ------------ | ------------------ | ----------------------- | ----------------------- |
| Australia     |              |                    | Sydney                  | 3276207                 |
| Brazil        | Brasília     | 1969868            | São Paulo               | 9968485                 |
| Cameroon      | Yaoundé      | 1372800            | Douala                  | 1448300                 |
| Canada        |              |                    | Montréal                | 1016376                 |
| China         | Peking       | 7472000            | Shanghai                | 9696300                 |
| Côte d’Ivoire |              |                    | Abidjan                 | 2500000                 |
| Ecuador       | Quito        | 1573458            | Guayaquil               | 2070040                 |
| Hong Kong     | Victoria     | 1312637            | Kowloon and New Kowloon | 1987996                 |
| India         |              |                    | Mumbai (Bombay)         | 10500000                |
| Kazakstan     |              |                    | Almaty                  | 1129400                 |
| Morocco       |              |                    | Casablanca              | 2940623                 |
| Nigeria       |              |                    | Lagos                   | 1518000                 |
| Pakistan      |              |                    | Karachi                 | 9269265                 |
| Philippines   | Manila       | 1581082            | Quezon                  | 2173831                 |
| South Africa  |              |                    | Cape Town               | 2352121                 |
| Sudan         |              |                    | Omdurman                | 1271403                 |
| Tanzania      |              |                    | Dar es Salaam           | 1747000                 |
| Turkey        | Ankara       | 3038159            | Istanbul                | 8787958                 |
| United States |              |                    | New York                | 8008278                 |
| Vietnam       | Hanoi        | 1410000            | Ho Chi Minh City        | 3980000                 |


SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 3: Government Forms and Life Expectancy

**Task:** For each distinct `government_form`, calculate the average life expectancy. Only include government forms that are present in at least 3 countries. Order the results by the average life expectancy in descending order.

**Expected Output:**
| government_form                     | count_countries | avg_life_expectancy |
| ----------------------------------- | --------------- | ------------------- |
| Constitutional Monarchy, Federation | 3               | 76.67               |
| Constitutional Monarchy             | 6               | 75.38               |
| Socialistic Republic                | 3               | 72.07               |
| Federal Republic                    | 11              | 69.86               |
| Republic                            | 47              | 62.98               |

SQL Solution
```sql
-- Write your SQL query here
```