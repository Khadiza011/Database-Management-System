
-- =====================================================
-- Topic: SQL String Functions
-- File: 07_SQL_String_Functions.sql
-- Database: MySQL
-- =====================================================

USE university_db;

-- 1. LENGTH(): Count bytes in a string
SELECT
    student_name,
    LENGTH(student_name) AS Name_Bytes
FROM students;

-- 2. CHAR_LENGTH(): Count characters
SELECT
    student_name,
    CHAR_LENGTH(student_name) AS Name_Characters
FROM students;

-- 3. UPPER(): Convert text to uppercase
SELECT UPPER(student_name) AS Uppercase_Name
FROM students;

-- 4. LOWER(): Convert text to lowercase
SELECT LOWER(student_name) AS Lowercase_Name
FROM students;

-- 5. CONCAT(): Combine strings
SELECT
    CONCAT(student_name, ' - ', department) AS Student_Details
FROM students;

-- 6. CONCAT_WS(): Combine strings using a separator
SELECT
    CONCAT_WS(' | ', student_id, student_name, department)
    AS Student_Information
FROM students;

-- 7. SUBSTRING(): Extract part of a string
SELECT
    student_name,
    SUBSTRING(student_name, 1, 3) AS First_Three_Characters
FROM students;

-- 8. LEFT(): Extract characters from the beginning
SELECT
    student_name,
    LEFT(student_name, 2) AS First_Two_Characters
FROM students;

-- 9. RIGHT(): Extract characters from the end
SELECT
    student_name,
    RIGHT(student_name, 2) AS Last_Two_Characters
FROM students;

-- 10. TRIM(): Remove leading and trailing spaces
SELECT TRIM('   Hello MySQL   ') AS Trimmed_Text;

-- 11. LTRIM(): Remove leading spaces
SELECT LTRIM('   Hello MySQL') AS Left_Trimmed_Text;

-- 12. RTRIM(): Remove trailing spaces
SELECT RTRIM('Hello MySQL   ') AS Right_Trimmed_Text;

-- 13. REPLACE(): Replace part of a string
SELECT
    student_name,
    REPLACE(student_name, 'a', '@') AS Modified_Name
FROM students;

-- 14. REVERSE(): Reverse a string
SELECT
    student_name,
    REVERSE(student_name) AS Reversed_Name
FROM students;

-- 15. LOCATE(): Find the position of a substring
SELECT LOCATE('a', 'Database') AS Character_Position;

-- 16. LCASE(): Convert text to lowercase
SELECT LCASE(student_name) AS Lowercase_Name
FROM students;

-- 17. UCASE(): Convert text to uppercase
SELECT UCASE(student_name) AS Uppercase_Name
FROM students;
