## Puzzle: The Malicious Subnet Detector

**The Scenario:** The Trust & Safety team is monitoring authentication logs to identify "distributed brute-force attacks." Instead of a single IP address trying hundreds of passwords, attackers often use botnets to distribute login failures across many different IP addresses within the same neighborhood (subnet).

The security team wants to block entire `/24` subnets (the first three octets of an IPv4 address, e.g., `192.168.1`) if they exhibit organized malicious behavior.

**Your Task:** Write a query to flag malicious subnets. A subnet should be flagged if it meets **both** of the following conditions:

1. It has more `FAILED` login attempts than `SUCCESS` login attempts overall.
2. The login attempts originated from at least **3 distinct** IP addresses within that subnet.

The final report should show the `subnet`, the `unique_ip_count`, the `failed_attempts`, and the `successful_attempts`. Order the results by `failed_attempts` in descending order.

**Expected Output:**

| **subnet** | **unique_ip_count** | **failed_attempts** | **successful_attempts** |
| ---------------- | ------------------------- | ------------------------- | ----------------------------- |
| 203.0.113        | 4                         | 6                         | 1                             |

### Tips for Approaching the Problem

1. **Extract the Subnet:** IPv4 addresses consist of 4 numbers separated by periods (dots). A `/24` subnet consists of the first three numbers. You need to manipulate the `ip_address` string to chop off the last dot and the number following it.
   * *MySQL Hint:* Look into the `SUBSTRING_INDEX()` function. It allows you to extract parts of a string based on a delimiter and a count. `SUBSTRING_INDEX(string, '.', 3)` is incredibly useful here.
2. **Group and Aggregate:** Once you can successfully extract the subnet into a column in your `SELECT` clause, you can `GROUP BY` that calculated subnet string.
3. **Conditional Counting:** Inside your `SELECT` and `HAVING` clauses, you will need to count events conditionally.
   * To count unique IPs: `COUNT(DISTINCT ip_address)`
   * To count successes: `SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END)`
   * To count failures: `SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END)`
4. **Apply the Rules:** Put your business logic rules directly into a `HAVING` clause after your `GROUP BY`. Compare your calculated sum of failures to your sum of successes, and check your distinct IP count constraint.

**Your Solution:**

```sql
-- Write your solution here
```

