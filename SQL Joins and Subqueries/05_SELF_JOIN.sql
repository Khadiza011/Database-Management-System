
-- =====================================================
-- Topic: SELF JOIN
-- File: 05_SELF_JOIN.sql
-- Database: retail_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE retail_db;

-- 2. Create an employees table
CREATE TABLE IF NOT EXISTS self_join_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    manager_id INT
) ENGINE = InnoDB;

-- 3. Insert sample employee records
INSERT INTO self_join_employees
    (employee_id, employee_name, department, manager_id)
VALUES
    (101, 'Rahim', 'IT', NULL),
    (102, 'Karim', 'IT', 101),
    (103, 'Nusrat', 'HR', 101),
    (104, 'Sadia', 'HR', 103),
    (105, 'Hasan', 'Sales', 101)
ON DUPLICATE KEY UPDATE
    employee_name = VALUES(employee_name),
    department = VALUES(department),
    manager_id = VALUES(manager_id);

-- 4. Display all employees
SELECT * FROM self_join_employees;

-- 5. Find each employee and their manager
SELECT
    e.employee_name AS Employee,
    m.employee_name AS Manager
FROM self_join_employees AS e
LEFT JOIN self_join_employees AS m
    ON e.manager_id = m.employee_id;

-- 6. Find employees who have a manager
SELECT
    e.employee_name AS Employee,
    m.employee_name AS Manager
FROM self_join_employees AS e
INNER JOIN self_join_employees AS m
    ON e.manager_id = m.employee_id;

-- 7. Find employees who work in the same department
SELECT
    e.employee_name AS Employee_1,
    e.department,
    x.employee_name AS Employee_2
FROM self_join_employees AS e
INNER JOIN self_join_employees AS x
    ON e.department = x.department
   AND e.employee_id < x.employee_id;

-- 8. Find employees who have no manager
SELECT
    employee_id,
    employee_name
FROM self_join_employees
WHERE manager_id IS NULL;
