# Advanced SQL: Window Functions and CTEs

When basic `GROUP BY` aggregations and subqueries are no longer enough to structure complex logic gracefully, we turn to Common Table Expressions and Window Functions.

## 1. Common Table Expressions (CTEs)

A CTE is a temporary named result set that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. They are defined using the `WITH` keyword. Think of them as "temporary views" or "cleaner subqueries".

### Why use a CTE over a Subquery?
*   **Readability:** It makes massively nested subqueries linear (top-to-bottom logic).
*   **Reusability:** You can reference the same CTE multiple times in the same main query.
*   **Recursion:** CTEs can be self-referencing (Recursive CTEs) to traverse hierarchical data.

```sql
-- CTE Example: Find departments spending more than the average department total
WITH DepartmentTotals AS (
    SELECT department, SUM(salary) AS total_payroll
    FROM employees
    GROUP BY department
),
AverageDepartmentPayroll AS (
    SELECT AVG(total_payroll) AS avg_payroll
    FROM DepartmentTotals
)
SELECT dt.department, dt.total_payroll
FROM DepartmentTotals dt
CROSS JOIN AverageDepartmentPayroll adp
WHERE dt.total_payroll > adp.avg_payroll;
```

### 1.1 Recursive CTEs
Recursive CTEs are used to query hierarchical data, like a family tree or a company's org chart (employee -> manager -> CEO).

```sql
WITH RECURSIVE OrgChart AS (
    -- Base Case: Find the CEO (ManagerID is NULL)
    SELECT EmployeeID, FirstName, ManagerID, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    -- Recursive Step: Join employees to their managers who are already in the query
    SELECT e.EmployeeID, e.FirstName, e.ManagerID, o.Level + 1
    FROM Employees e
    INNER JOIN OrgChart o ON o.EmployeeID = e.ManagerID
)
SELECT * FROM OrgChart ORDER BY Level;
```

## 2. Window Functions

Window functions operate on a set of rows and return a single value for each row from the underlying query. The term `window` describes the set of rows on which the function operates.

Unlike aggregate functions (`GROUP BY`), window functions do **not** cause rows to become grouped into a single output row — the rows retain their separate identities.

### Anatomy of a Window Function
`function_name(arg) OVER ( [PARTITION BY partition_expression] [ORDER BY sort_expression] [Window Frame] )`

*   **`PARTITION BY`**: Divides rows into groups (like `GROUP BY` but doesn't collapse them).
*   **`ORDER BY`**: Sorts rows within the partition.
*   **`OVER`**: The keyword that identifies it is a window function.

### 2.1 ROW_NUMBER(), RANK(), DENSE_RANK()
These assign an incremental number/rank to rows.

```sql
-- Rank salaries within their specific department
SELECT 
    first_name, 
    department, 
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as row_id,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dept_rank,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dense_rank
FROM employees;
```
*   `ROW_NUMBER()` is strictly sequential (1, 2, 3, 4)
*   `RANK()` skips numbers for ties (1, 2, 2, 4)
*   `DENSE_RANK()` does not skip numbers for ties (1, 2, 2, 3)

### 2.2 LEAD() and LAG()
Used to access data from previous (`LAG`) or subsequent (`LEAD`) rows without a self-join. Crucial for calculating sequential differences (e.g., month-over-month growth).

```sql
-- Compare monthly revenue to the previous month's revenue
SELECT 
    month, 
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) as previous_month_revenue,
    revenue - LAG(revenue, 1) OVER (ORDER BY month) as month_over_month_difference
FROM monthly_sales;
```

### 2.3 Aggregate Window Functions
You can use `SUM`, `AVG`, `MIN`, `MAX` with the `OVER` clause to keep the individual row detail.

```sql
-- Show an employee's exact salary alongside their department's average salary
SELECT 
    first_name, 
    department, 
    salary,
    AVG(salary) OVER(PARTITION BY department) as dept_avg_salary
FROM employees;
```

### 2.4 Running Totals (Cumulative Sums)
If you combine an aggregate function with `ORDER BY` inside the `OVER` clause, you get a running total.

```sql
-- Calculate a running total of deposits ordered by date
SELECT 
    transaction_date, 
    deposit_amount,
    SUM(deposit_amount) OVER(ORDER BY transaction_date) as cumulative_balance
FROM bank_transactions;
```
