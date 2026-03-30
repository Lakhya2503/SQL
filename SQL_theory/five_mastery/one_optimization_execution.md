# Query Optimization & Execution Plans

Writing a query string is not executing a query. A query goes through an internal Parser, a Planner, an Optimizer, and finally the Executor.

The Optimizer receives your SQL text and builds out dozens of potential ways to physically retrieve the data (called an Execution Plan). It evaluates standard `seq_scan` execution vs nested-loop joins, vs hash joins, looking for the most efficient (lowest "Cost") sequence of commands. 
Cost is an arbitrary unit calculated based on the CPU speed, disk I/O, and amount of RAM available.

## 1. EXPLAIN and EXPLAIN ANALYZE

You can (and absolutely should) ask the database to tell you the steps it took, so you can optimize it.

*   `EXPLAIN`: Shows you the plan and the "guess" of how much it'll cost without running the query.
*   `EXPLAIN ANALYZE` (Requires Postgres, SQL Server uses "Actual Execution Plan"): Actually runs the query for real, and gives you the exact time it took and the specific rows processed per operation node.

```sql
-- Read an execution plan
EXPLAIN ANALYZE
SELECT e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.salary > 100000;
```

**Common Nodes You Will See:**
*   **Seq Scan (Sequential Scan):** The database started at row 1 and read all the way to the end in a straight line. If you are scanning 10 million rows just to find 1 user, this is a red flag indicating a missing index.
*   **Index Scan:** The database traversed an index (B-Tree) to quickly find specific row addresses. Extremely fast.
*   **Nested Loop Join:** The database looped through the smaller table. For *every single row* in the smaller table, it scanned the larger table for a match. Slow for massive datasets.
*   **Hash Join:** The database read one table and built an in-memory Hash Table using the join key. It then scanned the second table, checking the Hash for lightning-fast matching. Massive speedup if RAM is available.

## 2. Why Is My Query So Slow?

If your `SELECT` query is slow, don't blindly throw RAM at the server. Check these concepts:

### SARGability (Search Argument Able)
To use an index, your `WHERE` clause must be "SARGable"—meaning the optimizer is mathematically capable of using the B-Tree index. Wrapping columns in functions universally breaks SARGability.

**BAD (Un-SARGable): Causes a brutal Seq Scan across millions of rows.**
```sql
-- Can't use an index on order_date because you wrapped it in a YEAR() function!
SELECT * FROM orders WHERE YEAR(order_date) = 2023;

-- Can't use an index on email because of wildcard at the start!
SELECT * FROM users WHERE email LIKE '%@gmail.com';
```

**GOOD (SARGable): Immediately uses the B-Tree index.**
```sql
-- Perfect index seek!
SELECT * FROM orders WHERE order_date >= '2023-01-01' AND order_date < '2024-01-01';

-- Perfect index seek because wildcard is only at the end.
SELECT * FROM users WHERE email LIKE 'johndoe@%';
```

### 3. N+1 Queries Problem
Often caused by Object-Relational Mappers (ORMs) in software development (like Prisma, Hibernate, or Entity Framework).
It happens when your application loads 100 Post records (1 Query), then loops through those 100 Posts and fires an individual SELECT query to get the Author for each Post (100 Queries).
The Fix? Use an `INNER JOIN` or `IN` clause to fetch the authors along with the posts simultaneously (bringing the total to 1 query).

### 4. Over-Indexing
While an Index Scan is faster than a Seq Scan, there are caveats.
Every single `INSERT`, `UPDATE`, or `DELETE` has to update the Table, and then individually rewrite *every index* mapped to that table. If you have 20 indexes on a table, 1 `INSERT` actually spins out 21 writes. This fundamentally destroys ingest/write speed.
Only index columns being heavily used in `WHERE`, `JOIN`, or `ORDER BY`.

### 5. Index Maintenance (Bloat)
If a table has billions of row updates, the B-Tree index becomes fragmented (bloated) with dead space left over from deletes. Regularly running a `REINDEX` or `VACUUM` process rebuilds index blocks physically, resolving the fragmentation.
