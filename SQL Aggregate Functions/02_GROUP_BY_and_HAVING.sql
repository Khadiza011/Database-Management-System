
-- =====================================================
-- Topic: GROUP BY and HAVING
-- File: 02_GROUP_BY_and_HAVING.sql
-- Database: analytics_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS analytics_db;
USE analytics_db;

-- 2. Create the employees table if it does not exist
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
) ENGINE = InnoDB;

-- 3. Insert sample data
-- Update existing records if employee IDs already exist
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

-- 4. Display all employees
SELECT * FROM employees;

-- 5. Count employees in each department
SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department;

-- 6. Calculate total salary by department
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- 7. Calculate average salary by department
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department;

-- 8. Find the highest salary in each department
SELECT
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

-- 9. Find the lowest salary in each department
SELECT
    department,
    MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;

-- 10. Departments with more than one employee
SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

-- 11. Departments with average salary above 40000
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 40000;

-- 12. Departments with total salary above 80000
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 80000;

-- 13. Count employees earning more than 35000
SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
WHERE salary > 35000
GROUP BY department;

-- 14. Use WHERE and HAVING together
SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
WHERE salary >= 35000
GROUP BY department
HAVING COUNT(*) >= 2;

-- 15. Sort departments by average salary
SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;
