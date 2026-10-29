
-- =====================================================
-- Topic: TCL Commands
-- File: 05_TCL_Commands.sql
-- Database: company_db
-- DBMS: MariaDB / MySQL
-- =====================================================

USE company_db;

-- 1. Display current employee records
SELECT * FROM company_employees;

-- 2. Start a transaction
START TRANSACTION;

-- 3. Update an employee's salary
UPDATE company_employees
SET salary = salary + 1000
WHERE employee_id = 101;

-- 4. Save the transaction
COMMIT;

-- 5. Verify the committed salary
SELECT employee_id, employee_name, salary
FROM company_employees
WHERE employee_id = 101;

-- 6. Start another transaction
START TRANSACTION;

-- 7. Update an employee's salary
UPDATE company_employees
SET salary = salary + 5000
WHERE employee_id = 102;

-- 8. Undo the uncommitted update
ROLLBACK;

-- 9. Verify that the salary was restored
SELECT employee_id, employee_name, salary
FROM company_employees
WHERE employee_id = 102;

-- 10. Demonstrate SAVEPOINT
START TRANSACTION;

-- First change
UPDATE company_employees
SET salary = salary + 1000
WHERE employee_id = 103;

-- Mark a savepoint
SAVEPOINT salary_update_point;

-- Second change
UPDATE company_employees
SET salary = salary + 2000
WHERE employee_id = 104;

-- Undo changes made after the savepoint
ROLLBACK TO SAVEPOINT salary_update_point;

-- Commit the remaining transaction
COMMIT;

-- 11. Display final employee salaries
SELECT employee_id, employee_name, salary
FROM company_employees
ORDER BY employee_id;
