
-- =====================================================
-- Topic: Composite Index
-- File: 03_Composite_Index.sql
-- Database: indexing_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS indexing_db;
USE indexing_db;

-- =====================================================
-- PART 1: CREATE SAMPLE TABLE
-- =====================================================

-- 2. Create an employee records table
CREATE TABLE IF NOT EXISTS composite_index_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    city VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

-- 3. Insert sample records
INSERT INTO composite_index_employees
    (employee_id, employee_name, department, salary, city)
VALUES
    (101, 'Rahim Ahmed', 'IT', 45000, 'Dhaka'),
    (102, 'Karim Hasan', 'HR', 40000, 'Chattogram'),
    (103, 'Nusrat Jahan', 'IT', 55000, 'Dhaka'),
    (104, 'Sadia Islam', 'Finance', 50000, 'Sylhet'),
    (105, 'Hasan Mahmud', 'IT', 35000, 'Dhaka'),
    (106, 'Mim Akter', 'HR', 48000, 'Dhaka'),
    (107, 'Tanvir Ahmed', 'Finance', 60000, 'Chattogram'),
    (108, 'Rafi Islam', 'IT', 52000, 'Chattogram'),
    (109, 'Nadia Rahman', 'HR', 42000, 'Sylhet'),
    (110, 'Sabbir Hossain', 'Finance', 47000, 'Dhaka')
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    department = VALUES(department),
    salary = VALUES(salary),
    city = VALUES(city);

-- 4. Display all employees
SELECT * FROM composite_index_employees;

-- =====================================================
-- PART 2: QUERY WITHOUT COMPOSITE INDEX
-- =====================================================

-- 5. Search using department and salary
SELECT *
FROM composite_index_employees
WHERE department = 'IT'
AND salary > 40000;

-- 6. Analyze execution plan
EXPLAIN
SELECT *
FROM composite_index_employees
WHERE department = 'IT'
AND salary > 40000;

-- =====================================================
-- PART 3: CREATE COMPOSITE INDEX
-- =====================================================

-- 7. Create a composite index
CREATE INDEX idx_department_salary
ON composite_index_employees(department, salary);

-- 8. Display index information
SHOW INDEX FROM composite_index_employees;

-- =====================================================
-- PART 4: QUERY USING COMPOSITE INDEX
-- =====================================================

-- 9. Search using both indexed columns
SELECT *
FROM composite_index_employees
WHERE department = 'IT'
AND salary > 40000;

-- 10. Analyze execution plan
EXPLAIN
SELECT *
FROM composite_index_employees
WHERE department = 'IT'
AND salary > 40000;

-- =====================================================
-- PART 5: UNDERSTAND LEFTMOST PREFIX RULE
-- =====================================================

-- 11. Search using the first indexed column
-- Composite index can be used
EXPLAIN
SELECT *
FROM composite_index_employees
WHERE department = 'IT';

-- 12. Search using the second indexed column only
-- The composite index is generally not useful
EXPLAIN
SELECT *
FROM composite_index_employees
WHERE salary > 40000;

-- 13. Search using both columns
EXPLAIN
SELECT *
FROM composite_index_employees
WHERE department = 'HR'
AND salary > 45000;

-- =====================================================
-- PART 6: CREATE ANOTHER COMPOSITE INDEX
-- =====================================================

-- 14. Create an index using department and city
CREATE INDEX idx_department_city
ON composite_index_employees(department, city);

-- 15. Search by department and city
SELECT *
FROM composite_index_employees
WHERE department = 'IT'
AND city = 'Dhaka';

-- 16. Analyze the execution plan
EXPLAIN
SELECT *
FROM composite_index_employees
WHERE department = 'IT'
AND city = 'Dhaka';

-- =====================================================
-- PART 7: INDEX INFORMATION
-- =====================================================

-- 17. Display all indexes
SHOW INDEX FROM composite_index_employees;

-- 18. Display complete table definition
SHOW CREATE TABLE composite_index_employees;
