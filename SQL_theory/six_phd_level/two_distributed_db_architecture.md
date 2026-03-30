# Distributed Architecture & Database Internals

How are indexes actually built in RAM? How does a global database spanned across 5 continents agree on what the current bank balance is? This is the domain of Database Architecture.

## 1. Storage Engine Architectures

Under the hood, SQL syntax is completely irrelevant. Data must be written to spinning magnetic disks or NAND flash SSDs. There are two dominant architectures.

### 1.1 B-Tree (Balanced Tree)
The undisputed king of relational databases (Postgres, MySQL, Oracle). Data is organized in a hierarchical tree where leaves are strictly sorted.
*   **Pros:** Incredible for heavy Read workloads. Unmatched for Range queries (`WHERE date > X AND date < Y`).
*   **Cons:** Write Amplification. Updating data requires rebalancing the tree structure, which causes randomized disk writes.

### 1.2 LSM Tree (Log-Structured Merge-Tree)
The king of NoSQL and massive ingest systems (Cassandra, RocksDB, Kafka). Instead of rebalancing a tree, writes are simply appended to a sequential log in memory (MemTable). Once full, it dumps sequentially to disk (SSTable).
*   **Pros:** Unbelievable Write speed. Can ingest millions of rows per second onto cheap hardware.
*   **Cons:** Read amplification. To find data, the engine has to comb through multiple SSTables on disk, merging them on the fly.

## 2. Distributed Systems: The CAP Theorem

When you scale horizontally across multiple machines, you are bound by Eric Brewer's CAP Theorem. It states that a distributed data store can simultaneously provide only *two out of the following three guarantees*:

1.  **Consistency (C):** Every read receives the most recent write or an error. (If I update my password, my next login attempt *must* use the new one).
2.  **Availability (A):** Every request receives a (non-error) response, without the guarantee that it contains the most recent write. (The system never goes down).
3.  **Partition Tolerance (P):** The system continues to operate despite an arbitrary number of messages being dropped/delayed by the network between nodes.

**Because network outages (Partitions) are a physical reality of the universe, you *MUST* choose P. Therefore, the choice is between CP and AP.**

*   **CP Systems (Consistency over Availability):** Traditional SQL clusters, MongoDB. If the network splits, the system will refuse writes to prevent data corruption. (Safe for banking).
*   **AP Systems (Availability over Consistency):** Cassandra, DynamoDB. If the network splits, the system keeps accepting writes on both sides. Users get 24/7 uptime, but they might be reading slightly stale data. (Safe for Twitter likes).

## 3. Distributed Consensus (Paxos & Raft)

If you have a primary write node and two replicas, and the primary node explodes, how do the two replicas choose who becomes the new boss?
If they both claim to be the boss (Split-Brain scenario), data corruption is imminent.

Distributed databases use Consensus Algorithms—most notably **Raft** or **Paxos**.
*   They require a "Quorum" (majority) to make a decision. E.g., You need at least 3 nodes to survive 1 failure (2 nodes can out-vote the broken 1).
*   When a leader dies, the remaining nodes start an election with randomized timers, voting for the new leader cryptographically.

## 4. NewSQL: The Holy Grail

For decades, the rule was: 
*Want ACID Transactions? Use SQL (Doesn't scale horizontally easily).*
*Want Infinite Scaling? Use NoSQL (Lose transactions and JOINs).*

**NewSQL** (Google Spanner, CockroachDB) modifies the CAP theorem boundaries. They offer full ACID SQL compliance, JOINs, and foreign keys, but are built natively on top of Raft-like distributed storage engines, allowing them to scale horizontally across the globe without losing transactional integrity. They achieve this using synchronized atomic clocks (TrueTime API) to order distributed transactions at the microsecond level.
