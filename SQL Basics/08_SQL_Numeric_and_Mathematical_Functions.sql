
-- =====================================================
-- Topic: SQL Numeric and Mathematical Functions
-- File: 08_SQL_Numeric_and_Mathematical_Functions.sql
-- Database: MySQL
-- =====================================================

USE university_db;

-- 1. ROUND(): Round a number to two decimal places
SELECT ROUND(12.5678, 2) AS Rounded_Value;

-- 2. CEIL(): Round upward to the nearest integer
SELECT CEIL(12.3) AS Ceiling_Value;

-- 3. FLOOR(): Round downward to the nearest integer
SELECT FLOOR(12.9) AS Floor_Value;

-- 4. ABS(): Return the absolute value
SELECT ABS(-25) AS Absolute_Value;

-- 5. MOD(): Return the remainder
SELECT MOD(17, 5) AS Remainder;

-- 6. POWER(): Calculate a number raised to a power
SELECT POWER(2, 3) AS Power_Value;

-- 7. SQRT(): Calculate the square root
SELECT SQRT(64) AS Square_Root;

-- 8. TRUNCATE(): Remove decimal digits without rounding
SELECT TRUNCATE(12.5678, 2) AS Truncated_Value;

-- 9. SIGN(): Return the sign of a number
SELECT SIGN(-15) AS Number_Sign;

-- 10. RAND(): Generate a random number
SELECT RAND() AS Random_Number;

-- 11. Calculate the square of each student's age
SELECT
    student_name,
    age,
    POWER(age, 2) AS Age_Squared
FROM students;

-- 12. Calculate age divided by two
SELECT
    student_name,
    age,
    ROUND(age / 2, 2) AS Half_Age
FROM students;

-- 13. Find the remainder when age is divided by two
SELECT
    student_name,
    age,
    MOD(age, 2) AS Age_Remainder
FROM students;

-- 14. Calculate the square root of each student's age
SELECT
    student_name,
    age,
    ROUND(SQRT(age), 2) AS Age_Square_Root
FROM students;

-- 15. Display each age rounded upward and downward
SELECT
    student_name,
    age,
    CEIL(age / 3) AS Rounded_Up,
    FLOOR(age / 3) AS Rounded_Down
FROM students;
