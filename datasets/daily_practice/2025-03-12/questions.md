# E-commerce Analytics: 20 SQL Practice Questions

## Intermediate Level Questions (1-10)

### Question 1: Customer Order Summary
*Task:* Calculate total orders and total spend per customer segment.

*Expected Output:*

| segment  | total_orders | total_spend |
|----------|--------------|-------------|
| Regular  | 4            | 1632.00     |
| Premium  | 3            | 1180.00     |
| VIP      | 1            |  200.00     |


### Question 2: Product Performance
*Task:* Show top 3 products by revenue (price * quantity - discount).

*Expected Output:*

| product_name    | total_revenue |
|-----------------|---------------|
| Gaming Laptop   | 2040.00       |
| Wireless Earbuds| 450.00        |
| Running Shoes   | 220.00        |


### Question 3: Campaign Effectiveness
*Task:* Calculate conversion rate (conversions/clicks) per campaign.

*Expected Output:*

| campaign_name | conversion_rate |
|---------------|----------------|
| Spring Sale   | 0.10          |
| New Customer  | 0.10          |
| Flash Sale    | 0.10          |


### Question 4: Campaign ROI
*Task:* Calculate the Return on Investment (ROI) for each marketing campaign.
ROI = (Revenue - Investment) / Investment

Assume that any order placed by a customer during the campaign's active dates 
(inclusive) is attributed to that campaign. 

The total cost of the campaign is the sum of the spend recorded in the campaign_performance table. 
If there is no spend data available for a campaign in the campaign_performance table, 
use the budget from the marketing_campaigns table as the total cost.

*Expected Output:*

| campaign_name | ROI  |
|---------------|------|
| Spring Sale   |-0.2  |
| New Customer  |-0.79 |
| Flash Sale    |-0.81 |


### Question 5: Customer Lifetime Value
*Task:* Calculate the lifetime value of each customer (total spend per customer). 
Exclude 'Cancelled' orders in the revenue calculations.

*Expected Output:*

| customer_id | lifetime_value |
|-------------|----------------|
| 1           | 1482.00        |
| 2           | 220.00         |
| 3           | 200.00         |
| 4           | 150.00         |
| 5           | 960.00         |


### Question 6: Geographic Distribution of Sales
*Task:* Calculate total sales per country for orders that are 'Delivered' or 'Shipped'.

*Expected Output:*

| country | total_sales |
|---------|-------------|
| USA     | 1530.00     |
| UK      | 1036.00     |
| Canada  | 200.00      |


### Question 7: Inventory Management
*Task:* Calculate total quantity sold per product.

*Expected Output:*

| product_name    | total_quantity |
|-----------------|----------------|
| Gaming Laptop   | 2              |
| Wireless Earbuds| 2              |
| Running Shoes   | 1              |
| Coffee Maker    | 1              |
| Protein Powder  | 0              |



### Question 8: Customer Satisfaction Metrics
*Task:* Calculate the average resolution time for support tickets.

*Expected Output:*

| average_resolution_time |
|-------------------------|
| 1.0                     |



### Question 10: Market Segment Analysis
*Task:* Calculate the average spend per customer segment.

*Expected Output:*

| segment  | average_spend |
|----------|---------------|
| Regular  | 816.00        |
| Premium  | 518.00        |
| VIP      | 200.00        |


## Advanced Level Questions (11-20)

### Question 11: Customer Retention Analysis
*Task:* Calculate the retention rate of customers (percentage of customers who made repeat purchases).

*Expected Output:*

| retention_rate |
|----------------|
| 0.20           |


### Question 12: Product Cancellation Rate
*Task:* Calculate the cancellation rate of products (percentage of products cancelled).

*Expected Output:*

| product_name    | cancellation_rate |
|-----------------|-------------------|
| Gaming Laptop   | 0.00              |
| Wireless Earbuds| 0.00              |
| Running Shoes   | 0.50              |
| Coffee Maker    | 0.00              |
| Protein Powder  | 0.00              |


### Question 13: Customer Churn Analysis
*Task:* Calculate the churn rate of customers (percentage of customers who did not make a purchase in the last 6 months). 
Assume that the current date is '2022-09-15'

*Expected Output:*

| churn_rate |
|------------|
| 0.40       |


### Question 14: Sales Trend Analysis
*Task:* Calculate the monthly sales trend (total sales per month).

*Expected Output:*

| month | total_sales |
|-------|-------------|
| Mar   | 2868.00     |


### Question 15: Customer Segmentation
*Task:* Segment customers based on their purchase behavior (e.g., high spenders, low spenders).
Low Spender < 100, Medium Spender 100 - 499, High Spender 500+

*Expected Output:*

| customer_id | segment       |
|-------------|---------------|
| 1           | High Spender  |
| 2           | Low Spender   |
| 3           | Medium Spender|
| 4           | Medium Spender|
| 5           | High Spender  |


### Question 16: Customer Acquisition Cost
*Task:* Calculate the customer acquisition cost 
(total marketing spend divided by the number of new customers acquired based on their join date).

*Expected Output:*

| acquisition_cost |
|------------------|
| 5900.00          |



### Question 17: Ticket Resolution Effectiveness Score
*Task:* Calculate the ratio of 'Resolved' support tickets to the total number of support tickets 
that have been resolved (including those marked as 'Resolved' or 'Closed'). 
This provides a measure of the proportion of explicitly 'Resolved' tickets among all completed tickets.

*Expected Output:*

| resolution_effectiveness_rate |
|-------------------------------|
| 0.5                           |



### Question 18: Product Popularity Ranking
*Task:* Calculate the popularity ranking of each product (based on the number of orders).

*Expected Output:*

| product_name    | popularity |
|-----------------|------------|
| Gaming Laptop   | 1          |
| Wireless Earbuds| 1          |
| Running Shoes   | 2          |
| Coffee Maker    | 2          |
| Protein Powder  | 2          |


### Question 19: Customer Feedback Analysis
*Task:* Analyze customer feedback (e.g., positive, negative, neutral) based on support ticket resolution.
Assume: 'Resolved' == Positive -- ('In Progress','Open') == Pending -- 'Closed' == Unknown


*Expected Output:*

| feedback_type | count |
|---------------|-------|
| Positive      | 1     |
| Pending       | 2     |
| Unknown       | 1     |

