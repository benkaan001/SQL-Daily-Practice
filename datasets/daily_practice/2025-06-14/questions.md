## Question 4: Independence Day Analysis

**Task:** Find all countries that gained independence in the 20th century (1901-2000). Calculate the age of the country at the end of the century (i.e., years from independence to the end of 2000). Display the country name, the year of independence, the calculated age, and a truncated version of the country's local name (the first 10 characters followed by '...').

**Expected Output:**
| country_name                          | indep_year | country_age_in_2000 | truncated_local_name |
| ------------------------------------- | ---------- | ------------------- | -------------------- |
| Czech Republic                        | 1993       | 7                   | ¸esko...             |
| Armenia                               | 1991       | 9                   | Hajastan...          |
| Uzbekistan                            | 1991       | 9                   | Uzbekiston...        |
| Ukraine                               | 1991       | 9                   | Ukrajina...          |
| Azerbaijan                            | 1991       | 9                   | Azərbaycan...        |
| Russian Federation                    | 1991       | 9                   | Rossija...           |
| Belarus                               | 1991       | 9                   | Belarus...           |
| Kazakstan                             | 1991       | 9                   | Qazaqstan...         |
| Georgia                               | 1991       | 9                   | Sakartvelo...        |
| Zimbabwe                              | 1980       | 20                  | Zimbabwe...          |
| Angola                                | 1975       | 25                  | Angola...            |
| Mozambique                            | 1975       | 25                  | Moçambique...        |
| Bangladesh                            | 1971       | 29                  | Bangladesh...        |
| Singapore                             | 1965       | 35                  | Singapore/...        |
| Zambia                                | 1964       | 36                  | Zambia...            |
| Kenya                                 | 1963       | 37                  | Kenya...             |
| Algeria                               | 1962       | 38                  | Al-Jaza’ir...        |
| Tanzania                              | 1961       | 39                  | Tanzania...          |
| Côte d’Ivoire                         | 1960       | 40                  | Côte d’Ivo...        |
| Nigeria                               | 1960       | 40                  | Nigeria...           |
| Congo, The Democratic Republic of the | 1960       | 40                  | République...        |
| Cameroon                              | 1960       | 40                  | Cameroun/C...        |
| Guinea                                | 1958       | 42                  | Guinée...            |
| Malaysia                              | 1957       | 43                  | Malaysia...          |
| Ghana                                 | 1957       | 43                  | Ghana...             |
| Morocco                               | 1956       | 44                  | Al-Maghrib...        |
| Sudan                                 | 1956       | 44                  | As-Sudan...          |
| Germany                               | 1955       | 45                  | Deutschlan...        |
| Libyan Arab Jamahiriya                | 1951       | 49                  | Libiya...            |
| South Korea                           | 1948       | 52                  | Taehan Min...        |
| Myanmar                               | 1948       | 52                  | Myanma Pye...        |
| North Korea                           | 1948       | 52                  | Choson Min...        |
| India                                 | 1947       | 53                  | Bharat/Ind...        |
| Pakistan                              | 1947       | 53                  | Pakistan...          |
| Jordan                                | 1946       | 54                  | Al-Urdunn...         |
| Philippines                           | 1946       | 54                  | Pilipinas...         |
| Vietnam                               | 1945       | 55                  | Viêt Nam...          |
| Taiwan                                | 1945       | 55                  | T’ai-wan...          |
| Indonesia                             | 1945       | 55                  | Indonesia...         |
| Lebanon                               | 1941       | 59                  | Lubnan...            |
| Syria                                 | 1941       | 59                  | Suriya...            |
| Saudi Arabia                          | 1932       | 68                  | Al-´Arabiy...        |
| Iraq                                  | 1932       | 68                  | Al-´Iraq...          |
| Turkey                                | 1923       | 77                  | Türkiye...           |
| Egypt                                 | 1922       | 78                  | Misr...              |
| Afghanistan                           | 1919       | 81                  | Afganistan...        |
| Poland                                | 1918       | 82                  | Polska...            |
| Austria                               | 1918       | 82                  | Österreich...        |
| Yugoslavia                            | 1918       | 82                  | Jugoslavij...        |
| Hungary                               | 1918       | 82                  | Magyarorsz...        |
| South Africa                          | 1910       | 90                  | South Afri...        |
| Bulgaria                              | 1908       | 92                  | Balgarija...         |
| Iran                                  | 1906       | 94                  | Iran...              |
| Cuba                                  | 1902       | 98                  | Cuba...              |
| Australia                             | 1901       | 99                  | Australia...         |

### SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 5: GNP Growth Ranking in Europe

**Task:** For all countries in Europe, calculate the percentage growth from their `gnp_old` to their current `gnp`. Rank the countries based on this growth percentage in descending order. Exclude countries where `gnp_old` is NULL or zero. The growth percentage should be rounded to two decimal places.

**Expected Output:**
| country_name       | gnp        | gnp_old    | gnp_growth_percentage | gnp_growth_rank |
| ------------------ | ---------- | ---------- | --------------------- | --------------- |
| Bulgaria           | 12178.00   | 10169.00   | 19.76                 | 1               |
| Poland             | 151697.00  | 135636.00  | 11.84                 | 2               |
| Romania            | 38158.00   | 34843.00   | 9.51                  | 3               |
| United Kingdom     | 1378330.00 | 1296830.00 | 6.28                  | 4               |
| Czech Republic     | 55017.00   | 52037.00   | 5.73                  | 5               |
| Hungary            | 48267.00   | 45914.00   | 5.12                  | 6               |
| Spain              | 553233.00  | 532031.00  | 3.99                  | 7               |
| Austria            | 211860.00  | 206025.00  | 2.83                  | 8               |
| France             | 1424285.00 | 1392448.00 | 2.29                  | 9               |
| Germany            | 2133367.00 | 2102826.00 | 1.45                  | 10              |
| Italy              | 1161755.00 | 1145372.00 | 1.43                  | 11              |
| Ukraine            | 42168.00   | 49677.00   | -15.12                | 12              |
| Russian Federation | 276608.00  | 442989.00  | -37.56                | 13              |
### SQL Solution
```sql
-- Write your SQL query here
```
---

## Question 6: City Population vs. Country Average

**Task:** For each country, determine the average city population based on the cities listed in the database. Then, for each city, show its population and compare it to its country's average city population. Add a column that categorizes the city's population as 'Above Average', 'Below Average', or 'Equal to Average'. Only show the top 5 most populous cities for each country in the final result.

