# SQL Joins and Subqueries

This section covers SQL JOIN operations and subqueries using **MySQL / MariaDB**. These concepts help retrieve related data from multiple tables and solve complex database queries efficiently.

## Topics Covered

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- CROSS JOIN
- SELF JOIN
- Subqueries
- Correlated Subqueries


## Tools & Technologies

- **Database Management System:** MySQL / MariaDB
- **Local Server Environment:** XAMPP
- **Database Interface:** phpMyAdmin
- **Command-Line Interface:** Command Prompt (CMD)
- **Version Control:** Git & GitHub

## Database Used

The SQL exercises in this section use the `retail_db` database.

The examples use related tables such as `customers` and `orders` to demonstrate JOIN operations and subqueries. Additional tables are created for CROSS JOIN and SELF JOIN exercises.

## Concepts Practiced

### 1. INNER JOIN
Retrieves records that have matching values in both tables.

### 2. LEFT JOIN
Returns all records from the left table and matching records from the right table. Non-matching right-side values appear as `NULL`.

### 3. RIGHT JOIN
Returns all records from the right table and matching records from the left table. Non-matching left-side values appear as `NULL`.

### 4. CROSS JOIN
Produces every possible combination of rows from two tables, known as a Cartesian product.

### 5. SELF JOIN
Joins a table with itself using aliases to identify relationships within the same table, such as employee-manager relationships.

### 6. Subqueries
Uses one query inside another query to filter records, compare values, and retrieve data based on intermediate results.

### 7. Correlated Subqueries
Uses a subquery that references columns from an outer query to evaluate related conditions for individual rows.

## Learning Objectives

- Understand the differences between SQL JOIN types.
- Retrieve related data from multiple tables.
- Identify matching and non-matching records.
- Understand table aliases and join conditions.
- Use subqueries with `IN`, `EXISTS`, `NOT EXISTS`, and aggregate functions.
- Apply correlated subqueries to solve row-dependent queries.
- Improve SQL problem-solving skills through practical exercises.

## Important Notes

- Execute `01_INNER_JOIN.sql` before the other JOIN exercises because it creates the `retail_db` database and the main `customers` and `orders` tables.
- The remaining scripts may depend on tables created in earlier scripts.
- JOIN results depend on the matching conditions specified in the `ON` clause.
- `LEFT JOIN` and `RIGHT JOIN` preserve all records from their respective outer-side tables.
- A CROSS JOIN can produce a large number of rows when the source tables contain many records.
- Correlated subqueries may have performance implications on large datasets. Indexes and alternative query plans should be considered when optimizing real applications.

## Purpose

This section is maintained to strengthen my understanding of relational data retrieval, table relationships, and advanced SQL query techniques through hands-on practice and structured examples.

---

**Connect Data • Query Relationships • Solve Problems**
