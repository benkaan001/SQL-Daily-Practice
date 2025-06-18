### Question 1: Customer Lifetime Value (CLV) by Registration Cohort and Region

Calculate the Customer Lifetime Value (CLV) for each customer, defined as the SUM(quantity * price_per_unit - COALESCE(discount_applied, 0)) of all their sales.

Then, group customers by their registration_month (formatted as %Y-%m) and region. For each cohort, calculate the average_clv and the total_customers_in_cohort.

Output registration_month, region, average_clv (rounded to two decimal places), and total_customers_in_cohort.

Order the results by registration_month ascending, then by region ascending.

Only include cohorts with at least one customer who has made a purchase.

**Expected Output:**

| **registration_month** | **region** | **average_clv** | **total_customers_in_cohort** |
| ---------------------------- | ---------------- | --------------------- | ----------------------------------- |
| 2023-01                      | North            | 2390.00               | 1                                   |
| 2023-01                      | South            | 645.00                | 1                                   |
| 2023-02                      | East             | 1370.00               | 1                                   |
| 2023-02                      | West             | 350.00                | 1                                   |
| 2023-03                      | North            | 1330.00               | 1                                   |
| 2023-03                      | South            | 60.00                 | 1                                   |
| 2023-04                      | East             | 400.00                | 1                                   |

**Your Solution:**

```
--- Write your solution here

```

### Question 2: Product Performance by Quarterly Sales

For each product_name, calculate its total revenue for each quarter of 2024.

Revenue for a sale is quantity * price_per_unit - COALESCE(discount_applied, 0).

Display the results in a pivoted table format, with product_name as rows and Q1_2024_Revenue, Q2_2024_Revenue, Q3_2024_Revenue, Q4_2024_Revenue as columns.

If a product has no sales in a quarter, display 0.00 for that quarter's revenue.

Round revenues to two decimal places.

Order the results by product_name ascending.

**Expected Output:**

| **product_name** | **Q1_2024_Revenue** | **Q2_2024_Revenue** | **Q3_2024_Revenue** | **Q4_2024_Revenue** |
| ---------------------- | ------------------------- | ------------------------- | ------------------------- | ------------------------- |
| Case                   | 30.00                     | 0.00                      | 0.00                      | 0.00                      |
| Charger                | 20.00                     | 0.00                      | 0.00                      | 0.00                      |
| Chair                  | 100.00                    | 0.00                      | 0.00                      | 0.00                      |
| Desk                   | 250.00                    | 0.00                      | 0.00                      | 0.00                      |
| External SSD           | 0.00                      | 120.00                    | 0.00                      | 0.00                      |
| Gaming Console         | 0.00                      | 450.00                    | 0.00                      | 0.00                      |
| Headphones             | 0.00                      | 135.00                    | 0.00                      | 0.00                      |
| Keyboard               | 75.00                     | 0.00                      | 0.00                      | 0.00                      |
| Laptop                 | 950.00                    | 950.00                    | 0.00                      | 0.00                      |
| Monitor                | 290.00                    | 0.00                      | 0.00                      | 0.00                      |
| Mouse                  | 25.00                     | 0.00                      | 0.00                      | 0.00                      |
| Projector              | 0.00                      | 400.00                    | 0.00                      | 0.00                      |
| Smart TV               | 760.00                    | 0.00                      | 0.00                      | 0.00                      |
| Smartphone             | 670.00                    | 680.00                    | 0.00                      | 0.00                      |
| Soundbar               | 120.00                    | 0.00                      | 0.00                      | 0.00                      |
| Stylus Pen             | 0.00                      | 20.00                     | 0.00                      | 0.00                      |
| Tablet                 | 480.00                    | 0.00                      | 0.00                      | 0.00                      |
| Webcam                 | 0.00                      | 60.00                     | 0.00                      | 0.00                      |

**Your Solution:**

```
--- Write your solution here

```

### Question 3: Customers with Decreasing Monthly Spend

Identify customers who have made purchases in at least two consecutive months in 2024, and whose total spend (revenue) in the current month was strictly less than their total spend in the previous month.

Return customer_id, customer_name, month_year (of the current month where spend decreased, format %Y-%m), current_month_spend, and previous_month_spend.

Only show instances where spending decreased.

Order the results by customer_id ascending, then by month_year ascending.

**Expected Output:**

| **customer_id** | **customer_name** | **month_year** | **current_month_spend** | **previous_month_spend** |
| --------------------- | ----------------------- | -------------------- | ----------------------------- | ------------------------------ |
| 1                     | Alice Johnson           | 2024-02              | 75.00                         | 975.00                         |
| 1                     | Alice Johnson           | 2024-03              | 290.00                        | 75.00                          |

**Your Solution:**

```
--- Write your solution here

```
