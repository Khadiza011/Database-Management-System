
-- =====================================================
-- Topic: DQL Commands
-- File: 03_DQL_Commands.sql
-- Database: company_db
-- DBMS: MariaDB / MySQL
-- =====================================================

-- 1. Select the database
USE company_db;

-- 2. Display all employees
SELECT *
FROM company_employees;

-- 3. Display selected columns
SELECT employee_id, employee_name, salary
FROM company_employees;

-- 4. Retrieve employees from the IT department
SELECT *
FROM company_employees
WHERE department_name = 'IT';

-- 5. Find employees with a salary greater than 40000
SELECT *
FROM company_employees
WHERE salary > 40000;

-- 6. Find employees aged 25 or older
SELECT *
FROM company_employees
WHERE age >= 25;

-- 7. Display employees in ascending salary order
SELECT *
FROM company_employees
ORDER BY salary ASC;

-- 8. Display employees in descending salary order
SELECT *
FROM company_employees
ORDER BY salary DESC;

-- 9. Display unique department names
SELECT DISTINCT department_name
FROM company_employees;

-- 10. Display the first three employees
SELECT *
FROM company_employees
LIMIT 3;

-- 11. Find employees with salaries between 35000 and 45000
SELECT *
FROM company_employees
WHERE salary BETWEEN 35000 AND 45000;

-- 12. Find employees in selected departments
SELECT *
FROM company_employees
WHERE department_name IN ('IT', 'HR');

-- 13. Find employees whose names start with 'S'
SELECT *
FROM company_employees
WHERE employee_name LIKE 'S%';

-- 14. Find employees whose names contain 'ah'
SELECT *
FROM company_employees
WHERE employee_name LIKE '%ah%';

-- 15. Find employees whose email addresses are available
SELECT *
FROM company_employees
WHERE email IS NOT NULL;

-- 16. Find employees with salaries of at least 40000
-- and belonging to the IT department
SELECT *
FROM company_employees
WHERE salary >= 40000
AND department_name = 'IT';

-- 17. Find employees from IT or Finance
SELECT *
FROM company_employees
WHERE department_name = 'IT'
OR department_name = 'Finance';

-- 18. Display employee information in alphabetical order
SELECT employee_id, employee_name, department_name
FROM company_employees
ORDER BY employee_name ASC;

-- 19. Display the three highest-paid employees
SELECT *
FROM company_employees
ORDER BY salary DESC
LIMIT 3;

-- 20. Count the total number of employees
SELECT COUNT(*) AS total_employees
FROM company_employees;
