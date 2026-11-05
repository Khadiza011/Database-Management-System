
-- =====================================================
-- Topic: Candidate Keys and Determinants
-- File: 02_Candidate_Keys_and_Determinants.sql
-- Database: fd_practice_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS fd_practice_db;
USE fd_practice_db;

-- =====================================================
-- 2. Create a students table
-- =====================================================

CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    department VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

-- 3. Insert sample student records
INSERT INTO students
    (student_id, student_name, email, department)
VALUES
    (101, 'Rahim Ahmed', 'rahim@example.com', 'CSE'),
    (102, 'Karim Hasan', 'karim@example.com', 'BBA'),
    (103, 'Nusrat Jahan', 'nusrat@example.com', 'CSE'),
    (104, 'Sadia Islam', 'sadia@example.com', 'EEE')
ON DUPLICATE KEY UPDATE
    student_name = VALUES(student_name),
    email = VALUES(email),
    department = VALUES(department);

-- 4. Display all students
SELECT * FROM students;

-- =====================================================
-- 5. Create a table to demonstrate composite keys
-- =====================================================

CREATE TABLE IF NOT EXISTS student_courses (
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id)
) ENGINE = InnoDB;

-- 6. Insert sample enrollment records
INSERT INTO student_courses
    (student_id, course_id, grade)
VALUES
    (101, 201, 'A'),
    (101, 202, 'B'),
    (102, 201, 'A'),
    (103, 203, 'A'),
    (104, 202, 'B')
ON DUPLICATE KEY UPDATE
    grade = VALUES(grade);

-- 7. Display student course records
SELECT * FROM student_courses;

-- =====================================================
-- 8. Demonstrate unique identifiers
-- =====================================================

SELECT
    student_id,
    student_name,
    email
FROM students
ORDER BY student_id;

-- =====================================================
-- 9. Demonstrate candidate key properties
-- student_id and email are individually unique
-- =====================================================

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT student_id) AS unique_student_ids,
    COUNT(DISTINCT email) AS unique_emails
FROM students;

-- =====================================================
-- 10. Demonstrate composite key uniqueness
-- =====================================================

SELECT
    student_id,
    course_id,
    COUNT(*) AS combination_count
FROM student_courses
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- No rows should be returned because the
-- composite primary key prevents duplicate combinations.

-- =====================================================
-- 11. Display primary key and unique constraints
-- =====================================================

SHOW CREATE TABLE students;

-- =====================================================
-- 12. Display composite primary key definition
-- =====================================================

SHOW CREATE TABLE student_courses;

-- =====================================================
-- 13. Find the number of unique departments
-- =====================================================

SELECT
    COUNT(DISTINCT department) AS unique_departments
FROM students;
