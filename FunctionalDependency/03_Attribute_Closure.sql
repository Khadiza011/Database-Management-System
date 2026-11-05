
-- =====================================================
-- Topic: Attribute Closure
-- File: 03_Attribute_Closure.sql
-- Database: fd_practice_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS fd_practice_db;
USE fd_practice_db;

-- 2. Create a table for attribute closure practice
CREATE TABLE IF NOT EXISTS employee_details (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    department_name VARCHAR(100) NOT NULL,
    manager_id INT NOT NULL
);

-- 3. Insert sample records
INSERT INTO employee_details
    (employee_id, employee_name, department_id,
     department_name, manager_id)
VALUES
    (101, 'Rahim', 10, 'IT', 201),
    (102, 'Karim', 20, 'HR', 202),
    (103, 'Nusrat', 10, 'IT', 201),
    (104, 'Sadia', 30, 'Finance', 203)
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    department_id = VALUES(department_id),
    department_name = VALUES(department_name),
    manager_id = VALUES(manager_id);

-- 4. Display all records
SELECT * FROM employee_details;

-- =====================================================
-- FUNCTIONAL DEPENDENCIES (Theoretical)
-- =====================================================

-- FD1: employee_id -> employee_name, department_id
-- FD2: department_id -> department_name, manager_id

-- =====================================================
-- 5. Demonstrate employee_id closure
-- employee_id+ = all attributes
-- =====================================================

SELECT
    employee_id,
    employee_name,
    department_id,
    department_name,
    manager_id
FROM employee_details
WHERE employee_id = 101;

-- =====================================================
-- 6. Demonstrate department_id closure
-- department_id+ = department_id,
-- department_name, manager_id
-- =====================================================

SELECT DISTINCT
    department_id,
    department_name,
    manager_id
FROM employee_details
WHERE department_id = 10;

-- =====================================================
-- 7. Demonstrate composite attribute lookup
-- =====================================================

SELECT
    employee_id,
    department_id,
    employee_name,
    department_name,
    manager_id
FROM employee_details
WHERE employee_id = 101
  AND department_id = 10;

-- =====================================================
-- 8. Count distinct employee identifiers
-- =====================================================

SELECT COUNT(DISTINCT employee_id) AS unique_employees
FROM employee_details;

-- =====================================================
-- 9. Verify department dependencies
-- =====================================================

SELECT
    department_id,
    COUNT(DISTINCT department_name) AS department_names,
    COUNT(DISTINCT manager_id) AS managers
FROM employee_details
GROUP BY department_id;

-- =====================================================
-- 10. Verify employee identifier uniqueness
-- =====================================================

SELECT
    employee_id,
    COUNT(*) AS occurrence
FROM employee_details
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- No rows should be returned.
