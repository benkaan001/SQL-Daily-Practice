## Puzzle: The "Frequently Bought Together" Analysis

**The Scenario:** As a merchandising analyst, you want to identify product pairs that are frequently purchased together in the same order. This data is crucial for designing bundle offers and product recommendations (e.g., "People who bought X also bought Y").

**Your Task:** Write a query to find all pairs of products that have appeared together in the same `order_id` at least  **3 times** .

The report should show:

1. `product_a`: The name of the first product.
2. `product_b`: The name of the second product.
3. `co_occurrence_count`: The number of unique orders containing both products.

**Rules:**

* To avoid duplicates like (Coffee, Milk) and (Milk, Coffee), ensure that `product_a` comes before `product_b` alphabetically.
* The pair must appear in at least 3 distinct orders.

| **product_a** | **product_b** | **co_occurrence_count** |
| ------------------- | ------------------- | ----------------------------- |
| Almond Milk         | Organic Coffee      | 3                             |

### Tips for Approaching the Problem

1. **Self-Join:** The core of Market Basket Analysis is joining the table to itself on `order_id`. This allows you to create rows representing every combination of items within a single order.
2. **Filter Duplicates:** In your join condition, verify that `item1.product_name < item2.product_name`. This prevents matching a product to itself and ensures that pairs are unique (alphabetical ordering).
3. **Aggregate:** Group by the two product names and `COUNT(*)` (or `COUNT(DISTINCT order_id)` if duplicates within an order are possible).
4. **Filter:** Use `HAVING` to filter for the minimum frequency threshold.

**Your Solution:**

```sql
-- Write your solution here
```
