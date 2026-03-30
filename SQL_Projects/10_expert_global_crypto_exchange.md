# Project 10: Global Crypto Exchange (Expert)

## Objective
Master high-concurrency architecture, sharding strategies, and strict ACID transaction compliance by modeling a cryptocurrency order-matching engine capable of millions of rows per second.

## Core Requirements
1.  **Wallets:** Wallet ID, User ID, Asset Ticker (USD, BTC, ETH), Balance.
2.  **Orders (The Order Book):** Order ID, Wallet ID, Asset Pair (BTC/USD), Type (Buy/Sell), Limit Price, Quantity, Status (Open, Partial, Filled).
3.  **Trades:** Trade ID, Maker Order ID, Taker Order ID, Executed Price, Quantity, Timestamp.

## Tasks & Architectures to Design
1.  **The Matching Engine (PL/pgSQL):** Write an incredibly complex Stored Procedure that takes an incoming **Buy** order (e.g., Buy 1 BTC @ $60,000) and attempts to match it against existing **Sell** orders in the Book where `Limit Price <= $60,000`.
    *   It must use a `SERIALIZABLE` isolation level lock to ensure no two users can fill the same Sell order.
    *   If matched, it must update the Wallets, update the Order status, and insert a Trade log—all within one atomic transaction.
2.  **Table Partitioning:** Because an exchange generates millions of trades a day, historical queries slow down immensely. Write the SQL to partition your `Trades` table automatically by Month.
3.  **Materialized Views for Charts:** Building the Candlestick charts on Binance/Coinbase is computationally massive. Write a Materialized View that aggregates raw Trades into 1-Hour OHLC (Open, High, Low, Close) candles. You will need to use time-bucketing functions (e.g., `date_trunc`).
4.  **Index Strategy Analysis:** Analyze the `Orders` table. Write an `EXPLAIN ANALYZE` statement. Explain why placing a B-Tree index on `(Asset Pair, Type, Limit Price)` creates an optimal Index Seek for the matching engine.

## Expected Learnings
*   Architecting for massive ingest and low latency.
*   Pessimistic Locking vs Optimistic Locking during financial transactions.
*   Declarative Table Partitioning (Time-Series Data).
*   Building Materialized Views and continuous aggregates.
*   Interpreting Query Execution Plans.
