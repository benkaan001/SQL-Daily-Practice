## Puzzle: The Bakery's Limiting Ingredient (Bill of Materials)

**The Scenario:** You are managing the database for a local bakery. The head baker wants to know exactly how many full batches of each recipe they can prepare today based strictly on what is currently sitting in the pantry.

A recipe is limited by its scarcest ingredient relative to the required amount. If an ingredient is completely missing from the pantry, you cannot make *any* batches of that recipe.

**Your Task:** Write a query to calculate the maximum number of full batches that can be made for each recipe.

The final report should show the `recipe_name` and the `max_batches_possible`. Order the results from the most batches possible down to the least, and then alphabetically by recipe name.

**Expected Output:**

| **recipe_name** | **max_batches_possible** |

| Sugar Cookies | 10 |

| Pound Cake | 3 |

| Chocolate Chip Cookies | 2 |

| Blueberry Muffin | 0 |

*(Note: We can only make 2 batches of Chocolate Chip Cookies because we only have 400g of chocolate chips, and each batch requires 200g. The Blueberry Muffin requires 'Blueberries', which are not in the inventory table at all!)*

### Tips for Approaching the Problem

1. **Calculate Batches per Ingredient:** First, figure out how many batches you could make if you *only* considered one ingredient at a time. To do this, divide the inventory `stock_qty` by the recipe's `required_qty`.
2. **Handle Partial Batches:** The baker only cares about *full* batches. Use the `FLOOR()` function to round the division result down to the nearest whole number.
3. **Handle Missing Ingredients:** You need to `LEFT JOIN` your `recipe_requirements` table to your `bakery_inventory` table. This ensures recipes with missing ingredients (like the Blueberry Muffin) aren't accidentally dropped from the calculation. Use `COALESCE(stock_qty, 0)` to treat missing inventory rows as having `0` stock.
4. **Find the Limiting Factor:** Now that you know how many batches each individual ingredient can support, you just need to find the bottleneck! `GROUP BY` the `recipe_name` and use the `MIN()` aggregate function on your calculated batch numbers. The smallest number determines the maximum possible batches for the entire recipe.

**Your Solution:**

```sql
-- Write your solution here
```
