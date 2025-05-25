## Question 1: Companies with Consecutive Year Launches

List all companies that launched at least one product in two or more consecutive years. For each such company, show:
- The company name
- The list of consecutive years (as a comma-separated string, e.g., '2019,2020')
- The total number of products launched in those consecutive years

Order by company name.

**Expected Output:**

| company_name | consecutive_years | total_products |
|--------------|-------------------|----------------|
| Chevrolet    | 2019,2020         | 4              |
| Ford         | 2019,2020         | 3              |
| Honda        | 2019,2020         | 5              |
| Jeep         | 2019,2020         | 5              |
| Toyota       | 2019,2020         | 3              |

**Your Solution:**
````sql
-- Write your solution here
````

---

## Question 2: Most Popular Launch Year by Company

For each company, find the year in which they launched the most products. If there is a tie, show all such years. For each result, show:
- The company name
- The year
- The number of products launched that year

Order by company name, then year.

**Expected Output:**

| company_name | launch_year | product_count |
|--------------|-------------|---------------|
| Chevrolet    | 2020        | 3             |
| Ford         | 2019        | 2             |
| Ford         | 2020        | 1             |
| Honda        | 2019        | 4             |
| Honda        | 2020        | 1             |
| Jeep         | 2020        | 3             |
| Jeep         | 2019        | 2             |
| Toyota       | 2019        | 2             |
| Toyota       | 2020        | 1             |

**Your Solution:**
````sql
-- Write your solution here
````

---

## Question 3: Unique Product Names Across Companies

Find all product names that are unique to a single company (i.e., not launched by any other company). For each such product, show:
- The product name
- The company name
- The launch year

Order by company name, then product name.

**Expected Output:**

| product_name | company_name | launch_year |
|--------------|--------------|-------------|
| Accord       | Honda        | 2019        |
| Aspire       | Ford         | 2020        |
| Avalon       | Toyota       | 2019        |
| Blazer       | Chevrolet    | 2020        |
| Camry        | Toyota       | 2019        |
| Cherokee     | Jeep         | 2020        |
| Civic        | Honda        | 2019        |
| Compass      | Jeep         | 2020        |
| CR-V         | Honda        | 2019        |
| Endeavour    | Ford         | 2019        |
| Figo         | Ford         | 2019        |
| Gladiator    | Jeep         | 2019        |
| Passport     | Honda        | 2019        |
| Pilot        | Honda        | 2020        |
| Renegade     | Jeep         | 2019        |
| Trailblazer  | Chevrolet    | 2020        |
| Trax         | Chevrolet    | 2020        |
| Traverse     | Chevrolet    | 2019        |

**Your Solution:**
````sql
-- Write your solution here
````