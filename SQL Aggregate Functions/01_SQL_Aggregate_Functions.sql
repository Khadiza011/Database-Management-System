
-- =====================================================
-- Topic: SQL Aggregate Functions
-- File: 01_SQL_Aggregate_Functions.sql
-- Database: analytics_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Create a new database
CREATE DATABASE IF NOT EXISTS analytics_db;

-- 2. Select the database
USE analytics_db;

-- 3. Create an employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB;

-- 4. Insert sample records
-- Re-running this query updates existing sample records
INSERT INTO employees
    (employee_id, employee_name, department, salary)
VALUES
    (101, 'Rahim Ahmed', 'IT', 35000.00),
    (102, 'Karim Hasan', 'HR', 40000.00),
    (103, 'Nusrat Jahan', 'IT', 45000.00),
    (104, 'Sadia Islam', 'Finance', 50000.00),
    (105, 'Hasan Mahmud', 'IT', 38000.00)
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    department = VALUES(department),
    salary = VALUES(salary);

-- 5. Display all employees
SELECT * FROM employees;

-- 6. Count all employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 7. Calculate the total salary
SELECT SUM(salary) AS total_salary
FROM employees;

-- 8. Calculate the average salary
SELECT AVG(salary) AS average_salary
FROM employees;

-- 9. Find the highest salary
SELECT MAX(salary) AS highest_salary
FROM employees;

-- 10. Find the lowest salary
SELECT MIN(salary) AS lowest_salary
FROM employees;

-- 11. Count unique departments
SELECT COUNT(DISTINCT department) AS total_departments
FROM employees;

-- 12. Calculate average salary rounded to two decimals
SELECT ROUND(AVG(salary), 2) AS average_salary
FROM employees;

-- 13. Display multiple aggregate results together
SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;

-- 14. Count employees earning more than 40000
SELECT COUNT(*) AS employees_above_40000
FROM employees
WHERE salary > 40000;
