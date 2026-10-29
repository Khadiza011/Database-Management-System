
-- =====================================================
-- Topic: SQL Conditions and CASE Expressions
-- File: 06_SQL_Conditions_and_Case.sql
-- Database: MySQL
-- =====================================================

USE university_db;

-- 1. CASE: Categorize students by age
SELECT
    student_name,
    age,
    CASE
        WHEN age < 21 THEN 'Young'
        WHEN age <= 22 THEN 'Middle'
        ELSE 'Senior'
    END AS Age_Category
FROM students;

-- 2. CASE: Check the department
SELECT
    student_name,
    department,
    CASE
        WHEN department = 'CSE' THEN 'Computer Science'
        WHEN department = 'EEE' THEN 'Electrical Engineering'
        WHEN department = 'BBA' THEN 'Business Administration'
        ELSE 'Other Department'
    END AS Department_Name
FROM students;

-- 3. Simple CASE expression
SELECT
    student_name,
    department,
    CASE department
        WHEN 'CSE' THEN 'Technology'
        WHEN 'EEE' THEN 'Engineering'
        WHEN 'BBA' THEN 'Business'
        ELSE 'Other'
    END AS Department_Category
FROM students;

-- 4. IF(): Check whether a student is at least 21
SELECT
    student_name,
    age,
    IF(age >= 21, 'Adult', 'Under 21') AS Age_Status
FROM students;

-- 5. COALESCE(): Replace NULL department values
SELECT
    student_name,
    COALESCE(department, 'Not Assigned') AS Department
FROM students;

-- 6. NULLIF(): Return NULL when two values are equal
SELECT NULLIF(10, 10) AS Result;

-- 7. NULLIF(): Return the first value when values differ
SELECT NULLIF(10, 20) AS Result;

-- 8. Combine CASE with ORDER BY
SELECT
    student_name,
    age,
    CASE
        WHEN age >= 22 THEN 'Experienced'
        ELSE 'Regular'
    END AS Student_Category
FROM students
ORDER BY age DESC;

-- 9. Count students in each age category
SELECT
    CASE
        WHEN age < 21 THEN 'Below 21'
        WHEN age <= 22 THEN '21 to 22'
        ELSE 'Above 22'
    END AS Age_Category,
    COUNT(*) AS Total_Students
FROM students
GROUP BY Age_Category;
