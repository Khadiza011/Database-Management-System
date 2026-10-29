
-- =====================================================
-- Topic: SQL Aggregate Functions
-- File: 10_SQL_Aggregate_Functions.sql
-- Database: MySQL / MariaDB
-- =====================================================

USE university_db;

-- 1. Count the total number of students
SELECT COUNT(*) AS total_students
FROM students;

-- 2. Count students with a recorded age
SELECT COUNT(age) AS students_with_age
FROM students;

-- 3. Calculate the sum of all students' ages
SELECT SUM(age) AS total_age
FROM students;

-- 4. Calculate the average age
SELECT AVG(age) AS average_age
FROM students;

-- 5. Find the minimum age
SELECT MIN(age) AS minimum_age
FROM students;

-- 6. Find the maximum age
SELECT MAX(age) AS maximum_age
FROM students;

-- 7. Count the number of unique departments
SELECT COUNT(DISTINCT department) AS unique_departments
FROM students;

-- 8. Calculate the average age rounded to two decimals
SELECT ROUND(AVG(age), 2) AS average_age
FROM students;

-- 9. Count students in each department
SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department;

-- 10. Calculate the average age in each department
SELECT
    department,
    AVG(age) AS average_age
FROM students
GROUP BY department;

-- 11. Find the maximum age in each department
SELECT
    department,
    MAX(age) AS maximum_age
FROM students
GROUP BY department;

-- 12. Show departments with more than one student
SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department
HAVING COUNT(*) > 1;

-- 13. Count students whose age is greater than 20
SELECT COUNT(*) AS students_above_20
FROM students
WHERE age > 20;

-- 14. Calculate the average age of CSE students
SELECT AVG(age) AS cse_average_age
FROM students
WHERE department = 'CSE';

-- 15. Display the total, minimum, maximum, and average age
SELECT
    COUNT(*) AS total_students,
    MIN(age) AS minimum_age,
    MAX(age) AS maximum_age,
    ROUND(AVG(age), 2) AS average_age
FROM students;
