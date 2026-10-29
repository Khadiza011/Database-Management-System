
-- =====================================================
-- Topic: DDL Commands
-- File: 01_DDL_Commands.sql
-- Database: company_db
-- DBMS: MariaDB / MySQL
-- =====================================================

-- 1. Create a new database
CREATE DATABASE IF NOT EXISTS company_db;

-- 2. Select the database
USE company_db;

-- 3. Reset the practice tables for a fresh execution
-- WARNING: Existing data in these practice tables will be deleted
DROP TABLE IF EXISTS ddl_demo;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS company_employees;

-- 4. Create an employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2)
);

-- 5. Display all tables
SHOW TABLES;

-- 6. Display the table structure
DESCRIBE employees;

-- 7. Add a new column
ALTER TABLE employees
ADD COLUMN department VARCHAR(50);

-- 8. Modify the employee_name column
ALTER TABLE employees
MODIFY COLUMN employee_name VARCHAR(150) NOT NULL;

-- 9. Rename department to department_name
-- CHANGE COLUMN works with MariaDB
ALTER TABLE employees
CHANGE COLUMN department department_name VARCHAR(50);

-- 10. Add another column
ALTER TABLE employees
ADD COLUMN email VARCHAR(100);

-- 11. Display the updated structure
DESCRIBE employees;

-- 12. Rename the table
RENAME TABLE employees TO company_employees;

-- 13. Display all tables
SHOW TABLES;

-- 14. Check the final table structure
DESCRIBE company_employees;

-- 15. Create a demonstration table
CREATE TABLE ddl_demo (
    demo_id INT PRIMARY KEY,
    description VARCHAR(100)
);

-- 16. Insert sample data into the demonstration table
INSERT INTO ddl_demo (demo_id, description)
VALUES (1, 'DDL Practice');

-- 17. Display demonstration data
SELECT * FROM ddl_demo;

-- 18. Remove all rows but keep the table structure
TRUNCATE TABLE ddl_demo;

-- 19. Verify that the table is empty
SELECT * FROM ddl_demo;

-- 20. Delete the demonstration table completely
DROP TABLE ddl_demo;

-- 21. Verify the final tables
SHOW TABLES;

-- 22. Verify the final employee table structure
DESCRIBE company_employees;
