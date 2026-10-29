
-- =====================================================
-- Topic: SQL Aliases and Expressions
-- File: 05_SQL_Aliases_and_Expressions.sql
-- Database: MySQL
-- =====================================================

USE university_db;

-- 1. Display a column with an alias
SELECT student_name AS Name
FROM students;

-- 2. Rename multiple columns in the output
SELECT
    student_id AS ID,
    student_name AS Name,
    age AS Age,
    department AS Department
FROM students;

-- 3. Use an alias containing spaces
SELECT student_name AS `Student Name`
FROM students;

-- 4. Use a table alias
SELECT s.student_id, s.student_name, s.department
FROM students AS s;

-- 5. Calculate age after five years
SELECT
    student_name AS Name,
    age AS Current_Age,
    age + 5 AS Age_After_5_Years
FROM students;

-- 6. Calculate the square of each student's age
SELECT
    student_name AS Name,
    age,
    age * age AS Age_Squared
FROM students;

-- 7. Combine student ID and name
SELECT
    CONCAT(student_id, ' - ', student_name) AS Student_Info
FROM students;

-- 8. Combine name and department
SELECT
    CONCAT(student_name, ' studies ', department) AS Student_Details
FROM students;

-- 9. Convert student names to uppercase
SELECT UPPER(student_name) AS Uppercase_Name
FROM students;

-- 10. Convert student names to lowercase
SELECT LOWER(student_name) AS Lowercase_Name
FROM students;

-- 11. Count the characters in each student name
SELECT
    student_name,
    CHAR_LENGTH(student_name) AS Name_Length
FROM students;

-- 12. Display unique departments
SELECT DISTINCT department AS Department
FROM students;
