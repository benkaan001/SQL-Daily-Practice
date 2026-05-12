## Question 1: Inventory Valuation and Remaining Stock

The finance team needs a report on the current value of inventory remaining in the warehouse as of the end of the day on May 12th.

For each batch, calculate the remaining quantity (Received Quantity - Sum of all Outflows). If the remaining quantity is greater than zero, calculate the `stock_value` as `remaining_qty * unit_cost`.

The final report should show the `batch_id`, `product_name`, `remaining_qty`, and `stock_value`.

| **batch_id** | **product_name** | **remaining_qty** | **stock_value** |
| ------------------ | ---------------------- | ----------------------- | --------------------- |
| EU_FR01_4001       | Brie Cheese            | 30                      | 165.00                |
| US_CA02_2005       | Almond Milk            | 100                     | 250.00                |
| US_CA02_2010       | Almond Milk            | 400                     | 1100.00               |
| US_NY01_1002       | Organic Avocado        | 200                     | 270.00                |

**Your Solution:**

```
-- Write your solution here

```

## Question 2: Category Waste Benchmarking

Management wants to identify batches that are underperforming in terms of waste management.

1. For each `batch_id`, calculate the `waste_percentage` as `(Total Waste Quantity / Received Quantity) * 100`.
2. Compare this percentage against the average `waste_percentage` of all batches within the same `category`.
3. Flag a batch as 'High Waste' if its individual `waste_percentage` is higher than the category average.

The report should show `batch_id`, `category`, `waste_percentage`, and `category_avg_waste_pct`.

| **batch_id** | **category** | **waste_percentage** | **category_avg_waste_pct** |
| ------------------ | ------------------ | -------------------------- | -------------------------------- |
| US_NY01_1001       | Produce            | 10.0000                    | 5.0000                           |
| US_CA02_2005       | Dairy              | 10.0000                    | 3.3333                           |
| US_TX03_3009       | Bakery             | 5.0000                     | 5.0000                           |

**Your Solution:**

```
-- Write your solution here

```

## Question 3: Regional Warehouse Throughput Velocity

The `batch_id` follows the string format `REGION_WHID_LOT#`. We need to analyze which regions and specific warehouses are moving products most efficiently.

1. Extract the `region` (first part before the first underscore) and the `warehouse_id` (middle part between the underscores) from the `batch_id`.
2. Calculate the `total_units_sold` for each warehouse.
3. Calculate the `days_in_operation`: the number of days between the first `received_date` in that warehouse and the last `log_time` recorded for that warehouse.
4. Calculate the `throughput_velocity` as `total_units_sold / days_in_operation`.

| **region** | **warehouse_id** | **total_units_sold** | **days_in_operation** | **throughput_velocity** |
| ---------------- | ---------------------- | -------------------------- | --------------------------- | ----------------------------- |
| EU               | FR01                   | 120                        | 4                           | 30.00                         |
| US               | CA02                   | 900                        | 10                          | 90.00                         |
| US               | NY01                   | 550                        | 5                           | 110.00                        |
| US               | TX03                   | 190                        | 2                           | 95.00                         |

**Your Solution:**

```sql
-- Write your solution here
```

