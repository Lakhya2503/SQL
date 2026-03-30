# Project 1: Local Library System (Beginner)

## Objective
Design and implement a basic database for a small local library to track books, members, and which books are currently borrowed.

## Core Requirements
1.  **Books Table:** Needs an ID, Title, Author, Published Year, and total copies owned by the library.
2.  **Members Table:** Needs an ID, First Name, Last Name, Email, and Join Date.
3.  **Loans Table:** Needs to track which Member borrowed which Book, the date it was checked out, and the date it was returned (which can be NULL if still checked out).

## Tasks & Queries to Write
1.  **Schema Creation:** Write the `CREATE TABLE` statements for the three tables. Define Primary Keys and Foreign Keys.
2.  **Data Insertion:** Write `INSERT` statements to add 5 books, 3 members, and simulate 4 book loans (where 2 are returned and 2 are currently checked out).
3.  **Basic Retrieval:** Write a `SELECT` query to find all books written by a specific author.
4.  **Join Query:** Write an `INNER JOIN` query that lists the Full Name of every member who currently has a book checked out, alongside the Title of the book they borrowed.
5.  **Filtering:** Write a query to find all books published before the year 2000.

## Expected Learnings
*   Basic Table Creation (`CREATE TABLE`)
*   Primary Keys & Foreign Keys (`REFERENCES`)
*   Basic Data Manipulation (`INSERT`)
*   Simple `INNER JOIN` logic
*   Filtering with `WHERE` and `IS NULL`
