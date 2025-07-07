### Question 1: Inventory Shortage and Dependent Orders

Identify part_ids that are currently below their reorder_level. For each such part, list all order_ids that include this part and are currently Pending.

If a part is below reorder_level but not included in any pending orders, it should still be listed with NULL for order_id.

Return part_id, part_name, current_stock, reorder_level, order_id, and quantity_ordered.

Order the results by part_id ascending, then by order_id ascending (NULLs last).

**Expected Output:**

| part_id | part_name       | current_stock | reorder_level | order_id | quantity_ordered |
| ------- | --------------- | ------------- | ------------- | -------- | ---------------- |
| 1007    | Graphics Card Y | 40            | 50            | 4        | 20               |
| 1007    | Graphics Card Y | 40            | 50            | 7        | 25               |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 2: Monthly Inventory Value Change by Category

Calculate the total change in inventory value for each category of parts on a monthly basis for 2025, considering only orders with order_status 'Delivered' or 'Shipped'.

Inventory value change is approximated by: (total quantity of parts ordered and delivered/shipped in that month) * (cost_per_unit). This represents parts leaving inventory.

Assume that parts are subtracted from inventory on their delivery_date (if 'Delivered') or order_date (if 'Shipped').

Output month_year (format %Y-%m), category, and total_value_decrease.

If a category has no relevant orders in a month, it should not appear.

Round total_value_decrease to two decimal places.

Order the results by month_year ascending, then by category ascending.

**Expected Output:**

| month_year | category    | total_value_decrease |
| ---------- | ----------- | -------------------- |
| 2025-01    | Electronics | 4100.00              |
| 2025-01    | Hardware    | 825.00               |
| 2025-02    | Accessories | 250.00               |
| 2025-02    | Electronics | 8230.00              |
| 2025-03    | Electronics | 3000.00              |
| 2025-03    | Peripherals | 300.00               |
| 2025-04    | Electronics | 400.00               |
| 2025-04    | Hardware    | 300.00               |
| 2025-05    | Peripherals | 400.00               |

**Your Solution:**

```sql
--- Write your solution here

```

### Question 3: Customers with Mixed Order Statuses

Identify customer_names who have placed orders that are both 'Pending' (or 'Shipped') and 'Delivered' in 2025.

For these customers, return their customer_name and the count_of_pending_or_shipped_orders, and count_of_delivered_orders.

Order the results by customer_name ascending.

**Expected Output:**

| customer_name       | count_of_pending_or_shipped_orders | count_of_delivered_orders |
| ------------------- | ---------------------------------- | ------------------------- |
| Global Systems Ltd. | 2                                  | 1                         |
| Innovate Corp.      | 1                                  | 1                         |
| Tech Solutions Inc. | 1                                  | 2                         |

**Your Solution:**

```sql
--- Write your solution here

```
