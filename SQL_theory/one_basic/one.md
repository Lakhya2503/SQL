# SQL

**SQL (Structured Query Language)** is a standardized programming language used to manage relational databases and perform operations on the data within them. It serves as the standard language for Relational Database Management Systems.

## What is a Database?
A database is an organized collection of structured information, or data, typically stored electronically in a computer system. It provides a method to easily access, manipulate, and update this data.

### DBMS (Database Management System)
A DBMS is software that interacts with end-users, applications, and the database itself to capture and analyze data. It essentially serves as an interface between the database and its users.

### RDBMS (Relational Database Management System)
**What is an RDBMS?**
- A type of database management system that stores data in structured tables (using rows and columns).
- The tables relate to one another through common fields.
- It uses SQL (Structured Query Language) for managing and querying data.

### Examples of Databases:

**Relational (SQL):**
- MySQL
- PostgreSQL
- Oracle Database
- SQLite
- Microsoft SQL Server
- Firebird
- MaxDB

**Non-Relational (NoSQL):**
- MongoDB
- Redis

## SQL vs PostgreSQL

Often misunderstood by beginners, SQL is not a database itself. Here is the distinction:

| Feature | SQL | PostgreSQL |
| :--- | :--- | :--- |
| **What is it?** | A **language** used to communicate with databases. | A specific **database software** (RDBMS) that uses SQL. |
| **Analogy** | Like the English language. | Like a person who speaks English. |
| **Examples** | `SELECT`, `INSERT`, `UPDATE` | PostgreSQL Server, pgAdmin |

PostgreSQL is just one of many database systems (like MySQL, Oracle, SQL Server) that understand the SQL language. Each database system might also add its own specific features, advanced data types, or custom functions (often called a SQL dialect) on top of the standard SQL language.

## Types of SQL Commands

SQL commands are generally grouped into five main categories:

1. **DQL (Data Query Language):** Used to retrieve data from the database.
   - Example: `SELECT`
2. **DDL (Data Definition Language):** Used to define or alter the structure of the database (e.g., creating tables or schemas).
   - Examples: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`
3. **DML (Data Manipulation Language):** Used to manipulate the data itself within tables.
   - Examples: `INSERT`, `UPDATE`, `DELETE`
4. **DCL (Data Control Language):** Used to manage access and permissions to the database.
   - Examples: `GRANT`, `REVOKE`
5. **TCL (Transaction Control Language):** Used to manage transactions (to permanently save or undo changes).
   - Examples: `COMMIT`, `ROLLBACK`, `SAVEPOINT`
