## Question 4: Independence Day Analysis

**Task:** Find all countries that gained independence in the 20th century (1901-2000). Calculate the age of the country at the end of the century (i.e., years from independence to the end of 2000). Display the country name, the year of independence, the calculated age, and a truncated version of the country's local name (the first 10 characters followed by '...').

**Expected Output:**
| country_name | indep_year | country_age_in_2000 | truncated_local_name |
|--------------|------------|---------------------|----------------------|
| Austria      | 1918       | 82                  | Österreich...        |
| Poland       | 1918       | 82                  | Polska...            |
| Yugoslavia   | 1918       | 82                  | Jugoslavij...        |
| Afghanistan  | 1919       | 81                  | Afganistan...        |
| Egypt        | 1922       | 78                  | Misr...              |
| Turkey       | 1923       | 77                  | Türkiye...           |
| Saudi Arabia | 1932       | 68                  | Al-´Arabi...         |
| Iraq         | 1932       | 68                  | Al-´Iraq...          |
| Syria        | 1941       | 59                  | Suriya...            |
| Lebanon      | 1941       | 59                  | Lubnan...            |
| Vietnam      | 1945       | 55                  | Viêt Nam...          |
| Indonesia    | 1945       | 55                  | Indonesia...         |
| Taiwan       | 1945       | 55                  | T’ai-wan...          |
| Jordan       | 1946       | 54                  | Al-Urdunn...         |
| Philippines  | 1946       | 54                  | Pilipinas...         |
| Pakistan     | 1947       | 53                  | Pakistan...          |
| India        | 1947       | 53                  | Bharat/Ind...        |
| Myanmar      | 1948       | 52                  | Myanma Pye...        |
| South Korea  | 1948       | 52                  | Taehan Min...        |
| North Korea  | 1948       | 52                  | Choson Min...        |
| Libyan Arab Jamahiriya | 1951 | 49                | Libiya...            |
| Germany      | 1955       | 45                  | Deutschlan...        |
| Morocco      | 1956       | 44                  | Al-Maghrib...        |
| Sudan        | 1956       | 44                  | As-Sudan...          |
| Malaysia     | 1957       | 43                  | Malaysia...          |
| Ghana        | 1957       | 43                  | Ghana...             |
| Guinea       | 1958       | 42                  | Guinée...            |
| Cameroon     | 1960       | 40                  | Cameroun/C...        |
| Congo, The Democratic Republic of the | 1960 | 40 | République...        |
| Côte d’Ivoire | 1960       | 40                  | Côte d’Ivoire...     |
| Nigeria      | 1960       | 40                  | Nigeria...           |
| Tanzania     | 1961       | 39                  | Tanzania...          |
| Algeria      | 1962       | 38                  | Al-Jaza’ir...        |
| Kenya        | 1963       | 37                  | Kenya...             |
| Zambia       | 1964       | 36                  | Zambia...            |
| Singapore    | 1965       | 35                  | Singapore/...        |
| Bangladesh   | 1971       | 29                  | Bangladesh...        |
| Angola       | 1975       | 25                  | Angola...            |
| Mozambique   | 1975       | 25                  | Moçambique...        |
| Zimbabwe     | 1980       | 20                  | Zimbabwe...          |
| Armenia      | 1991       | 9                   | Hajastan...          |
| Azerbaijan   | 1991       | 9                   | Azərbaycan...        |
| Belarus      | 1991       | 9                   | Belarus...           |
| Georgia      | 1991       | 9                   | Sakartvelo...        |
| Kazakstan    | 1991       | 9                   | Qazaqstan...         |
| Russian Federation | 1991 | 9                   | Rossija...           |
| Ukraine      | 1991       | 9                   | Ukrajina...          |
| Uzbekistan   | 1991       | 9                   | Uzbekiston...        |
| Czech Republic | 1993       | 7                   | ¸esko...             |

### SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 5: GNP Growth Ranking in Europe

**Task:** For all countries in Europe, calculate the percentage growth from their `gnp_old` to their current `gnp`. Rank the countries based on this growth percentage in descending order. Exclude countries where `gnp_old` is NULL or zero. The growth percentage should be rounded to two decimal places.

**Expected Output:**
| country_name | gnp          | gnp_old      | gnp_growth_percentage | gnp_growth_rank |
|--------------|--------------|--------------|-----------------------|-----------------|
| Bulgaria     | 12178.00     | 10169.00     | 19.76                 | 1               |
| Romania      | 38158.00     | 34843.00     | 9.51                  | 2               |
| Poland       | 151697.00    | 135636.00    | 11.84                 | 3               |
| Hungary      | 48267.00     | 45914.00     | 5.12                  | 4               |
| Czech Republic | 55017.00   | 52037.00     | 5.73                  | 5               |
| United Kingdom | 1378330.00 | 1296830.00   | 6.28                  | 6               |
| Austria      | 211860.00    | 206025.00    | 2.83                  | 7               |
| Spain        | 553233.00    | 532031.00    | 3.98                  | 8               |
| Germany      | 2133367.00   | 2102826.00   | 1.45                  | 9               |
| France       | 1424285.00   | 1392448.00   | 2.29                  | 10              |
| Italy        | 1161755.00   | 1145372.00   | 1.43                  | 11              |

### SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 6: City Population vs. Country Average

**Task:** For each country, determine the average city population based on the cities listed in the database. Then, for each city, show its population and compare it to its country's average city population. Add a column that categorizes the city's population as 'Above Average', 'Below Average', or 'Equal to Average'. Only show the top 5 most populous cities for each country in the final result.

**Expected Output (sample for Brazil):**
| country_code | city_name          | city_population | country_avg_city_pop | comparison_to_average |
|--------------|--------------------|-----------------|----------------------|-----------------------|
| BRA          | São Paulo          | 9968485         | 2154238.17           | Above Average         |
| BRA          | Rio de Janeiro     | 5598953         | 2154238.17           | Above Average         |
| BRA          | Salvador           | 2302832         | 2154238.17           | Above Average         |
| BRA          | Belo Horizonte     | 2139125         | 2154238.17           | Below Average         |
| BRA          | Fortaleza          | 2097757         | 2154238.17           | Below Average         |

### SQL Solution
```sql
-- Write your SQL query here
```