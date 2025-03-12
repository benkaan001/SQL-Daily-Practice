# E-commerce Analytics: 20 SQL Practice Questions

## Intermediate Level Questions (1-10)

### Question 1: Customer Order Summary
*Task:* Calculate total orders and total spend per customer segment.

*Expected Output:*
```
| segment  | total_orders | total_spend |
|----------|--------------|-------------|
| Regular  | 3           | 1590.00     |
| Premium  | 3           | 1360.00     |
| VIP      | 1           | 200.00      |
```

### Question 2: Product Performance
*Task:* Show top 3 products by revenue (price * quantity - discount).

*Expected Output:*
```
| product_name    | total_revenue |
|-----------------|--------------|
| Gaming Laptop   | 2160.00     |
| Wireless Earbuds| 450.00      |
| Coffee Maker    | 200.00      |
```

### Question 3: Campaign Effectiveness
*Task:* Calculate conversion rate (conversions/clicks) per campaign.

*Expected Output:*
```
| campaign_name | conversion_rate |
|---------------|----------------|
| Spring Sale   | 0.10          |
| New Customer  | 0.10          |
| Flash Sale    | 0.10          |
```

### Question 4: Campaign ROI
*Task:* Calculate return on investment (ROI) for each campaign.

*Expected Output:*
```
| campaign_name | ROI |
|---------------|-----|
| Spring Sale   | 1.2 |
| New Customer  | 1.5 |
| Flash Sale    | 1.0 |
```

### Question 5: Customer Lifetime Value
*Task:* Calculate the lifetime value of each customer (total spend per customer).

*Expected Output:*
```
| customer_id | lifetime_value |
|-------------|----------------|
| 1           | 1350.00        |
| 2           | 300.00         |
| 3           | 80.00          |
| 4           | 200.00         |
| 5           | 40.00          |
```

### Question 6: Geographic Distribution of Sales
*Task:* Calculate total sales per country.

*Expected Output:*
```
| country | total_sales |
|---------|-------------|
| USA     | 1550.00     |
| UK      | 190.00      |
| Canada  | 80.00       |
```

### Question 7: Inventory Management
*Task:* Calculate total quantity sold per product.

*Expected Output:*
```
| product_name    | total_quantity |
|-----------------|----------------|
| Gaming Laptop   | 3              |
| Wireless Earbuds| 3              |
| Running Shoes   | 3              |
| Coffee Maker    | 1              |
| Protein Powder  | 3              |
```

### Question 8: Customer Satisfaction Metrics
*Task:* Calculate the average resolution time for support tickets.

*Expected Output:*
```
| average_resolution_time |
|-------------------------|
| 2.5                     |
```

### Question 9: Order Fulfillment Metrics
*Task:* Calculate the average order processing time (order_date to delivery_date).

*Expected Output:*
```
| average_processing_time |
|-------------------------|
| 5.0                     |
```

### Question 10: Market Segment Analysis
*Task:* Calculate the average spend per customer segment.

*Expected Output:*
```
| segment  | average_spend |
|----------|---------------|
| Regular  | 530.00        |
| Premium  | 680.00        |
| VIP      | 200.00        |
```

## Advanced Level Questions (11-20)

### Question 11: Customer Retention Analysis
*Task:* Calculate the retention rate of customers (percentage of customers who made repeat purchases).

*Expected Output:*
```
| retention_rate |
|----------------|
| 0.60           |
```

### Question 12: Product Return Rate
*Task:* Calculate the return rate of products (percentage of products returned).

*Expected Output:*
```
| product_name    | return_rate |
|-----------------|-------------|
| Gaming Laptop   | 0.10        |
| Wireless Earbuds| 0.00        |
| Running Shoes   | 0.05        |
| Coffee Maker    | 0.00        |
| Protein Powder  | 0.15        |
```

### Question 13: Customer Churn Analysis
*Task:* Calculate the churn rate of customers (percentage of customers who did not make a purchase in the last 6 months).

*Expected Output:*
```
| churn_rate |
|------------|
| 0.40       |
```

### Question 14: Sales Trend Analysis
*Task:* Calculate the monthly sales trend (total sales per month).

*Expected Output:*
```
| month | total_sales |
|-------|-------------|
| Jan   | 1200.00     |
| Feb   | 1500.00     |
| Mar   | 2000.00     |
```

### Question 15: Customer Segmentation
*Task:* Segment customers based on their purchase behavior (e.g., high spenders, low spenders).

*Expected Output:*
```
| customer_id | segment      |
|-------------|--------------|
| 1           | High Spender |
| 2           | Low Spender  |
| 3           | Low Spender  |
| 4           | Medium Spender|
| 5           | Low Spender  |
```

### Question 16: Customer Acquisition Cost
*Task:* Calculate the customer acquisition cost (total marketing spend divided by the number of new customers acquired).

*Expected Output:*
```
| acquisition_cost |
|------------------|
| 500.00           |
```

### Question 17: Customer Satisfaction Score
*Task:* Calculate the average customer satisfaction score (based on support ticket resolution).

*Expected Output:*
```
| average_satisfaction_score |
|----------------------------|
| 4.5                        |
```

### Question 18: Product Popularity
*Task:* Calculate the popularity of each product (based on the number of orders).

*Expected Output:*
```
| product_name    | popularity |
|-----------------|------------|
| Gaming Laptop   | 3          |
| Wireless Earbuds| 3          |
| Running Shoes   | 3          |
| Coffee Maker    | 1          |
| Protein Powder  | 3          |
```

### Question 19: Customer Feedback Analysis
*Task:* Analyze customer feedback (e.g., positive, negative, neutral) based on support ticket resolution.

*Expected Output:*
```
| feedback_type | count |
|---------------|-------|
| Positive      | 3     |
| Negative      | 1     |
| Neutral       | 0     |
```

### Question 20: Sales Forecasting
*Task:* Forecast future sales based on historical data.

*Expected Output:*
```
| month | forecasted_sales |
|-------|------------------|
| Apr   | 2200.00          |
| May   | 2400.00          |
| Jun   | 2600.00          |
```