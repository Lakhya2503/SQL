# Aggregation and Subqueries

Once you understand how to fetch single rows mapping to your requirements, you eventually want to aggregate that data—meaning you want to summarize it.

## 1. Aggregate Functions

Aggregate functions perform a calculation on a set of values, and return a single summarizing value. They are incredibly useful for reporting.

### Common Aggregate Functions:
*   `COUNT()` - Returns the number of rows.
*   `SUM()` - Returns the total sum of a numeric column.
*   `AVG()` - Returns the average value of a numeric column.
*   `MIN()` - Returns the smallest value of the selected column.
*   `MAX()` - Returns the largest value of the selected column.

```sql
-- Find out how many employees the company has
SELECT COUNT(employee_id) FROM employees;

-- Figure out the total payroll expenses
SELECT SUM(salary) FROM employees;

-- Figure out the highest salary being paid
SELECT MAX(salary) FROM employees;
```

## 2. GROUP BY

You can combine aggregate functions with `GROUP BY` to categorize results. Instead of a single sum for the whole company, maybe you want the sum per department.

```sql
-- Count how many customers exist in each country
SELECT country, COUNT(customer_id) as total_customers
FROM customers
GROUP BY country;
```

When you use aggregation along with non-aggregated columns (like `country`), you MUST group by those non-aggregated columns.

```sql
-- Calculate the max salary by department, and order from highest to lowest
SELECT department, MAX(salary)
FROM employees
GROUP BY department
ORDER BY MAX(salary) DESC;
```

## 3. The HAVING Clause

The `WHERE` clause cannot be used with aggregate functions. That's why SQL implemented the `HAVING` clause. `HAVING` acts exactly like `WHERE`, except it filters *after* the grouping has occurred.

```sql
-- Find departments where the total payroll is greater than 1,000,000
SELECT department, SUM(salary)
FROM employees
GROUP BY department
HAVING SUM(salary) > 1000000;
```
### Execution Order Refresher
The order in which SQL logic evaluates is specific:
`FROM` -> `WHERE` -> `GROUP BY` -> `HAVING` -> `SELECT` -> `ORDER BY` -> `LIMIT`

## 4. Subqueries

A subquery is a query nested inside another query (like inside a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement). They are incredibly powerful for complex logic.

### 4.1 Subquery in the WHERE Clause (Most Common)
Using a subquery to filter against a dynamic value rather than a hardcoded number.

```sql
-- Find all employees making more than the average salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```
*Note: The inner query runs first, calculates a single number (e.g. 50,000), and then the outer query filters using that number.*

### 4.2 IN Operator with Subqueries
You can return a list of values to match against using `IN`.

```sql
-- Find all customers who have placed at least one order
SELECT name, email
FROM customers
WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);
```

### 4.3 Subqueries in the SELECT Clause
You can use a subquery to generate a derived column.

```sql
-- Show an employee's salary alongside the company max
SELECT 
    first_name, 
    salary,
    (SELECT MAX(salary) FROM employees) AS company_maximum
FROM employees;
```

### 4.4 Correlated Subqueries
A correlated subquery is a subquery that uses values from the outer query. It's evaluated once for each row processed by the outer query (making them resource-heavy).

```sql
-- Find employees who earn more than the average salary for *their specific department*
SELECT e1.first_name, e1.salary, e1.department
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary) 
    FROM employees e2 
    WHERE e1.department = e2.department
);
```
