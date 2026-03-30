# Project 3: E-Commerce Analytics (Intermediate)

## Objective
Design a database representing an online storefront and write business-intelligence queries to analyze the sales performance.

## Core Requirements
1.  **Products:** ID, Name, Price, Category.
2.  **Customers:** ID, Name, Country, Registration Date.
3.  **Orders:** ID, Customer ID, Order Date, Total Amount.
4.  **Order_Items:** A linking table. Order ID, Product ID, Quantity Purchased, Price at time of purchase.

## Tasks & Queries to Write
1.  **Schema & Seed:** Design the tables and fill them with enough varied data (e.g. 20 products, 10 customers, 15 orders containing multiple items) to make analytics interesting.
2.  **Group By Analytics:** Write a query to find the Total Revenue generated per Product Category.
3.  **Having Clause:** Write a query to find all Customers who have spent more than $500 *in total* across all their orders.
4.  **Date Filtering:** Write a query to calculate the total revenue generated in a specific month (e.g., November 2023).
5.  **Subqueries:** Write a query to find the details of the single most expensive Order ever placed in the database.

## Expected Learnings
*   Many-to-Many Relationships (Orders to Products via `Order_Items` bridging table).
*   Aggregate functions (`SUM()`, `GROUP BY`, `HAVING`).
*   Working with Date functions.
*   Subqueries in the `WHERE` clause.
