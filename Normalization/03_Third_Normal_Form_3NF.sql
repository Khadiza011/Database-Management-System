
-- =====================================================
-- Topic: Third Normal Form (3NF)
-- File: 03_Third_Normal_Form_3NF.sql
-- Database: normalization_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS normalization_db;
USE normalization_db;

-- =====================================================
-- PART 1: BEFORE NORMALIZATION (2NF)
-- =====================================================

-- 2. Create an employee table with transitive dependency
CREATE TABLE IF NOT EXISTS employees_2nf (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    department_name VARCHAR(100) NOT NULL,
    department_location VARCHAR(100) NOT NULL
);

-- 3. Insert sample records
INSERT INTO employees_2nf
    (employee_id, employee_name, department_id,
     department_name, department_location)
VALUES
    (101, 'Rahim Ahmed', 10, 'IT', 'Dhaka'),
    (102, 'Karim Hasan', 20, 'HR', 'Chattogram'),
    (103, 'Nusrat Jahan', 10, 'IT', 'Dhaka'),
    (104, 'Sadia Islam', 30, 'Finance', 'Sylhet'),
    (105, 'Hasan Mahmud', 20, 'HR', 'Chattogram')
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    department_id = VALUES(department_id),
    department_name = VALUES(department_name),
    department_location = VALUES(department_location);

-- 4. Display the original table
SELECT * FROM employees_2nf;

-- =====================================================
-- PART 2: FUNCTIONAL DEPENDENCIES
-- =====================================================

-- employee_id -> employee_name, department_id
--
-- department_id -> department_name, department_location
--
-- Therefore:
-- employee_id -> department_id
-- department_id -> department_name, department_location
--
-- This creates a transitive dependency.

-- =====================================================
-- PART 3: DECOMPOSITION INTO 3NF
-- =====================================================

-- 5. Create a departments table
CREATE TABLE IF NOT EXISTS departments_3nf (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_location VARCHAR(100) NOT NULL
);

-- 6. Create an employees table
CREATE TABLE IF NOT EXISTS employees_3nf (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT fk_employee_department_3nf
        FOREIGN KEY (department_id)
        REFERENCES departments_3nf(department_id)
);

-- =====================================================
-- PART 4: INSERT DATA INTO NORMALIZED TABLES
-- =====================================================

-- 7. Insert unique departments
INSERT INTO departments_3nf
    (department_id, department_name, department_location)
VALUES
    (10, 'IT', 'Dhaka'),
    (20, 'HR', 'Chattogram'),
    (30, 'Finance', 'Sylhet')
ON DUPLICATE KEY UPDATE
    department_name = VALUES(department_name),
    department_location = VALUES(department_location);

-- 8. Insert employee records
INSERT INTO employees_3nf
    (employee_id, employee_name, department_id)
VALUES
    (101, 'Rahim Ahmed', 10),
    (102, 'Karim Hasan', 20),
    (103, 'Nusrat Jahan', 10),
    (104, 'Sadia Islam', 30),
    (105, 'Hasan Mahmud', 20)
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    department_id = VALUES(department_id);

-- =====================================================
-- PART 5: DISPLAY NORMALIZED TABLES
-- =====================================================

-- 9. Display departments
SELECT * FROM departments_3nf;

-- 10. Display employees
SELECT * FROM employees_3nf;

-- 11. Reconstruct employee and department information
SELECT
    e.employee_id,
    e.employee_name,
    d.department_id,
    d.department_name,
    d.department_location
FROM employees_3nf AS e
INNER JOIN departments_3nf AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;

-- 12. Count employees in each department
SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees
FROM departments_3nf AS d
LEFT JOIN employees_3nf AS e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;
