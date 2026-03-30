# Basic SQL Queries

Now that you know what a Database and a DBMS are, let's learn how to actually fetch and manipulate data. The most fundamental SQL statement is `SELECT`.

## The SELECT Statement

The `SELECT` statement is the core of DQL (Data Query Language). It is used to select data from a database. 
The data returned is stored in a result table, called the result-set.

### 1. Selecting All Columns
To select every column from a table, you use the asterisk `*` character.

```sql
SELECT * FROM employees;
```

### 2. Selecting Specific Columns
Usually, you don't need all columns. It's best practice (and faster) to select only the columns you specifically need.

```sql
SELECT first_name, last_name, email FROM employees;
```

## Filtering Data with WHERE

The `WHERE` clause is used to filter records. It extracts only those records that fulfill a specified condition.

```sql
-- Select all employees who work in the IT department
SELECT * FROM employees
WHERE department = 'IT';
```

### Operators in The WHERE Clause

You can use various operators to filter your data:

| Operator | Description | Example |
| :--- | :--- | :--- |
| `=` | Equal | `age = 30` |
| `>` | Greater than | `salary > 50000` |
| `<` | Less than | `salary < 40000` |
| `>=` | Greater than or equal | `points >= 100` |
| `<=` | Less than or equal | `points <= 50` |
| `<>` or `!=` | Not equal | `department != 'HR'` |
| `BETWEEN` | Between a certain range | `age BETWEEN 20 AND 30` |
| `LIKE` | Search for a pattern | `name LIKE 'S%'` |
| `IN` | Specify multiple possible values | `city IN ('Paris', 'London')` |

### Combining Conditions (AND, OR, NOT)

You can combine multiple conditions using logical operators:

```sql
-- Find employees in IT who earn more than 60,000
SELECT * FROM employees
WHERE department = 'IT' AND salary > 60000;

-- Find employees who are either in HR or Finance
SELECT * FROM employees
WHERE department = 'HR' OR department = 'Finance';

-- Shorthand for the OR statement above using IN:
SELECT * FROM employees
WHERE department IN ('HR', 'Finance');
```

## Pattern Matching with LIKE

The `LIKE` operator is used with the `WHERE` clause to search for a specified pattern in a column.
There are two main wildcards used in conjunction with `LIKE`:
- `%` - Represents zero, one, or multiple characters.
- `_` - Represents a single character.

```sql
-- Find all customers whose name starts with an 'A'
SELECT * FROM customers
WHERE customer_name LIKE 'A%';

-- Find all customers whose name has 'or' in any position
SELECT * FROM customers
WHERE customer_name LIKE '%or%';

-- Find all customers whose name has an 'a' in the second position
SELECT * FROM customers
WHERE customer_name LIKE '_a%';
```

## Sorting Data with ORDER BY

The `ORDER BY` keyword is used to sort the result-set in ascending or descending order.
It sorts the records in ascending order by default (`ASC`). To sort the records in descending order, use the `DESC` keyword.

```sql
-- Sort employees by salary from lowest to highest
SELECT * FROM employees
ORDER BY salary;

-- Sort employees by salary from highest to lowest
SELECT * FROM employees
ORDER BY salary DESC;

-- Sort by multiple columns (Department A-Z, then Salary Highest-Lowest)
SELECT * FROM employees
ORDER BY department ASC, salary DESC;
```

## Limiting Results with LIMIT / TOP

Often you don't want to return thousands of rows, you only want the "Top 5" or "First 10". 
*(Note: Syntax varies slightly based on the specific RDBMS. `LIMIT` is used in PostgreSQL, MySQL, SQLite. `TOP` is used in SQL Server.)*

```sql
-- PostgreSQL / MySQL syntax: Get the 5 highest paid employees
SELECT first_name, salary FROM employees
ORDER BY salary DESC
LIMIT 5;

-- SQL Server syntax (for comparison):
-- SELECT TOP 5 first_name, salary FROM employees ORDER BY salary DESC;
```

### Pagination (OFFSET)
You can use `OFFSET` together with `LIMIT` to skip a specific number of rows. This is how web pagination (Page 1, Page 2...) works.

```sql
-- Skip the first 10 results, then return the next 5
SELECT * FROM employees
ORDER BY id
LIMIT 5 OFFSET 10;
```
