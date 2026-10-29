
-- =========================================================
-- Project: Student Management System
-- File: solutions.sql
-- Part 1: Basic SQL
-- DBMS: MySQL / MariaDB
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 1: Display all students
-- =========================================================

SELECT *
FROM students;


-- =========================================================
-- Problem 2: Display student names and email addresses
-- =========================================================

SELECT
    full_name,
    email
FROM students;


-- =========================================================
-- Problem 3: Find students admitted in 2024
-- =========================================================

SELECT
    student_id,
    full_name,
    admission_date
FROM students
WHERE admission_date >= '2024-01-01'
  AND admission_date < '2025-01-01';


-- =========================================================
-- Problem 4: Find students from Department 1
-- =========================================================

SELECT
    student_id,
    full_name,
    department_id
FROM students
WHERE department_id = 1;


-- =========================================================
-- Problem 5: Display students alphabetically
-- =========================================================

SELECT
    student_id,
    full_name,
    email
FROM students
ORDER BY full_name ASC;


-- =========================================================
-- Problem 6: Find students admitted after 2023
-- =========================================================

SELECT
    student_id,
    full_name,
    admission_date
FROM students
WHERE admission_date > '2023-12-31'
ORDER BY admission_date;


-- =========================================================
-- Problem 7: Find students whose names start with 'A'
-- =========================================================

SELECT
    student_id,
    full_name
FROM students
WHERE full_name LIKE 'A%';


-- =========================================================
-- Problem 8: Find students whose names contain 'ah'
-- =========================================================

SELECT
    student_id,
    full_name
FROM students
WHERE full_name LIKE '%ah%';


-- =========================================================
-- Problem 9: Display unique department IDs in students
-- =========================================================

SELECT DISTINCT
    department_id
FROM students
ORDER BY department_id;


-- =========================================================
-- Problem 10: Display the five most recently admitted students
-- =========================================================

SELECT
    student_id,
    full_name,
    admission_date
FROM students
ORDER BY admission_date DESC, student_id DESC
LIMIT 5;


-- =========================================================
-- Problem 11: Count all registered students
-- =========================================================

SELECT
    COUNT(*) AS total_students
FROM students;


-- =========================================================
-- Problem 12: Find students born between 2003 and 2004
-- =========================================================

SELECT
    student_id,
    full_name,
    date_of_birth
FROM students
WHERE date_of_birth >= '2003-01-01'
  AND date_of_birth < '2005-01-01'
ORDER BY date_of_birth;


-- =========================================================
-- Problem 13: Find students without a date of birth
-- =========================================================

SELECT
    student_id,
    full_name
FROM students
WHERE date_of_birth IS NULL;


-- =========================================================
-- Problem 14: Display courses worth at least 3 credits
-- =========================================================

SELECT
    course_code,
    course_title,
    credit_hours
FROM courses
WHERE credit_hours >= 3.0
ORDER BY credit_hours DESC;


-- =========================================================
-- Problem 15: Find course sections with available capacity
-- =========================================================

SELECT
    section_id,
    course_id,
    section_number,
    capacity
FROM course_sections
WHERE capacity > 0
ORDER BY capacity DESC;
