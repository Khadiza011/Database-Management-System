
-- =====================================================
-- Topic: Clustered and Non-Clustered Index
-- File: 04_Clustered_and_Non_Clustered_Index.sql
-- Database: indexing_db
-- DBMS: MySQL (InnoDB)
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS indexing_db;
USE indexing_db;

-- =====================================================
-- PART 1: CLUSTERED INDEX
-- =====================================================

-- 2. Create an employees table
-- InnoDB uses the Primary Key as the clustered index.
CREATE TABLE IF NOT EXISTS clustered_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB;

-- 3. Insert sample records
INSERT INTO clustered_employees
    (employee_id, employee_name, department, salary)
VALUES
    (105, 'Hasan Mahmud', 'IT', 38000),
    (102, 'Karim Hasan', 'HR', 40000),
    (104, 'Sadia Islam', 'Finance', 50000),
    (101, 'Rahim Ahmed', 'IT', 35000),
    (103, 'Nusrat Jahan', 'IT', 45000)
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    department = VALUES(department),
    salary = VALUES(salary);

-- 4. Display employee records in Primary Key order
SELECT *
FROM clustered_employees
ORDER BY employee_id;

-- 5. Search using Primary Key
SELECT *
FROM clustered_employees
WHERE employee_id = 103;

-- 6. Analyze Primary Key lookup
EXPLAIN
SELECT *
FROM clustered_employees
WHERE employee_id = 103;

-- 7. Display Primary Key index information
SHOW INDEX FROM clustered_employees;

-- =====================================================
-- PART 2: SECONDARY (NON-CLUSTERED) INDEX
-- =====================================================

-- 8. Create a secondary index on department
CREATE INDEX idx_clustered_employees_department
ON clustered_employees(department);

-- 9. Display all indexes
SHOW INDEX FROM clustered_employees;

-- 10. Search using the secondary index
SELECT *
FROM clustered_employees
WHERE department = 'IT';

-- 11. Analyze secondary index lookup
EXPLAIN
SELECT *
FROM clustered_employees
WHERE department = 'IT';

-- =====================================================
-- PART 3: COVERING INDEX
-- =====================================================

-- 12. Create a composite secondary index
CREATE INDEX idx_department_salary
ON clustered_employees(department, salary);

-- 13. Query using indexed columns only
SELECT
    department,
    salary
FROM clustered_employees
WHERE department = 'IT';

-- 14. Analyze the covering index
EXPLAIN
SELECT
    department,
    salary
FROM clustered_employees
WHERE department = 'IT';

-- =====================================================
-- PART 4: VERIFY INDEX STRUCTURE
-- =====================================================

-- 15. Display all index information
SHOW INDEX FROM clustered_employees;

-- 16. Display complete table definition
SHOW CREATE TABLE clustered_employees;
