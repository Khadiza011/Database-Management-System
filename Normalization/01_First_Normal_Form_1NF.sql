
-- =====================================================
-- Topic: First Normal Form (1NF)
-- File: 01_First_Normal_Form_1NF.sql
-- Database: normalization_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Create and select database
CREATE DATABASE IF NOT EXISTS normalization_db;
USE normalization_db;

-- =====================================================
-- PART 1: Understand UNNORMALIZED DATA
-- =====================================================

-- 2. Create an unnormalized student table
CREATE TABLE IF NOT EXISTS students_unnormalized (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    course_1 VARCHAR(100),
    course_2 VARCHAR(100),
    course_3 VARCHAR(100)
);

-- 3. Insert sample records
INSERT INTO students_unnormalized
    (student_id, student_name, course_1, course_2, course_3)
VALUES
    (101, 'Rahim Ahmed', 'DBMS', 'DSA', 'Networking'),
    (102, 'Karim Hasan', 'DBMS', 'OOP', NULL),
    (103, 'Nusrat Jahan', 'DSA', 'Networking', NULL)
ON DUPLICATE KEY UPDATE
    student_name = VALUES(student_name),
    course_1 = VALUES(course_1),
    course_2 = VALUES(course_2),
    course_3 = VALUES(course_3);

-- 4. Display unnormalized data
SELECT * FROM students_unnormalized;

-- =====================================================
-- PART 2: CONVERT DATA INTO 1NF
-- =====================================================

-- 5. Create a normalized student courses table
CREATE TABLE IF NOT EXISTS student_courses_1nf (
    student_id INT,
    student_name VARCHAR(100) NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (student_id, course_name)
);

-- 6. Insert one course per row
INSERT INTO student_courses_1nf
    (student_id, student_name, course_name)
VALUES
    (101, 'Rahim Ahmed', 'DBMS'),
    (101, 'Rahim Ahmed', 'DSA'),
    (101, 'Rahim Ahmed', 'Networking'),
    (102, 'Karim Hasan', 'DBMS'),
    (102, 'Karim Hasan', 'OOP'),
    (103, 'Nusrat Jahan', 'DSA'),
    (103, 'Nusrat Jahan', 'Networking')
ON DUPLICATE KEY UPDATE
    student_name = VALUES(student_name);

-- 7. Display 1NF data
SELECT * FROM student_courses_1nf
ORDER BY student_id, course_name;

-- 8. Find courses taken by a specific student
SELECT
    student_id,
    student_name,
    course_name
FROM student_courses_1nf
WHERE student_id = 101;

-- 9. Count courses for each student
SELECT
    student_id,
    student_name,
    COUNT(*) AS total_courses
FROM student_courses_1nf
GROUP BY student_id, student_name;

-- 10. Display unique course names
SELECT DISTINCT course_name
FROM student_courses_1nf
ORDER BY course_name;
