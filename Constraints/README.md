# SQL Constraints

This section covers SQL constraints used to maintain data integrity, consistency, and reliability in relational databases using **MySQL / MariaDB**.

Constraints define rules that control what data can be inserted or stored in database tables.

## Topics Covered

- NOT NULL Constraint
- UNIQUE Constraint
- PRIMARY KEY Constraint
- FOREIGN KEY Constraint
- DEFAULT Constraint
- CHECK Constraint
- Combined SQL Constraints

## Tools & Technologies

- **Database Management System:** MySQL / MariaDB
- **Local Server Environment:** XAMPP
- **Database Interface:** phpMyAdmin
- **Command-Line Interface:** Command Prompt (CMD)
- **Version Control:** Git & GitHub

## Database Used

The SQL exercises in this section use the `sales_db` database.

Different tables are created to demonstrate individual constraints and their combined use in practical database scenarios.

## Constraints Practiced

### 1. NOT NULL Constraint
Ensures that a column cannot store `NULL` values.

### 2. UNIQUE Constraint
Prevents duplicate non-NULL values in a column or a combination of columns.

### 3. PRIMARY KEY Constraint
Uniquely identifies each record in a table. A primary key cannot contain `NULL` values or duplicate key values.

### 4. FOREIGN KEY Constraint
Establishes relationships between tables and helps maintain referential integrity.

### 5. DEFAULT Constraint
Provides a predefined value when an insert operation omits a column value.

### 6. CHECK Constraint
Enforces a condition on stored data, such as requiring a positive price or non-negative stock quantity.

### 7. Combined Constraints
Applies multiple constraints to a table to enforce several data integrity rules simultaneously.

## Learning Objectives

- Understand the purpose of SQL constraints.
- Maintain data integrity and consistency.
- Prevent invalid and duplicate data.
- Establish relationships between database tables.
- Apply default values to columns.
- Validate data using `CHECK` constraints.
- Combine multiple constraints in practical database designs.
- Understand constraint violations through hands-on SQL exercises.

## Important Notes

- A primary key must uniquely identify each record and cannot contain `NULL`.
- A foreign key must reference an eligible key in the related table, or contain `NULL` if the column permits it.
- A `UNIQUE` constraint generally permits multiple `NULL` values in MySQL / MariaDB.
- Default values are generally applied when a column is omitted from an `INSERT` statement, not when `NULL` is explicitly supplied.
- `CHECK` constraint enforcement depends on the database system and version. Use a version that supports and enforces `CHECK` constraints.
- When modifying an existing table, `CREATE TABLE IF NOT EXISTS` does not update its existing structure or constraints.

## Purpose

This section is maintained to strengthen my understanding of database integrity rules and relational database design through practical SQL examples, laboratory exercises, and constraint-based validation.

---

**Learn • Validate • Maintain Data Integrity**
