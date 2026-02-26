## Puzzle: The Overlapping Promo Merger

**The Scenario:** The marketing team often runs multiple promotions simultaneously. Some overlap, some are completely contained within others, and some run exactly back-to-back. The pricing engine needs to know the continuous "blocks" of time a product is on *any* promotion so it can display a generic "On Sale!" badge.

**Your Task:** Write a query that merges all overlapping and contiguous promotion periods for each product into single, continuous blocks.

* **Overlapping:** If Promo A runs from March 1 to March 5, and Promo B runs from March 4 to March 8, they merge into March 1 to March 8.
* **Contiguous:** If Promo C runs from March 9 to March 12, it should merge with the previous block, creating a continuous block from March 1 to March 12 (since there is no gap day).
* **Contained:** If Promo D is entirely inside Promo E, it is absorbed into Promo E's dates.

The report should output the `product_id`, the `promo_block_start`, and the `promo_block_end`.

| **product_id** | **promo_block_start** | **promo_block_end** |

| 101 | 2026-03-01 | 2026-03-12 |

| 101 | 2026-03-20 | 2026-03-25 |

| 102 | 2026-04-01 | 2026-04-15 |

| 103 | 2026-05-01 | 2026-05-05 |

| 103 | 2026-05-10 | 2026-05-15 |

### Tips for Approaching the Problem

This is a classic "Gaps and Islands" problem that requires finding the boundaries of overlapping timeframes.

1. **Keep a Running Maximum:** For each row, calculate the highest `end_date` seen *so far* for that product. Use `MAX(end_date) OVER (PARTITION BY product_id ORDER BY start_date ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)`. This tells you how far previous promotions stretched.
2. **Identify the Starts of New Blocks:** Compare the current row's `start_date` to the running maximum `end_date` from the previous row. If the current `start_date` is strictly *greater* than the previous running max `end_date` plus 1 day, then you have found a gap, and this row marks the beginning of a new promotional block. Create a flag (`1` for a new block, `0` otherwise).
3. **Create Block IDs:** Use a cumulative `SUM()` on your "new block" flag over the chronological order of the promotions. This assigns a unique, continuous ID to every row that belongs to the same merged block.
4. **Aggregate:** Finally, `GROUP BY` the `product_id` and the `block_id` you just created. For the start of the block, take the `MIN(start_date)`. For the end of the block, take the `MAX(end_date)`.

**Your Solution:**

```sql
-- Write your solution here
```
