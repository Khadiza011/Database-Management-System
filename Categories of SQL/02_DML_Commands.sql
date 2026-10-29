
-- =====================================================
-- Topic: DML Commands
-- File: 02_DML_Commands.sql
-- Database: company_db
-- DBMS: MariaDB / MySQL
-- =====================================================

-- 1. Select the database
USE company_db;

-- 2. Remove previous practice records before reinserting
-- This makes the sample data section safe to rerun
DELETE FROM company_employees
WHERE employee_id IN (101, 102, 103, 104, 105);

-- 3. Insert a single employee
INSERT INTO company_employees
    (employee_id, employee_name, age, salary, department_name, email)
VALUES
    (101, 'Rahim Ahmed', 25, 35000.00, 'IT', 'rahim@company.com');

-- 4. Insert multiple employees
INSERT INTO company_employees
    (employee_id, employee_name, age, salary, department_name, email)
VALUES
    (102, 'Karim Hasan', 28, 45000.00, 'HR', 'karim@company.com'),
    (103, 'Nusrat Jahan', 24, 40000.00, 'IT', 'nusrat@company.com'),
    (104, 'Sadia Islam', 30, 55000.00, 'Finance', 'sadia@company.com'),
    (105, 'Hasan Mahmud', 27, 38000.00, 'IT', 'hasan@company.com');

-- 5. Display all employees
SELECT * FROM company_employees;

-- 6. Display selected columns
SELECT employee_name, salary
FROM company_employees;

-- 7. Find employees from the IT department
SELECT *
FROM company_employees
WHERE department_name = 'IT';

-- 8. Update an employee's salary
UPDATE company_employees
SET salary = 42000.00
WHERE employee_id = 101;

-- 9. Update an employee's department
UPDATE company_employees
SET department_name = 'Marketing'
WHERE employee_id = 102;

-- 10. Display updated records
SELECT * FROM company_employees;

-- 11. Delete one employee
DELETE FROM company_employees
WHERE employee_id = 105;

-- 12. Display the final employee records
SELECT * FROM company_employees;

-- 13. Count the remaining employees
SELECT COUNT(*) AS total_employees
FROM company_employees;
