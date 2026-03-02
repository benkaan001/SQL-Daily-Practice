## Puzzle: The FIFO Payment Allocation

**The Scenario:** You work on the Accounts Receivable team. Often, customers have multiple outstanding invoices and send in a single "lump sum" payment rather than paying specific invoices. Accounting rules dictate that we must use the **FIFO (First-In-First-Out)** method: the payment must be applied to the oldest invoice first, then the second oldest, and so on, until the payment amount is exhausted.

**Your Task:** Write a query to allocate the lump sum payments to the outstanding invoices. For each invoice, calculate how much of the payment was applied to it, what the remaining balance is, and its new status.

The report should show the `customer_id`, `invoice_id`, `invoice_amount`, `applied_amount`, `remaining_balance`, and `payment_status` ('FULLY PAID', 'PARTIALLY PAID', or 'UNPAID'). Order the results by `customer_id` and `invoice_date`.

| **customer_id** | **invoice_id** | **invoice_amount** | **applied_amount** | **remaining_balance** | **payment_status** |

| 101 | 1 | 300.00 | 300.00 | 0.00 | FULLY PAID |

| 101 | 2 | 500.00 | 500.00 | 0.00 | FULLY PAID |

| 101 | 3 | 400.00 | 200.00 | 200.00 | PARTIALLY PAID |

| 101 | 4 | 600.00 | 0.00 | 600.00 | UNPAID |

| 102 | 5 | 500.00 | 500.00 | 0.00 | FULLY PAID |

| 102 | 6 | 200.00 | 0.00 | 200.00 | UNPAID |

### Tips for Approaching the Problem

This is a classic use case for combining Window Functions with conditional math.

1. **Join the Tables:** First, join the `unpaid_invoices` table with the `lump_sum_payments` table on `customer_id`.
2. **Calculate Running Totals:** You need to know how much debt has accumulated *up to and including* the current invoice. Use a window function: `SUM(invoice_amount) OVER (PARTITION BY customer_id ORDER BY invoice_date) AS running_total`.
3. **Calculate Previous Debt:** You also need to know the accumulated debt *right before* the current invoice. You can do this by subtracting the current `invoice_amount` from the `running_total` you just calculated. Let's call this `running_total_before`.
4. **The Allocation Logic (The Magic Step):** Now use a `CASE` statement to determine the `applied_amount`:
   * If the `payment_amount` is greater than or equal to the `running_total`, this invoice is covered entirely. (`applied = invoice_amount`)
   * If the `payment_amount` is greater than the `running_total_before` (but less than the current running total), the payment covers *part* of this invoice. (`applied = payment_amount - running_total_before`)
   * Otherwise, the payment ran out before reaching this invoice. (`applied = 0`)
5. **Finish Up:** Calculate the `remaining_balance` (`invoice_amount - applied_amount`) and use another `CASE` statement to assign the text status.

**Your Solution:**

```sql
WITH combined_billing_data AS (
    SELECT 
        lsp.customer_id,
        lsp.payment_date,
        lsp.payment_amount,
        ui.invoice_id,
        ui.invoice_date, 
        ui.invoice_amount,
        SUM(ui.invoice_amount) OVER (PARTITION BY lsp.customer_id ORDER BY ui.invoice_date) AS running_total
    FROM    
        lump_sum_payments lsp 
    JOIN
        unpaid_invoices ui ON lsp.customer_id = ui.customer_id
), 
processed_payments AS (
    SELECT
        customer_id, payment_date, payment_amount, invoice_id, invoice_date, invoice_amount,
        running_total - invoice_amount AS remaining_debt,
        payment_amount - running_total AS remaining_funds
    FROM
        combined_billing_data
),
allocated_payments AS (
    SELECT 
        customer_id, 
        invoice_id, 
        invoice_date,
        invoice_amount,
        CASE 
            WHEN remaining_funds >= 0 THEN invoice_amount
            WHEN remaining_funds < 0 AND remaining_debt < payment_amount THEN invoice_amount + remaining_funds
            ELSE 0.00
        END AS applied_amount
    FROM
        processed_payments 
)
SELECT
    customer_id,
    invoice_id,
    invoice_amount,
    applied_amount,
    (invoice_amount - applied_amount) AS remaining_balance,
    CASE 
        WHEN applied_amount = invoice_amount THEN 'FULLY PAID'
        WHEN applied_amount > 0 THEN 'PARTIALLY PAID'
        ELSE 'UNPAID'
    END AS payment_status
FROM
    allocated_payments
ORDER BY 
    customer_id, 
    invoice_date;
```