**Expected Output (sample for Brazil):**
| country_code | city_name               | city_population | country_avg_city_pop | comparison_to_average |
| ------------ | ----------------------- | --------------- | -------------------- | --------------------- |
| AFG          | Kabul                   | 1780000         | 1780000.00           | Equal To Average      |
| AGO          | Luanda                  | 2022000         | 2022000.00           | Equal To Average      |
| ARG          | Buenos Aires            | 2982146         | 1802038.00           | Above Average         |
| ARG          | La Matanza              | 1266461         | 1802038.00           | Below Average         |
| ARG          | Córdoba                 | 1157507         | 1802038.00           | Below Average         |
| ARM          | Yerevan                 | 1248700         | 1248700.00           | Equal To Average      |
| AUS          | Sydney                  | 3276207         | 2132370.50           | Above Average         |
| AUS          | Melbourne               | 2865329         | 2132370.50           | Above Average         |
| AUS          | Brisbane                | 1291117         | 2132370.50           | Below Average         |
| AUS          | Perth                   | 1096829         | 2132370.50           | Below Average         |
| AUT          | Wien                    | 1608144         | 1608144.00           | Equal To Average      |
| AZE          | Bakı                    | 1787800         | 1787800.00           | Equal To Average      |
| BGD          | Dhaka                   | 3612850         | 2502855.00           | Above Average         |
| BGD          | Chittagong              | 1392860         | 2502855.00           | Below Average         |
| BGR          | Sofija                  | 1122302         | 1122302.00           | Equal To Average      |
| BLR          | Minsk                   | 1674000         | 1674000.00           | Equal To Average      |
| BRA          | São Paulo               | 9968485         | 2534426.92           | Above Average         |
| BRA          | Rio de Janeiro          | 5598953         | 2534426.92           | Above Average         |
| BRA          | Salvador                | 2302832         | 2534426.92           | Below Average         |
| BRA          | Belo Horizonte          | 2139125         | 2534426.92           | Below Average         |
| BRA          | Fortaleza               | 2097757         | 2534426.92           | Below Average         |
| CAN          | Montréal                | 1016376         | 1016376.00           | Equal To Average      |
| CHL          | Santiago de Chile       | 4703954         | 4703954.00           | Equal To Average      |
| CHN          | Shanghai                | 9696300         | 2728697.14           | Above Average         |
| CHN          | Peking                  | 7472000         | 2728697.14           | Above Average         |
| CHN          | Chongqing               | 6351600         | 2728697.14           | Above Average         |
| CHN          | Tianjin                 | 5286800         | 2728697.14           | Above Average         |
| CHN          | Wuhan                   | 4344600         | 2728697.14           | Above Average         |
| CIV          | Abidjan                 | 2500000         | 2500000.00           | Equal To Average      |
| CMR          | Douala                  | 1448300         | 1410550.00           | Above Average         |
| CMR          | Yaoundé                 | 1372800         | 1410550.00           | Below Average         |
| COD          | Kinshasa                | 5064000         | 5064000.00           | Equal To Average      |
| COL          | Santafé de Bogotá       | 6260862         | 2855693.25           | Above Average         |
| COL          | Cali                    | 2077386         | 2855693.25           | Below Average         |
| COL          | Medellín                | 1861265         | 2855693.25           | Below Average         |
| COL          | Barranquilla            | 1223260         | 2855693.25           | Below Average         |
| CUB          | La Habana               | 2256000         | 2256000.00           | Equal To Average      |
| CZE          | Praha                   | 1181126         | 1181126.00           | Equal To Average      |
| DEU          | Berlin                  | 3386667         | 2095320.67           | Above Average         |
| DEU          | Hamburg                 | 1704735         | 2095320.67           | Below Average         |
| DEU          | Munich [München]        | 1194560         | 2095320.67           | Below Average         |
| DOM          | Santo Domingo de Guzmán | 1609966         | 1609966.00           | Equal To Average      |
| DZA          | Alger                   | 2168000         | 2168000.00           | Equal To Average      |
| ECU          | Guayaquil               | 2070040         | 1821749.00           | Above Average         |
| ECU          | Quito                   | 1573458         | 1821749.00           | Below Average         |
| EGY          | Cairo                   | 6789479         | 4113181.00           | Above Average         |
| EGY          | Alexandria              | 3328196         | 4113181.00           | Below Average         |
| EGY          | Giza                    | 2221868         | 4113181.00           | Below Average         |
| ESP          | Madrid                  | 2879052         | 2191251.50           | Above Average         |
| ESP          | Barcelona               | 1503451         | 2191251.50           | Below Average         |
| ETH          | Addis Abeba             | 2495000         | 2495000.00           | Equal To Average      |
| FRA          | Paris                   | 2125246         | 2125246.00           | Equal To Average      |
| GBR          | London                  | 7285000         | 4149000.00           | Above Average         |
| GBR          | Birmingham              | 1013000         | 4149000.00           | Below Average         |
| GEO          | Tbilisi                 | 1235200         | 1235200.00           | Equal To Average      |
| GHA          | Accra                   | 1070000         | 1070000.00           | Equal To Average      |
| GIN          | Conakry                 | 1090610         | 1090610.00           | Equal To Average      |
| HKG          | Kowloon and New Kowloon | 1987996         | 1650316.50           | Above Average         |
| HKG          | Victoria                | 1312637         | 1650316.50           | Below Average         |
| HUN          | Budapest                | 1811552         | 1811552.00           | Equal To Average      |
| IDN          | Jakarta                 | 9604900         | 2640920.63           | Above Average         |
| IDN          | Surabaya                | 2663820         | 2640920.63           | Above Average         |
| IDN          | Bandung                 | 2429000         | 2640920.63           | Below Average         |
| IDN          | Medan                   | 1843919         | 2640920.63           | Below Average         |
| IDN          | Palembang               | 1222764         | 2640920.63           | Below Average         |
| IND          | Mumbai (Bombay)         | 10500000        | 2740815.00           | Above Average         |
| IND          | Delhi                   | 7206704         | 2740815.00           | Above Average         |
| IND          | Calcutta [Kolkata]      | 4399819         | 2740815.00           | Above Average         |
| IND          | Chennai (Madras)        | 3841396         | 2740815.00           | Above Average         |
| IND          | Hyderabad               | 2964638         | 2740815.00           | Above Average         |
| IRN          | Teheran                 | 6758845         | 2431278.00           | Above Average         |
| IRN          | Mashhad                 | 1887405         | 2431278.00           | Below Average         |
| IRN          | Esfahan                 | 1266072         | 2431278.00           | Below Average         |
| IRN          | Tabriz                  | 1191043         | 2431278.00           | Below Average         |
| IRN          | Shiraz                  | 1053025         | 2431278.00           | Below Average         |
| IRQ          | Baghdad                 | 4336000         | 4336000.00           | Equal To Average      |
| ITA          | Roma                    | 2643581         | 1649059.00           | Above Average         |
| ITA          | Milano                  | 1300977         | 1649059.00           | Below Average         |
| ITA          | Napoli                  | 1002619         | 1649059.00           | Below Average         |
| JOR          | Amman                   | 1000000         | 1000000.00           | Equal To Average      |
| JPN          | Tokyo                   | 7980230         | 2309908.36           | Above Average         |
| JPN          | Jokohama [Yokohama]     | 3339594         | 2309908.36           | Above Average         |
| JPN          | Osaka                   | 2595674         | 2309908.36           | Above Average         |
| JPN          | Nagoya                  | 2154376         | 2309908.36           | Below Average         |
| JPN          | Sapporo                 | 1790886         | 2309908.36           | Below Average         |
| KAZ          | Almaty                  | 1129400         | 1129400.00           | Equal To Average      |
| KEN          | Nairobi                 | 2290000         | 2290000.00           | Equal To Average      |
| KOR          | Seoul                   | 9981619         | 3253314.29           | Above Average         |
| KOR          | Pusan                   | 3804522         | 3253314.29           | Above Average         |
| KOR          | Inchon                  | 2559424         | 3253314.29           | Below Average         |
| KOR          | Taegu                   | 2548568         | 3253314.29           | Below Average         |
| KOR          | Taejon                  | 1425835         | 3253314.29           | Below Average         |
| LBN          | Beirut                  | 1100000         | 1100000.00           | Equal To Average      |
| LBY          | Tripoli                 | 1682000         | 1682000.00           | Equal To Average      |
| MAR          | Casablanca              | 2940623         | 2940623.00           | Equal To Average      |
| MEX          | Ciudad de México        | 8591309         | 2010479.60           | Above Average         |
| MEX          | Guadalajara             | 1647720         | 2010479.60           | Below Average         |
| MEX          | Ecatepec de Morelos     | 1620303         | 2010479.60           | Below Average         |
| MEX          | Puebla                  | 1346176         | 2010479.60           | Below Average         |
| MEX          | Nezahualcóyotl          | 1224924         | 2010479.60           | Below Average         |
| MMR          | Rangoon (Yangon)        | 3361700         | 3361700.00           | Equal To Average      |
| MOZ          | Maputo                  | 1018938         | 1018938.00           | Equal To Average      |
| MYS          | Kuala Lumpur            | 1297526         | 1297526.00           | Equal To Average      |
| NGA          | Lagos                   | 1518000         | 1475000.00           | Above Average         |
| NGA          | Ibadan                  | 1432000         | 1475000.00           | Below Average         |
| PAK          | Karachi                 | 9269265         | 3024955.43           | Above Average         |
| PAK          | Lahore                  | 5063499         | 3024955.43           | Above Average         |
| PAK          | Faisalabad              | 1977246         | 3024955.43           | Below Average         |
| PAK          | Rawalpindi              | 1406214         | 3024955.43           | Below Average         |
| PAK          | Multan                  | 1182441         | 3024955.43           | Below Average         |
| PER          | Lima                    | 6464693         | 6464693.00           | Equal To Average      |
| PHL          | Quezon                  | 2173831         | 1519908.25           | Above Average         |
| PHL          | Manila                  | 1581082         | 1519908.25           | Above Average         |
| PHL          | Kalookan                | 1177604         | 1519908.25           | Below Average         |
| PHL          | Davao                   | 1147116         | 1519908.25           | Below Average         |
| POL          | Warszawa                | 1615369         | 1615369.00           | Equal To Average      |
| PRK          | Pyongyang               | 2484000         | 2484000.00           | Equal To Average      |
| ROM          | Bucuresti               | 2016131         | 2016131.00           | Equal To Average      |
| RUS          | Moscow                  | 8389200         | 2059008.33           | Above Average         |
| RUS          | St Petersburg           | 4694000         | 2059008.33           | Above Average         |
| RUS          | Novosibirsk             | 1398800         | 2059008.33           | Below Average         |
| RUS          | Nizni Novgorod          | 1357000         | 2059008.33           | Below Average         |
| RUS          | Jekaterinburg           | 1266300         | 2059008.33           | Below Average         |
| SAU          | Riyadh                  | 3324000         | 2685150.00           | Above Average         |
| SAU          | Jedda                   | 2046300         | 2685150.00           | Below Average         |
| SDN          | Omdurman                | 1271403         | 1271403.00           | Equal To Average      |
| SGP          | Singapore               | 4017733         | 4017733.00           | Equal To Average      |
| SYR          | Damascus                | 1347000         | 1304491.50           | Above Average         |
| SYR          | Aleppo                  | 1261983         | 1304491.50           | Below Average         |
| THA          | Bangkok                 | 6320174         | 6320174.00           | Equal To Average      |
| TUR          | Istanbul                | 8787958         | 3236703.20           | Above Average         |
| TUR          | Ankara                  | 3038159         | 3236703.20           | Below Average         |
| TUR          | Izmir                   | 2130359         | 3236703.20           | Below Average         |
| TUR          | Adana                   | 1131198         | 3236703.20           | Below Average         |
| TUR          | Bursa                   | 1095842         | 3236703.20           | Below Average         |
| TWN          | Taipei                  | 2641312         | 2058408.50           | Above Average         |
| TWN          | Kaohsiung               | 1475505         | 2058408.50           | Below Average         |
| TZA          | Dar es Salaam           | 1747000         | 1747000.00           | Equal To Average      |
| UKR          | Kyiv                    | 2624000         | 1457600.00           | Above Average         |
| UKR          | Harkova [Harkiv]        | 1500000         | 1457600.00           | Above Average         |
| UKR          | Dnipropetrovsk          | 1103000         | 1457600.00           | Below Average         |
| UKR          | Donetsk                 | 1050000         | 1457600.00           | Below Average         |
| UKR          | Odesa                   | 1011000         | 1457600.00           | Below Average         |
| URY          | Montevideo              | 1236000         | 1236000.00           | Equal To Average      |
| USA          | New York                | 8008278         | 2549774.00           | Above Average         |
| USA          | Los Angeles             | 3694820         | 2549774.00           | Above Average         |
| USA          | Chicago                 | 2896016         | 2549774.00           | Above Average         |
| USA          | Houston                 | 1953631         | 2549774.00           | Below Average         |
| USA          | Philadelphia            | 1517550         | 2549774.00           | Below Average         |
| UZB          | Toskent                 | 2117500         | 2117500.00           | Equal To Average      |
| VEN          | Caracas                 | 1975294         | 1640035.00           | Above Average         |
| VEN          | Maracaíbo               | 1304776         | 1640035.00           | Below Average         |
| VNM          | Ho Chi Minh City        | 3980000         | 2695000.00           | Above Average         |
| VNM          | Hanoi                   | 1410000         | 2695000.00           | Below Average         |
| YUG          | Beograd                 | 1204000         | 1204000.00           | Equal To Average      |
| ZAF          | Cape Town               | 2352121         | 2352121.00           | Equal To Average      |
| ZMB          | Lusaka                  | 1317000         | 1317000.00           | Equal To Average      |
| ZWE          | Harare                  | 1410000         | 1410000.00           | Equal To Average      |


### SQL Solution
```sql
-- Write your SQL query here
```