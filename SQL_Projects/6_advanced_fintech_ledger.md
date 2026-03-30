# Project 6: Fintech Double-Entry Ledger (Advanced)

## Objective
The golden rule of accounting and modern fintech banking is to never delete data. Build a rock-solid, transactionally-safe double-entry ledger.

## Core Requirements
1.  **Users:** ID, Name, Tier (Basic, Premium), Status.
2.  **Accounts:** ID, User ID, Account Type (Checking, Savings, Credit), Balance.
3.  **Transactions (The Ledger):** UUID, From Account ID, To Account ID, Amount, Timestamp, Status (Pending, Cleared, Failed), Type (Transfer, Deposit, Withdrawal).

## Tasks & Queries to Write
1.  **Stored Procedure (The Core Logic):** Write an ACID-compliant Stored Procedure named `TransferFunds` that accepts `from_account`, `to_account`, and `transfer_amount`.
    *   It must use a `BEGIN` transaction.
    *   It must verify that the `from_account` has a balance `>= transfer_amount`. If not, `ROLLBACK`.
    *   It must deduct the amount from `from_account`.
    *   It must add the amount to `to_account`.
    *   It must `INSERT` a row into the Transactions ledger.
    *   If successful, `COMMIT`.
2.  **Triggers:** Create a trigger that automatically prevents any `DELETE` instruction from being executed on the `Transactions` table, throwing a hard error instead.
3.  **Window Functions:** Write a query that shows a user's running cumulative balance ordered by transaction timestamp.

## Expected Learnings
*   TCL (`BEGIN`, `COMMIT`, `ROLLBACK`)
*   Data integrity mechanisms
*   Creating Stored Procedures with logical branching (`IF / ELSE`)
*   Using triggers to block destructive actions.
