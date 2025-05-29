# E-commerce Analytics: Advanced SQL Practice Questions

## Question 1: Multi-Channel Campaign Attribution
*Task:* For each marketing channel, calculate the total number of conversions and the average spend per conversion across all campaigns. Only include channels with at least 2 campaigns.

*Expected Output:*

| channel | total_conversions | avg_spend_per_conversion |
|---------|-------------------|-------------------------|
| Email   | 110               | 20.00                   |
| Social  | 145               | 20.00                   |

```sql
SELECT
	mc.channel,
    SUM(cp.conversions) AS total_conversions,
    ROUND(SUM(cp.spend) / SUM(cp.conversions), 2) AS avg_spend_per_conversion
FROM
	campaign_performance cp
JOIN
	marketing_campaigns mc ON cp.campaign_id = mc.campaign_id
GROUP BY
	mc.channel
HAVING
	COUNT(*) >= 2;
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
12
SELECT
13
    p.product_name,
14
    SUM(oi.quantity) AS total_units,
15
    SUM(CASE WHEN oi.discount_percent > 0 THEN oi.quantity ELSE 0 END) AS units_with_discount,
16
    ROUND(
17
      SUM(CASE WHEN oi.discount_percent > 0 THEN oi.quantity ELSE 0 END) * 100 / NULLIF(SUM(oi.quantity), 0)
18
    , 2) AS discount_percentage
19
FROM
20
    products p
21
JOIN
22
    order_items oi ON oi.product_id = p.product_id
23
GROUP BY
24
    p.product_name
25
HAVING
26
    COUNT(oi.quantity) >= 1;
```

## Question 4: Campaign Overlap Analysis
*Task:* Find all pairs of campaigns that had overlapping active dates. For each pair, show the campaign names and the number of overlapping days.

*Expected Output:*

| campaign_1    | campaign_2    | overlap_days |
|---------------|---------------|--------------|
| Spring Sale   | New Customer  | 6            |
| New Customer  | Flash Sale    | 3            |

```sql
SELECT
    mc1.campaign_name AS campaign_1,
    mc2.campaign_name AS campaign_2,
    DATEDIFF(
        LEAST(mc1.end_date, mc2.end_date),
        GREATEST(mc1.start_date, mc2.start_date)
    ) + 1 AS overlap_days
FROM
    marketing_campaigns mc1
JOIN
    marketing_campaigns mc2 ON mc1.campaign_id < mc2.campaign_id
WHERE
    mc1.start_date <= mc2.end_date AND mc2.start_date <= mc1.end_date;
```

---
