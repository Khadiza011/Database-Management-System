# Categories of SQL

This section covers the major categories of SQL (Structured Query Language) used to define database structures, manipulate data, retrieve information, control access, and manage transactions.

All examples are practiced using **MySQL / MariaDB** with phpMyAdmin and XAMPP.

## Categories Covered

### 1. DDL — Data Definition Language

DDL is used to create, modify, and remove database objects such as databases and tables.

**Commands Covered:**
- `CREATE` — Creates databases and tables.
- `ALTER` — Modifies table structures.
- `RENAME` — Renames database objects.
- `TRUNCATE` — Removes all rows while keeping the table structure.
- `DROP` — Removes database objects.

### 2. DML — Data Manipulation Language

DML is used to insert, modify, and delete records stored in database tables.

**Commands Covered:**
- `INSERT` — Adds new records.
- `UPDATE` — Modifies existing records.
- `DELETE` — Removes records.

### 3. DQL — Data Query Language

DQL focuses on retrieving and filtering data from database tables.

**Commands and Clauses Covered:**
- `SELECT` — Retrieves data.
- `WHERE` — Filters records based on conditions.
- `DISTINCT` — Removes duplicate values from query results.
- `ORDER BY` — Sorts query results.
- `LIMIT` — Restricts the number of returned rows.
- `BETWEEN` — Filters values within a range.
- `IN` — Matches values against a list.
- `LIKE` — Searches for patterns.
- `IS NULL` — Checks for missing values.

### 4. DCL — Data Control Language

DCL is used to manage database access and user permissions.

**Commands Covered:**
- `CREATE USER` — Creates database users.
- `GRANT` — Assigns privileges to users.
- `REVOKE` — Removes privileges from users.
- `SHOW GRANTS` — Displays user permissions.

### 5. TCL — Transaction Control Language

TCL is used to control transactions and manage changes made to database records.

**Commands Covered:**
- `START TRANSACTION` — Begins a transaction.
- `COMMIT` — Saves transaction changes.
- `ROLLBACK` — Undoes uncommitted changes.
- `SAVEPOINT` — Creates a point within a transaction.
- `ROLLBACK TO SAVEPOINT` — Undoes changes made after a savepoint.

## Tools & Technologies

- **Database Management System:** MySQL / MariaDB
- **Local Server Environment:** XAMPP
- **Database Interface:** phpMyAdmin
- **Command-Line Interface:** Command Prompt (CMD)
- **Version Control:** Git & GitHub

## Database Used

The SQL examples in this section use the `company_db` database and its `company_employees` table.

The same database is used across DDL, DML, DQL, DCL, and TCL exercises to maintain consistency throughout this section.

## Learning Objectives

- Understand the five major categories of SQL.
- Learn how to create and modify database structures.
- Practice inserting, retrieving, updating, and deleting records.
- Understand database users, privileges, and access control.
- Learn transaction management using `COMMIT`, `ROLLBACK`, and `SAVEPOINT`.
- Develop practical SQL skills through hands-on exercises.

## Important Notes

- Execute the SQL files in the appropriate order when following the complete practice sequence.
- Some DDL commands, such as `DROP` and `TRUNCATE`, can remove data or database objects.
- Always use appropriate `WHERE` conditions when updating or deleting specific records.
- Transaction behavior depends on the storage engine. In MySQL / MariaDB, `InnoDB` supports transactions.
- DQL is presented separately here for learning purposes; SQL classification conventions may vary across textbooks.

## Purpose

This section is part of my DBMS learning repository. It provides an organized collection of SQL commands, practical examples, and exercises to strengthen my understanding of database management and SQL programming.

---

**Learn • Practice • Query • Manage Databases**
