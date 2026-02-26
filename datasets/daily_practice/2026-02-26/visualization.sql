-- ============================================================================
-- ADVANCED SQL: GAPS AND ISLANDS PATTERN (STEP-BY-STEP BREAKDOWN)
-- ============================================================================
-- Problem: Merge overlapping and back-to-back promotional periods into continuous blocks.
-- 
-- This file breaks down the final complex query into its individual Common 
-- Table Expressions (CTEs) to visualize how the data transforms at each step.
-- We will follow Product 101 as our primary example.

-- ----------------------------------------------------------------------------
-- STEP 1: The Raw Data
-- ----------------------------------------------------------------------------
/* Notice how Product 101 has overlapping dates (March 1-5 and March 4-8),
contiguous dates (March 4-8 and March 9-12), and an isolated date (March 20-25).

| product_id | start_date | end_date   | discount_name  |
|------------|------------|------------|----------------|
| 101        | 2026-03-01 | 2026-03-05 | Spring Kickoff |
| 101        | 2026-03-04 | 2026-03-08 | Flash Sale     |
| 101        | 2026-03-09 | 2026-03-12 | Members Only   |
| 101        | 2026-03-20 | 2026-03-25 | Clearance      |
*/


-- ----------------------------------------------------------------------------
-- STEP 2: calculating `running_boundaries`
-- ----------------------------------------------------------------------------
-- Goal: For every row, find the highest `end_date` we have encountered in ALL 
-- previous rows for this product. 
-- Why?: We need to know how far previous promotions stretched to see if the 
-- current promotion falls inside them or creates a gap.

SELECT 
    product_id,
    start_date,
    end_date,
    MAX(end_date) OVER (
        PARTITION BY product_id 
        ORDER BY start_date 
        ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
    ) AS max_prev_end_date
FROM 
    product_promotions
WHERE 
    product_id = 101;

/* OUTPUT VISUALIZATION:
Notice the 3rd row. Even though the immediately preceding promo ended on March 8, 
if there had been a massive 6-month promo in row 1, `max_prev_end_date` would 
remember it. This prevents "nested" overlaps from breaking the logic.

| start_date | end_date   | max_prev_end_date | Note                                  |
|------------|------------|-------------------|---------------------------------------|
| 2026-03-01 | 2026-03-05 | NULL              | First row, no previous history.       |
| 2026-03-04 | 2026-03-08 | 2026-03-05        | Max end date before this was Mar 5.   |
| 2026-03-09 | 2026-03-12 | 2026-03-08        | Max end date before this was Mar 8.   |
| 2026-03-20 | 2026-03-25 | 2026-03-12        | Max end date before this was Mar 12.  |
*/


-- ----------------------------------------------------------------------------
-- STEP 3: calculating `new_block_flags`
-- ----------------------------------------------------------------------------
-- Goal: Compare the current `start_date` to the `max_prev_end_date`. 
-- If the current start date is strictly greater than the previous max end date 
-- + 1 day, it means there is a gap, and a NEW block has started.

WITH running_boundaries AS (
    SELECT 
        product_id, start_date, end_date,
        MAX(end_date) OVER (PARTITION BY product_id ORDER BY start_date ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS max_prev_end_date
    FROM product_promotions
)
SELECT 
    product_id,
    start_date,
    end_date,
    max_prev_end_date,
    CASE 
        WHEN max_prev_end_date IS NULL THEN 1
        WHEN start_date > DATE_ADD(max_prev_end_date, INTERVAL 1 DAY) THEN 1
        ELSE 0 
    END AS is_new_block
FROM 
    running_boundaries
WHERE 
    product_id = 101;

/* OUTPUT VISUALIZATION:
We now have a binary flag highlighting exactly where the "Gaps" exist.

| start_date | max_prev_end_date | is_new_block | Note                                              |
|------------|-------------------|--------------|---------------------------------------------------|
| 2026-03-01 | NULL              | 1            | Start of very first block.                        |
| 2026-03-04 | 2026-03-05        | 0            | Overlaps! Mar 4 is NOT > Mar 5 + 1 day.           |
| 2026-03-09 | 2026-03-08        | 0            | Contiguous! Mar 9 is NOT > Mar 8 + 1 day.         |
| 2026-03-20 | 2026-03-12        | 1            | GAP DETECTED! Mar 20 IS > Mar 12 + 1 day. New Block!|
*/


-- ----------------------------------------------------------------------------
-- STEP 4: calculating `block_identifiers` (The Island Generator)
-- ----------------------------------------------------------------------------
-- Goal: Turn the 1s and 0s into a unique group ID for each block of overlapping dates.
-- We do this by calculating a running sum of the `is_new_block` flag.

WITH running_boundaries AS (
    SELECT product_id, start_date, end_date, MAX(end_date) OVER (PARTITION BY product_id ORDER BY start_date ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS max_prev_end_date FROM product_promotions
),
new_block_flags AS (
    SELECT product_id, start_date, end_date, CASE WHEN max_prev_end_date IS NULL THEN 1 WHEN start_date > DATE_ADD(max_prev_end_date, INTERVAL 1 DAY) THEN 1 ELSE 0 END AS is_new_block FROM running_boundaries
)
SELECT 
    product_id,
    start_date,
    end_date,
    is_new_block,
    SUM(is_new_block) OVER (
        PARTITION BY product_id 
        ORDER BY start_date
    ) AS block_id
FROM 
    new_block_flags
WHERE 
    product_id = 101;

/* OUTPUT VISUALIZATION:
Notice how the running sum stays the same as long as `is_new_block` is 0. 
This perfectly clusters our overlapping dates into logical "Islands".

| start_date | end_date   | is_new_block | block_id | Note                            |
|------------|------------|--------------|----------|---------------------------------|
| 2026-03-01 | 2026-03-05 | 1            | 1        | Running sum: 1                  |
| 2026-03-04 | 2026-03-08 | 0            | 1        | Running sum: 1+0 = 1            |
| 2026-03-09 | 2026-03-12 | 0            | 1        | Running sum: 1+0+0 = 1          |
| 2026-03-20 | 2026-03-25 | 1            | 2        | Running sum: 1+0+0+1 = 2        |
*/


-- ----------------------------------------------------------------------------
-- STEP 5: Final Aggregation
-- ----------------------------------------------------------------------------
-- Goal: Now that every row has a `block_id`, we simply GROUP BY the product 
-- and the block_id, taking the MIN start date and MAX end date of each island.

/*
FINAL EXPECTED OUTPUT FOR PRODUCT 101:
Rows 1, 2, and 3 are collapsed into block 1. Row 4 stands alone as block 2.

| product_id | promo_block_start | promo_block_end |
|------------|-------------------|-----------------|
| 101        | 2026-03-01        | 2026-03-12      |
| 101        | 2026-03-20        | 2026-03-25      |
*/