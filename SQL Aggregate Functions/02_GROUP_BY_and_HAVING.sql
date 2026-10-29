
-- =====================================================
-- Topic: GROUP BY and HAVING
-- File: 02_GROUP_BY_and_HAVING.sql
-- Database: analytics_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE analytics_db;

-- 2. Display all employees
SELECT * FROM employees;

-- 3. Count employees in each department
SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department;

-- 4. Calculate the total salary of each department
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- 5. Calculate the average salary of each department
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department;

-- 6. Find the highest salary in each department
SELECT
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

-- 7. Find the lowest salary in each department
SELECT
    department,
    MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;

-- 8. Display departments with more than one employee
SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

-- 9. Display departments with an average salary
-- greater than 40000
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 40000;

-- 10. Display departments whose total salary
-- is greater than 80000
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 80000;

-- 11. Use WHERE before GROUP BY
-- Count employees earning more than 35000
-- in each department
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 35000
GROUP BY department;

-- 12. Use WHERE and HAVING together
-- First filter employees, then filter groups
SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
WHERE salary >= 35000
GROUP BY department
HAVING COUNT(*) >= 2;

-- 13. Sort departments by average salary
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;
