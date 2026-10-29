
-- =====================================================
-- Topic: FOREIGN KEY Constraint
-- File: 03_FOREIGN_KEY.sql
-- Database: sales_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE sales_db;

-- 2. Create a parent table
CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE = InnoDB;

-- 3. Create a child table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
) ENGINE = InnoDB;

-- 4. Insert parent records first
INSERT INTO departments (department_id, department_name)
VALUES
    (10, 'IT'),
    (20, 'HR'),
    (30, 'Finance');

-- 5. Insert employees referencing existing departments
INSERT INTO employees (employee_id, employee_name, department_id)
VALUES
    (101, 'Rahim Ahmed', 10),
    (102, 'Karim Hasan', 20),
    (103, 'Nusrat Jahan', 10),
    (104, 'Sadia Islam', 30);

-- 6. Display departments
SELECT * FROM departments;

-- 7. Display employees
SELECT * FROM employees;

-- 8. Display the foreign key definition
SHOW CREATE TABLE employees;

-- 9. Add a new employee without a department
-- NULL is allowed because department_id is nullable
INSERT INTO employees (employee_id, employee_name, department_id)
VALUES (105, 'Hasan Mahmud', NULL);

-- 10. Display all employees
SELECT * FROM employees;
