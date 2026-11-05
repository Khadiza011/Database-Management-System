
-- =====================================================
-- Topic: Boyce-Codd Normal Form (BCNF)
-- File: 04_Boyce_Codd_Normal_Form_BCNF.sql
-- Database: normalization_db
-- DBMS: MySQL
-- Tool: MySQL Workbench
-- =====================================================

-- 1. Select the database
CREATE DATABASE IF NOT EXISTS normalization_db;
USE normalization_db;

-- =====================================================
-- PART 1: CREATE THE ORIGINAL TABLE
-- =====================================================

-- 2. Create an instructor course table
CREATE TABLE IF NOT EXISTS instructor_courses_3nf (
    student_id INT,
    course_id INT,
    instructor_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id)
);

-- 3. Insert sample records
INSERT INTO instructor_courses_3nf
    (student_id, course_id, instructor_id)
VALUES
    (101, 201, 301),
    (102, 201, 301),
    (103, 202, 302),
    (104, 202, 303),
    (105, 203, 302),
    (106, 203, 303)
ON DUPLICATE KEY UPDATE
    instructor_id = VALUES(instructor_id);

-- 4. Display original records
SELECT * FROM instructor_courses_3nf;

-- =====================================================
-- PART 2: FUNCTIONAL DEPENDENCIES
-- =====================================================

-- Functional Dependencies:
--
-- (student_id, course_id) -> instructor_id
--
-- instructor_id -> course_id
--
-- The second dependency means that each instructor
-- teaches only one course in this example.

-- =====================================================
-- PART 3: DECOMPOSITION INTO BCNF
-- =====================================================

-- 5. Create an instructor-course table
CREATE TABLE IF NOT EXISTS instructors_bcnf (
    instructor_id INT PRIMARY KEY,
    course_id INT NOT NULL
);

-- 6. Create a student-instructor table
CREATE TABLE IF NOT EXISTS student_instructors_bcnf (
    student_id INT,
    instructor_id INT,
    PRIMARY KEY (student_id, instructor_id),
    FOREIGN KEY (instructor_id)
        REFERENCES instructors_bcnf(instructor_id)
);

-- =====================================================
-- PART 4: INSERT NORMALIZED DATA
-- =====================================================

-- 7. Insert unique instructors
INSERT INTO instructors_bcnf
    (instructor_id, course_id)
VALUES
    (301, 201),
    (302, 203),
    (303, 202)
ON DUPLICATE KEY UPDATE
    course_id = VALUES(course_id);

-- 8. Insert student-instructor relationships
INSERT INTO student_instructors_bcnf
    (student_id, instructor_id)
VALUES
    (101, 301),
    (102, 301),
    (103, 302),
    (104, 303),
    (105, 302),
    (106, 303)
ON DUPLICATE KEY UPDATE
    instructor_id = VALUES(instructor_id);

-- =====================================================
-- PART 5: DISPLAY NORMALIZED TABLES
-- =====================================================

-- 9. Display instructors
SELECT * FROM instructors_bcnf;

-- 10. Display student-instructor relationships
SELECT * FROM student_instructors_bcnf;

-- 11. Reconstruct original information using JOIN
SELECT
    si.student_id,
    i.course_id,
    si.instructor_id
FROM student_instructors_bcnf AS si
INNER JOIN instructors_bcnf AS i
    ON si.instructor_id = i.instructor_id
ORDER BY si.student_id;

-- 12. Display the number of students per instructor
SELECT
    i.instructor_id,
    i.course_id,
    COUNT(si.student_id) AS total_students
FROM instructors_bcnf AS i
LEFT JOIN student_instructors_bcnf AS si
    ON i.instructor_id = si.instructor_id
GROUP BY i.instructor_id, i.course_id;
