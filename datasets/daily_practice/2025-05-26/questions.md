# E-commerce Analytics: Advanced SQL Practice Questions

## Question 1: Multi-Channel Campaign Attribution
*Task:* For each marketing channel, calculate the total number of conversions and the average spend per conversion across all campaigns. Only include channels with at least 2 campaigns.

*Expected Output:*

| channel | total_conversions | avg_spend_per_conversion |
|---------|-------------------|-------------------------|
| Email   | 110               | 20.00                   |
| Social  | 145               | 20.00                   |

```sql
-- Write your SQL query here
```

## Question 2: High-Value Customer Segments
*Task:* Identify customer segments (from the `segment` column in `customers`) where the average order value (AOV) is above 300. For each such segment, show the segment name, number of customers, and the AOV.

*Expected Output:*

| segment | num_customers | avg_order_value |
| ------- | ------------- | --------------- |
| Premium | 2             | 480.00          |
| Regular | 2             | 442.50          |

```sql
-- Write your SQL query here
```

## Question 3: Product Discount Utilization
*Task:* For each product, calculate the percentage of total units sold that were sold with a discount (discount_percent > 0). Show product name, total units sold, units sold with discount, and discount_percentage (rounded to 2 decimals). Only include products with at least 1 unit sold.

*Expected Output:*

| product_name     | total_units | units_with_discount | discount_percentage |
| ---------------- | ----------- | ------------------- | ------------------- |
| Gaming Laptop    | 2           | 2                   | 100.00              |
| Wireless Earbuds | 3           | 0                   | 0.00                |
| Running Shoes    | 3           | 3                   | 100.00              |
| Coffee Maker     | 1           | 0                   | 0.00                |
| Protein Powder   | 3           | 3                   | 100.00              |

```sql
-- Write your SQL query here
```

## Question 4: Campaign Overlap Analysis
*Task:* Find all pairs of campaigns that had overlapping active dates. For each pair, show the campaign names and the number of overlapping days.

*Expected Output:*

| campaign_1    | campaign_2    | overlap_days |
|---------------|---------------|--------------|
| Spring Sale   | New Customer  | 6            |
| New Customer  | Flash Sale    | 3            |

```sql
-- Write your SQL query here
```


---
