# Views and Indexes

As databases grow larger and queries grow more complex, managing logical complexity and maintaining fast read performance becomes critical.

## 1. Views

A View is a virtual table based on the result-set of an SQL statement. It contains rows and columns, just like a real table, but it holds no data itself. It acts as a saved, pre-packaged `SELECT` query.

### Why use Views?
*   **Security:** You can restrict user access to just a few columns instead of the whole core table (e.g. creating a View that hides social security numbers).
*   **Simplicity:** You can hide complex `JOIN` logic and calculations inside a view. End users can just query the View like a standard, flat table.

```sql
-- Creating a complex view
CREATE VIEW "HighValueCustomers" AS
SELECT c.customer_name, c.email, COUNT(o.order_id) as total_orders, SUM(o.amount) as total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.amount > 1000
GROUP BY c.customer_name, c.email;

-- Now anyone can query it simply
SELECT * FROM "HighValueCustomers" WHERE total_spent > 5000;
```

### 1.1 Materialized Views
A standard View executes its underlying query *every single time* you query the View. If the underlying query takes 30 seconds to run, querying the view takes 30 seconds.

A **Materialized View** actually stores the query result physically on disk. Searching it is lightning fast. The tradeoff? It must be manually or asynchronously refreshed when the underlying tables change.

```sql
-- PostgreSQL Syntax for Materialized View
CREATE MATERIALIZED VIEW "MonthlyReports_MV" AS
SELECT month, sum(revenue) FROM massive_ledger GROUP BY month;

-- To update its physical data later:
REFRESH MATERIALIZED VIEW "MonthlyReports_MV";
```

## 2. Indexes

An Index is a database structure used to quickly locate rows in a table. It is like the index at the back of a textbook: instead of reading every page to find a topic (Table Scan), you jump right to the page number (Index Seek).

Index structures physically re-arrange a copy of your columns, usually into a highly efficient B-Tree (Balanced Tree) structure.

### 2.1 Standard (B-Tree) Index

By default, creating an index builds a B-Tree, which is excellent for >, <, =, and `BETWEEN` operations.

```sql
-- Creating an index on the email column
CREATE INDEX idx_customers_email
ON customers (email);

-- Now this query returns instantly instead of scanning millions of rows
SELECT * FROM customers WHERE email = 'bob@example.com';
```

### 2.2 Composite Indexes
If a query frequently filters by two columns simultaneously, an index containing both columns will severely speed it up.

```sql
CREATE INDEX idx_user_status_age
ON users (status, age);

-- Uses the index perfectly
SELECT * FROM users WHERE status = 'active' AND age > 30;
```

### 2.3 Unique Indexes
Used not just for speed, but to enforce data integrity. A `PRIMARY KEY` is automatically backed by a Unique Index.

```sql
CREATE UNIQUE INDEX idx_unique_employee_ssn
ON employees (ssn);
```

### The Cost of Indexing
Why not index every column?
1.  **Storage:** Indexes take up disk space (they copy data).
2.  **Write Degradation:** Every time you `INSERT`, `UPDATE`, or `DELETE` a row, the database must write the data to the table *and* update every single index associated with it. Over-indexing makes modifying data extremely slow.
