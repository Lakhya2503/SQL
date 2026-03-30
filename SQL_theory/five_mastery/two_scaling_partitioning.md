# Scaling, Sharding, and Partitioning

Eventually, your database grows so massive that querying takes inherently too long simply due to physical disk read/write limitations, or your single CPU gets crushed by concurrent user throughput.

There are two primary ways to scale an architecture: **Vertical Scaling** and **Horizontal Scaling**.

## 1. Vertical Scaling (Scaling Up)

Vertical scaling simply means adding more horsepower to a single server instance.
*   **Adding more RAM:** If you have 64GB of RAM, and your database size is 50GB, the *entire database* is effectively loaded into RAM. Your read performance will be mind-bogglingly fast since it does not have to retrieve files off a physical SSD.
*   **Adding more SSDs in RAID:** Increased IOPS (input/output operations per second) to read/write concurrently across channels.

**Pros:** No application logic changes necessary. Instant.
**Cons:** Hits a physical/financial ceiling quickly. A server with 6 TB of DDR5 RAM might cost hundreds of thousands of dollars. You still have a single point of failure.

## 2. Horizontal Scaling (Scaling Out)

Horizontal scaling means keeping the server size the same, but adding *more servers* to form a cluster.

### 2.1 Read Replicas (Replication)
Most applications are read-heavy (90% SELECT, 10% INSERT/UPDATE). Therefore, you offload the `SELECT` pressure across multiple duplicate databases.

1.  **Primary Node (Master):** Handles all `INSERT`, `UPDATE`, `DELETE` operations.
2.  **Replica Nodes (Slaves):** Multiple duplicate databases that handle all `SELECT` operations. Lookups are load-balanced across them.

When data is written to the Primary Node, it is near-instantly pushed outward to the Replicas.

### Tradeoff: Eventual Consistency
Because data must travel over network cables from Primary -> Replica, there is a delay (Replication Lag) usually measured in milliseconds. You might update your profile picture on the Primary Node, but when your browser instantaneously reloads the page (hitting a Replica), you might see the old picture for half a second. This is known as Eventual Consistency.

## 3. Database Partitioning (Table Spitting)

What if you have a single table—say, `historical_logs`—with 5 billion, 10 billion rows? Even with correct indexes, the b-trees themselves get unwieldy. 
In PostgreSQL or SQL Server, you can use **Declarative Partitioning**.

Partitioning splits a massive logical table into multiple smaller physical tables based on a rule, yet the app still queries the single logical address.

### Types of Partitioning

*   **Range Partitioning:** Splitting by ranges like Date. e.g. `logs_2022`, `logs_2023`, `logs_2024`. When you query `WHERE date = '2024-01-01'`, the query planner entirely skips the 2022 and 2023 table spaces.
*   **List Partitioning:** Splitting by explicitly chosen keys. You can partition user data into `users_europe`, `users_america`, and `users_asia` tables.

```sql
-- Creating a table partitioned dynamically by date ranges
CREATE TABLE server_logs (
    log_id INT,
    message TEXT,
    created_at TIMESTAMP
) PARTITION BY RANGE (created_at);

-- Manually creating the physical chunks
CREATE TABLE logs_january PARTITION OF server_logs
    FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');
```

## 4. Sharding 

Partitioning splits tables locally on *one server's disk*. **Sharding** splits massive tables across completely *different physical servers*.

Instead of holding half a billion rows, Database Server A holds Users ID 1 through 25,000,000. Database Server B holds Users ID 25,000,001 through 50,000,000. 

### Why Sharding is Incredibly Dangerous

Your Application Logic OR an "API Gateway/Load Balancer" must intercept every single query, parse the SQL, read the `WHERE` clause, and figure out mathematically which Server specifically holds the data being queried before routing the request.

Moreover, **what happens during a JOIN?**
If a User is on Server A, but their Order History is on Server B, an RDBMS cannot perform a cross-server SQL Join. 
Sharding essentially forces you to break normalized foreign keys or rely on manual application-level javascript/python looping to fetch and join everything. Highly complex and failure-prone; it is the absolute final resort.
