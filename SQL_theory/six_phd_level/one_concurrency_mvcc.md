# Concurrency Control and MVCC

When thousands of users interact with a database, you cannot simply pause the whole system every time one person runs an `UPDATE`. How do modern databases like Postgres and Oracle allow massive simultaneous reads and writes without data corruption?

## 1. Traditional Locking Mechanisms

Before MVCC, databases used brute-force locking to maintain the ACID Isolation property.
1.  **Shared Lock (S-Lock):** Used when reading data (`SELECT`). Multiple users can hold an S-Lock on the same row at the same time.
2.  **Exclusive Lock (X-Lock):** Used when modifying data (`UPDATE`/`DELETE`). Only one user can hold an X-Lock. 

**The bottleneck:** If User A is holding an X-Lock to update a row, User B *cannot* acquire an S-Lock to read it. User B is literally frozen, waiting for User A to finish. This creates massive read-latency in write-heavy systems.

## 2. Multi-Version Concurrency Control (MVCC)

MVCC solves the problem where "Readers block Writers, and Writers block Readers."
Under MVCC, an `UPDATE` does not overwrite the physical row on the disk. Instead, it creates a **brand new version** of the row and leaves the old one intact dynamically.

### How it Works (PostgreSQL Example):
Every row in a Postgres table has two hidden system columns: 
*   `xmin`: The ID of the transaction that **created** the row.
*   `xmax`: The ID of the transaction that **deleted/updated** the row.

**Scenario:**
1.  Transaction 100 inserts `Row A` (xmin = 100, xmax = 0).
2.  Transaction 150 decides to update `Row A`. It does NOT destroy it. It sets the old row's `xmax = 150`. It then inserts a newly modified `Row A (v2)` with `xmin = 150`.
3.  Transaction 140 (which began *before* the update) queries the data. Because its Transaction ID (140) is less than the update ID (150), MVCC mathematically routes the query to read the *old* `Row A`. 
4.  Transaction 160 queries the data. Because 160 > 150, it reads the *new* `Row A (v2)`.

**Result:** Readers never wait for Writers! You are simply looking at different "snapshots" of the table based on time.

### The Tradeoff: Vacuuming
Because old versions of rows are kept around (Dead Tuples), the physical file size of the database grows endlessly. Postgres handles this using the `AUTO VACUUM` daemon, a background process that sweeps the disk and physically deletes Dead Tuples once it confirms no active query will ever need to see them again.

## 3. Deadlocks

A deadlock occurs when Transaction A and Transaction B are both waiting for each other to release a lock, resulting in an infinite standoff.

**The Setup:**
1. Transaction A updates Row 1 (Acquires X-Lock on Row 1).
2. Transaction B updates Row 2 (Acquires X-Lock on Row 2).
3. Transaction A tries to update Row 2... but must wait for B.
4. Transaction B tries to update Row 1... but must wait for A.

Both transactions freeze forever. The RDBMS Engine has a "Deadlock Detector" running in the background. If it detects a circular wait, it immediately kills (rolls back) one of the transactions, throwing a `deadlock_detected` error, allowing the other to proceed.

*PhD Architect Tip:* To completely eliminate deadlocks in your software, ensure that your application always updates rows in the exact same alphabetical or numerical order.
