# SQL Aggregate Functions

This section covers SQL aggregate functions and grouped data analysis using **MySQL / MariaDB**. These functions help summarize data by calculating counts, totals, averages, minimums, and maximums.

## Topics Covered

- `COUNT()` — Counts rows or non-NULL values.
- `SUM()` — Calculates the total of numeric values.
- `AVG()` — Calculates the average of numeric values.
- `MIN()` — Finds the minimum value.
- `MAX()` — Finds the maximum value.
- `COUNT(DISTINCT)` — Counts unique non-NULL values.
- `ROUND()` — Rounds numeric values to a specified number of decimal places.
- `GROUP BY` — Groups rows based on common values.
- `HAVING` — Filters groups using conditions.
- `WHERE` with Aggregate Queries — Filters rows before grouping.
- Aggregate Subqueries — Uses aggregate results inside other queries.

## Tools & Technologies

- **Database Management System:** MySQL / MariaDB
- **Local Server Environment:** XAMPP
- **Database Interface:** phpMyAdmin
- **Command-Line Interface:** Command Prompt (CMD)
- **Version Control:** Git & GitHub

## Database Used

The SQL exercises in this section use the `analytics_db` database and its `employees` table.

The sample data includes employee names, departments, and salaries. These records are used to practice aggregate calculations, departmental summaries, and filtering grouped results.

## Concepts Practiced

### 1. Basic Aggregate Functions

- Counting employees using `COUNT()`.
- Calculating total salary using `SUM()`.
- Finding average salary using `AVG()`.
- Identifying the highest and lowest salaries using `MAX()` and `MIN()`.
- Counting unique departments using `COUNT(DISTINCT)`.

### 2. GROUP BY

- Grouping employees by department.
- Calculating employee counts for each department.
- Finding total and average salaries by department.
- Comparing department-level salary statistics.

### 3. HAVING

- Finding departments with more than a specified number of employees.
- Filtering departments by average salary.
- Identifying departments whose total salary exceeds a specified amount.

### 4. WHERE and HAVING Together

- Filtering individual employee records before grouping.
- Applying conditions to aggregate results after grouping.
- Understanding the difference between row-level and group-level filtering.

### 5. Practical Aggregate Queries

- Generating department-wise salary reports.
- Finding employees earning above
