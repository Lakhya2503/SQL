# Project 2: Employee Tracker (Beginner)

## Objective
Build a database to manage a company's workforce, tracking departments, roles, and employee details.

## Core Requirements
1.  **Department Table:** Needs an ID and Department Name (e.g., Engineering, Sales, HR).
2.  **Role Table:** Needs an ID, Title, Salary, and the specific Department ID this role belongs to.
3.  **Employee Table:** Needs an ID, First Name, Last Name, Role ID, and an optional Manager ID (which references another employee).

## Tasks & Queries to Write
1.  **Schema Creation:** Create the tables with appropriate constraints. Note that the `Manager ID` in the Employee table is a self-referencing foreign key.
2.  **Data Entry:** Insert 3 departments, 5 roles, and 7 employees. Make sure at least one employee has no manager (the CEO).
3.  **Data Updating:** Write an `UPDATE` statement to give everyone in a specific Role a 10% raise.
4.  **Join Query:** View all employees. Display their First Name, Last Name, Role Title, and Department Name. (Requires joining 3 tables).
5.  **Aggregation:** Write a query to find the total combined salary budget of the entire company using `SUM()`.

## Expected Learnings
*   Connecting more than two tables in a single query.
*   Updating existing records.
*   Basic Aggregation.
*   Understanding Self-Referencing Foreign Keys (Employee -> Manager).
