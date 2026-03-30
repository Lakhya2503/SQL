# SQL JOINs

A `JOIN` clause is used to combine rows from two or more tables, based on a related column between them. When you normalize your database, you split your data across tables to avoid redundancy. `JOIN`s put it back together for a query.

## 1. INNER JOIN

The `INNER JOIN` keyword selects records that have matching values in both tables. This is by far the most commonly used join.

```sql
SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID;
```
*Result: Returns only orders that are linked to a specific customer, AND only customers who have placed at least one order.*

## 2. LEFT (OUTER) JOIN

The `LEFT JOIN` keyword returns all records from the left table (table1), and the matched records from the right table (table2). The result is 0 records from the right side, if there is no match.

```sql
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID;
```
*Result: Returns ALL customers. If a customer has no orders, the OrderID will just say `NULL`.*

## 3. RIGHT (OUTER) JOIN

The `RIGHT JOIN` keyword returns all records from the right table (table2), and the matched records from the left table (table1). The result is 0 records from the left side, if there is no match.

```sql
SELECT Orders.OrderID, Employees.LastName
FROM Orders
RIGHT JOIN Employees 
ON Orders.EmployeeID = Employees.EmployeeID;
```
*Result: Returns ALL employees. Even if an employee hasn't processed any orders, their name will still appear (with `NULL` for OrderID).*

## 4. FULL (OUTER) JOIN

The `FULL JOIN` keyword returns all records when there is a match in either the left table or right table. Think of it as combining a LEFT JOIN and a RIGHT JOIN together.

```sql
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID;
```
*Result: Returns all customers (even those with no orders) and all orders (even if somehow missing a linked customer).*

## 5. CROSS JOIN

The `CROSS JOIN` keyword is used to combine each row from the first table with each row from the second table. This is also called a Cartesian Product. WARNING: This can get huge fast. If you cross join two tables with 100 rows, you get 10,000 results.

```sql
SELECT Customers.CustomerName, Products.ProductName
FROM Customers
CROSS JOIN Products;
```
*Result: Matches every single customer to every single product.*

## 6. Self Join

A self join is a regular join, but the table is joined with itself. This is useful when you have a hierarchical structure (like an employee-manager relationship in an HR database).

```sql
-- Find the name of the employee alongside the name of their direct manager
SELECT e.FirstName AS Employee, m.FirstName AS Manager
FROM Employees e
LEFT JOIN Employees m 
ON e.ManagerID = m.EmployeeID;
```
*(Notice the use of table aliases `e` and `m`? This is required so SQL knows which 'copy' of the table you mean).*
