
-- =====================================================
-- Topic: Index Management
-- File: 06_Index_Management.sql
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

-- 2. Create an employees table
CREATE TABLE IF NOT EXISTS index_management_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    city VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

-- 3. Insert sample records
INSERT INTO index_management_employees
    (employee_id, employee_name, department, salary, city)
VALUES
    (101, 'Rahim Ahmed', 'IT', 45000, 'Dhaka'),
    (102, 'Karim Hasan', 'HR', 40000, 'Chattogram'),
    (103, 'Nusrat Jahan', 'IT', 55000, 'Dhaka'),
    (104, 'Sadia Islam', 'Finance', 50000, 'Sylhet'),
    (105, 'Hasan Mahmud', 'IT', 38000, 'Dhaka')
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    department = VALUES(department),
    salary = VALUES(salary),
    city = VALUES(city);

-- 4. Display all employees
SELECT * FROM index_management_employees;

-- =====================================================
-- PART 2: VIEW EXISTING INDEXES
-- =====================================================

-- 5. Display all indexes
SHOW INDEX FROM index_management_employees;

-- 6. Display complete table definition
SHOW CREATE TABLE index_management_employees;

-- =====================================================
-- PART 3: CREATE INDEX
-- =====================================================

-- 7. Create an index on department
CREATE INDEX idx_employee_department
ON index_management_employees(department);

-- 8. Create an index on salary
CREATE INDEX idx_employee_salary
ON index_management_employees(salary);

-- 9. Display indexes after creation
SHOW INDEX FROM index_management_employees;

-- =====================================================
-- PART 4: RENAME INDEX
-- =====================================================

-- 10. Rename an existing index
ALTER TABLE index_management_employees
RENAME INDEX idx_employee_department
TO idx_emp_department;

-- 11. Verify renamed index
SHOW INDEX FROM index_management_employees;

-- =====================================================
-- PART 5: DROP INDEX
-- =====================================================

-- 12. Remove the salary index
DROP INDEX idx_employee_salary
ON index_management_employees;

-- 13. Verify index removal
SHOW INDEX FROM index_management_employees;

-- =====================================================
-- PART 6: ANALYZE TABLE
-- =====================================================

-- 14. Analyze table statistics
ANALYZE TABLE index_management_employees;

-- 15. Check table indexes again
SHOW INDEX FROM index_management_employees;

-- =====================================================
-- PART 7: QUERY USING INDEX
-- =====================================================

-- 16. Search employees by department
SELECT *
FROM index_management_employees
WHERE department = 'IT';

-- 17. Analyze query execution plan
EXPLAIN
SELECT *
FROM index_management_employees
WHERE department = 'IT';

-- =====================================================
-- PART 8: FINAL TABLE INFORMATION
-- =====================================================

-- 18. Display final table structure
DESCRIBE index_management_employees;

-- 19. Display final index information
SHOW INDEX FROM index_management_employees;
