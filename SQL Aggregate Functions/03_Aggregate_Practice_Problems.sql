
-- =====================================================
-- Topic: Aggregate Functions - Practice Problems
-- File: 03_Aggregate_Practice_Problems.sql
-- Database: analytics_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS analytics_db;
USE analytics_db;

-- 2. Ensure the employees table exists
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB;

-- 3. Insert or update sample records
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

-- =====================================================
-- Practice 1: Count all employees
-- =====================================================
SELECT COUNT(*) AS total_employees
FROM employees;

-- =====================================================
-- Practice 2: Calculate the total salary
-- =====================================================
SELECT SUM(salary) AS total_salary
FROM employees;

-- =====================================================
-- Practice 3: Find the average salary
-- =====================================================
SELECT ROUND(AVG(salary), 2) AS average_salary
FROM employees;

-- =====================================================
-- Practice 4: Find the highest and lowest salaries
-- =====================================================
SELECT
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM employees;

-- =====================================================
-- Practice 5: Count employees in each department
-- =====================================================
SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department;

-- =====================================================
-- Practice 6: Find total salary by department
-- =====================================================
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- =====================================================
-- Practice 7: Find departments with at least
-- two employees
-- =====================================================
SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) >= 2;

-- =====================================================
-- Practice 8: Find employees earning above
-- the overall average salary
-- =====================================================
SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- =====================================================
-- Practice 9: Find departments whose average
-- salary is greater than 40000
-- =====================================================
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 40000;

-- =====================================================
-- Practice 10: Count employees earning
-- more than 35000 in each department
-- =====================================================
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 35000
GROUP BY department;

-- =====================================================
-- Practice 11: Find departments with total
-- salary greater than 80000
-- =====================================================
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 80000;

-- =====================================================
-- Practice 12: Display a complete salary report
-- =====================================================
SELECT
    department,
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;
