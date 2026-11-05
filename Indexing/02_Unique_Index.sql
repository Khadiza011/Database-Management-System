
-- =====================================================
-- Topic: Unique Index
-- File: 02_Unique_Index.sql
-- Database: indexing_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS indexing_db;
USE indexing_db;

-- =====================================================
-- PART 1: CREATE EMPLOYEES TABLE
-- =====================================================

-- 2. Create an employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20)
) ENGINE = InnoDB;

-- 3. Insert sample employee records
INSERT INTO employees
    (employee_id, employee_name, email, phone)
VALUES
    (101, 'Rahim Ahmed', 'rahim@example.com', '01710000001'),
    (102, 'Karim Hasan', 'karim@example.com', '01710000002'),
    (103, 'Nusrat Jahan', 'nusrat@example.com', '01710000003'),
    (104, 'Sadia Islam', 'sadia@example.com', '01710000004'),
    (105, 'Hasan Mahmud', 'hasan@example.com', '01710000005')
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    email = VALUES(email),
    phone = VALUES(phone);

-- 4. Display all employees
SELECT * FROM employees;

-- =====================================================
-- PART 2: CREATE UNIQUE INDEX
-- =====================================================

-- 5. Create a unique index on email
-- Run only once.
CREATE UNIQUE INDEX idx_employees_email
ON employees(email);

-- 6. Display all indexes
SHOW INDEX FROM employees;

-- =====================================================
-- PART 3: SEARCH USING UNIQUE INDEX
-- =====================================================

-- 7. Find an employee using email
SELECT *
FROM employees
WHERE email = 'rahim@example.com';

-- 8. Analyze the execution plan
EXPLAIN
SELECT *
FROM employees
WHERE email = 'rahim@example.com';

-- =====================================================
-- PART 4: TEST DUPLICATE PREVENTION
-- =====================================================

-- 9. Attempt to insert a duplicate email
-- This statement should generate a duplicate key error.
-- Execute separately to observe the error.

-- INSERT INTO employees
--     (employee_id, employee_name, email, phone)
-- VALUES
--     (106, 'New Employee', 'rahim@example.com', '01710000006');

-- =====================================================
-- PART 5: CREATE COMPOSITE UNIQUE INDEX
-- =====================================================

-- 10. Create an employee department table
CREATE TABLE IF NOT EXISTS employee_departments (
    record_id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    department VARCHAR(50) NOT NULL,
    designation VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

-- 11. Insert sample records
INSERT INTO employee_departments
    (record_id, employee_id, department, designation)
VALUES
    (1, 101, 'IT', 'Developer'),
    (2, 102, 'HR', 'Manager'),
    (3, 103, 'Finance', 'Accountant'),
    (4, 101, 'HR', 'Consultant')
ON DUPLICATE KEY UPDATE
    employee_id = VALUES(employee_id),
    department = VALUES(department),
    designation = VALUES(designation);

-- 12. Create a composite unique index
-- An employee cannot have duplicate records
-- for the same department.
CREATE UNIQUE INDEX idx_employee_department
ON employee_departments(employee_id, department);

-- 13. Display composite index information
SHOW INDEX FROM employee_departments;

-- 14. Display employee department records
SELECT * FROM employee_departments;

-- =====================================================
-- PART 6: VERIFY UNIQUE INDEX
-- =====================================================

-- 15. Check table structure
SHOW CREATE TABLE employees;

-- 16. Check employee department structure
SHOW CREATE TABLE employee_departments;
