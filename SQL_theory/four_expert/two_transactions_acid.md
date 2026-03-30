# Transactions and Data Integrity (ACID)

Databases are built to handle thousands of users interacting with data simultaneously. What happens if two people try to buy the exact same concert ticket at the exact same millisecond? This is handled using Transactions and isolation locking.

## 1. What is a Transaction?

A transaction is a single discrete unit of work. It might encompass one SQL query, or it might encompass a hundred queries running back-to-back.
If anything fails during the hundred queries, **everything** is undone (Rolled back). A transaction is "all or nothing," preventing partial updates.

### Transaction Commands (TCL)
*   **`BEGIN TRANSACTION`**: Starts the transaction block.
*   **`COMMIT`**: Saves all changes made during the transaction permanently.
*   **`ROLLBACK`**: Undoes all changes back to the start of the `BEGIN` block.

```sql
BEGIN;

-- Deduct 500 from Account A
UPDATE accounts SET balance = balance - 500 WHERE account_id = 'A';

-- Server crashes unexpectedly here??
-- Or:
-- Add 500 to Account B
UPDATE accounts SET balance = balance + 500 WHERE account_id = 'B';

-- If both succeeded smoothly:
COMMIT;

-- If an error happens midway, you catch the error and execute:
ROLLBACK;
```
If you didn't have transactions, and the server crashed between the two updates, Account A would lose $500, but Account B would never receive it. The money vanishes. Transactions prevent this.

## 2. The ACID Properties

For a system to be considered a robust RDBMS, the transactions must adhere to the **ACID** properties.

1.  **Atomicity (All or Nothing):** The entire transaction takes place at once or doesn't happen at all. A transaction cannot be partially completed. 
2.  **Consistency:** The database must remain in a consistent state before and after the transaction. Constraints (like Foreign Keys or specific datatypes) cannot be violated during the update.
3.  **Isolation:** Multiple transactions occurring at the same time must not impact each other. One query shouldn't see the half-finished work of another query.
4.  **Durability:** Once a transaction is `COMMIT`ted, the changes are permanent. Even if the server loses power a microsecond later, upon reboot, the change will be there (this is usually handled by writing to a Write-Ahead Log / WAL before telling the user "success").

## 3. Concurrency Phenomena
If locking and isolation are poorly tuned, "phenomena" occur:

*   **Dirty Read:** Transaction A reads data that Transaction B is modifying, *before* B commits. If B then `ROLLBACK`s, A read data that essentially never existed.
*   **Non-Repeatable Read:** Transaction A reads a row. Transaction B overwrites that row and commits. If A reads the same row again in the same transaction, the data is totally different.
*   **Phantom Read:** Transaction A does a count `SELECT COUNT(*) WHERE age > 30`. Transaction B executes an `INSERT` of someone aged 35. A reruns the count and finds an extra "ghost" row appeared.

## 4. Isolation Levels
You can specifically configure how strict your SQL database should be about the above phenomena.

1.  **Read Uncommitted:** The lowest tier. Massive performance, but allows Dirty Reads, Non-Repeatable Reads, and Phantom Reads.
2.  **Read Committed:** (Default in Postgres & SQL Server). Prevents Dirty Reads. 
3.  **Repeatable Read:** Prevents Dirty Reads and Non-Repeatable reads. Will lock the rows you are actively `SELECT`ing from being updated by others.
4.  **Serializable:** The strictest tier. Essentially places transactions in a queue so they happen completely one after another. No phenomena allowed. However, this causes massive slowness and frequent deadlock errors.

```sql
-- Syntax to set isolation level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;
-- do work
COMMIT;
```
