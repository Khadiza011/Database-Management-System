
-- =====================================================
-- Topic: Second Normal Form (2NF)
-- File: 02_Second_Normal_Form_2NF.sql
-- Database: normalization_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS normalization_db;
USE normalization_db;

-- =====================================================
-- PART 1: BEFORE NORMALIZATION (1NF)
-- =====================================================

-- 2. Create an unnormalized-for-2NF table
CREATE TABLE IF NOT EXISTS enrollment_1nf (
    student_id INT,
    course_id INT,
    student_name VARCHAR(100) NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id)
);

-- 3. Insert sample records
INSERT INTO enrollment_1nf
    (student_id, course_id, student_name, course_name, grade)
VALUES
    (101, 201, 'Rahim Ahmed', 'DBMS', 'A'),
    (101, 202, 'Rahim Ahmed', 'DSA', 'B'),
    (102, 201, 'Karim Hasan', 'DBMS', 'A'),
    (103, 203, 'Nusrat Jahan', 'Networking', 'A'),
    (104, 202, 'Sadia Islam', 'DSA', 'B')
ON DUPLICATE KEY UPDATE
    student_name = VALUES(student_name),
    course_name = VALUES(course_name),
    grade = VALUES(grade);

-- 4. Display the original table
SELECT * FROM enrollment_1nf;

-- =====================================================
-- PART 2: IDENTIFY PARTIAL DEPENDENCIES
-- =====================================================

-- Functional Dependencies:
--
-- student_id -> student_name
-- course_id  -> course_name
--
-- (student_id, course_id) -> grade
--
-- student_name depends only on student_id.
-- course_name depends only on course_id.
-- These are partial dependencies.

-- =====================================================
-- PART 3: DECOMPOSITION INTO 2NF
-- =====================================================

-- 5. Create students table
CREATE TABLE IF NOT EXISTS students_2nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);

-- 6. Create courses table
CREATE TABLE IF NOT EXISTS courses_2nf (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

-- 7. Create enrollment table
CREATE TABLE IF NOT EXISTS enrollments_2nf (
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id)
        REFERENCES students_2nf(student_id),
    FOREIGN KEY (course_id)
        REFERENCES courses_2nf(course_id)
);

-- =====================================================
-- PART 4: INSERT DATA INTO NORMALIZED TABLES
-- =====================================================

-- 8. Insert unique students
INSERT INTO students_2nf
    (student_id, student_name)
VALUES
    (101, 'Rahim Ahmed'),
    (102, 'Karim Hasan'),
    (103, 'Nusrat Jahan'),
    (104, 'Sadia Islam')
ON DUPLICATE KEY UPDATE
    student_name = VALUES(student_name);

-- 9. Insert unique courses
INSERT INTO courses_2nf
    (course_id, course_name)
VALUES
    (201, 'DBMS'),
    (202, 'DSA'),
    (203, 'Networking')
ON DUPLICATE KEY UPDATE
    course_name = VALUES(course_name);

-- 10. Insert student enrollments
INSERT INTO enrollments_2nf
    (student_id, course_id, grade)
VALUES
    (101, 201, 'A'),
    (101, 202, 'B'),
    (102, 201, 'A'),
    (103, 203, 'A'),
    (104, 202, 'B')
ON DUPLICATE KEY UPDATE
    grade = VALUES(grade);

-- =====================================================
-- PART 5: DISPLAY NORMALIZED DATA
-- =====================================================

-- 11. Display students
SELECT * FROM students_2nf;

-- 12. Display courses
SELECT * FROM courses_2nf;

-- 13. Display enrollments
SELECT * FROM enrollments_2nf;

-- 14. Reconstruct the original information using JOIN
SELECT
    s.student_id,
    s.student_name,
    c.course_id,
    c.course_name,
    e.grade
FROM enrollments_2nf AS e
INNER JOIN students_2nf AS s
    ON e.student_id = s.student_id
INNER JOIN courses_2nf AS c
    ON e.course_id = c.course_id
ORDER BY s.student_id, c.course_id;
