
-- =========================================================
-- Project: Student Management System
-- File: 13_normalization.sql
-- DBMS: MySQL / MariaDB
-- Purpose: Functional Dependency and Normalization
-- Topics: 1NF, 2NF, 3NF, Candidate Keys, Anomalies
-- =========================================================

USE student_management_db;


-- =========================================================
-- PART 1: A DENORMALIZED UNIVERSITY RECORD
--
-- Problem:
-- Student, department, course and instructor information
-- is repeatedly stored in enrollment records.
--
-- This is a demonstration table. It does not modify the
-- original Student Management System tables.
-- =========================================================

DROP TABLE IF EXISTS norm_enrollment_flat;

CREATE TABLE norm_enrollment_flat (
    student_id INT NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    department_name VARCHAR(100) NOT NULL,
    course_id INT NOT NULL,
    course_code VARCHAR(20) NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    section_id INT NOT NULL,
    instructor_name VARCHAR(100) NOT NULL,
    semester_name VARCHAR(50) NOT NULL,
    marks DECIMAL(5,2) DEFAULT NULL,

    PRIMARY KEY (student_id, section_id)
);


-- Sample data
INSERT INTO norm_enrollment_flat (
    student_id,
    student_name,
    student_email,
    department_id,
    department_name,
    course_id,
    course_code,
    course_title,
    section_id,
    instructor_name,
    semester_name,
    marks
)
VALUES
(
    1001, 'Ayesha Rahman', 'ayesha@example.com',
    10, 'Computer Science',
    201, 'CSE101', 'Introduction to Programming',
    501, 'Dr. Karim', 'Fall 2026', 88.00
),
(
    1002, 'Tanvir Hasan', 'tanvir@example.com',
    10, 'Computer Science',
    201, 'CSE101', 'Introduction to Programming',
    501, 'Dr. Karim', 'Fall 2026', 79.00
),
(
    1001, 'Ayesha Rahman', 'ayesha@example.com',
    10, 'Computer Science',
    202, 'CSE201', 'Database Management Systems',
    502, 'Dr. Nabila', 'Fall 2026', 94.00
),
(
    1003, 'Nusrat Jahan', 'nusrat@example.com',
    20, 'Electrical Engineering',
    301, 'EEE101', 'Basic Electrical Engineering',
    503, 'Dr. Rahman', 'Fall 2026', NULL
);


-- View the repeated data.
SELECT *
FROM norm_enrollment_flat
ORDER BY student_id, section_id;


-- =========================================================
-- PART 2: FUNCTIONAL DEPENDENCIES
--
-- Important dependencies in this example:
--
-- student_id -> student_name, student_email, department_id
-- department_id -> department_name
-- course_id -> course_code, course_title
-- section_id -> course_id, instructor_name, semester_name
-- (student_id, section_id) -> marks
--
-- These dependencies assume student, course and section IDs
-- uniquely identify their respective entities.
-- =========================================================

-- Find repeated student details.
SELECT
    student_id,
    COUNT(*) AS enrollment_records,
    COUNT(DISTINCT student_name) AS different_names,
    COUNT(DISTINCT student_email) AS different_emails
FROM norm_enrollment_flat
GROUP BY student_id;


-- Find repeated course details.
SELECT
    course_id,
    COUNT(*) AS record_count,
    COUNT(DISTINCT course_title) AS different_titles
FROM norm_enrollment_flat
GROUP BY course_id;


-- =========================================================
-- PART 3: FIRST NORMAL FORM (1NF)
--
-- Requirements:
-- 1. Each column contains a single value.
-- 2. No repeating groups.
-- 3. Every record is uniquely identifiable.
--
-- The demonstration table uses atomic values and a
-- composite primary key, so it satisfies 1NF.
-- However, it still contains redundancy.
-- =========================================================

SELECT
    student_id,
    section_id,
    student_name,
    course_title,
    marks
FROM norm_enrollment_flat
ORDER BY student_id, section_id;


-- =========================================================
-- PART 4: SECOND NORMAL FORM (2NF)
--
-- 2NF requires 1NF and no partial dependency of a
-- non-key attribute on part of a candidate key.
--
-- Composite key: (student_id, section_id)
--
-- student_name depends only on student_id.
-- course/instructor details depend on section_id.
-- marks depends on the complete composite key.
--
-- Decompose into separate entity and enrollment tables.
-- =========================================================

DROP TABLE IF EXISTS norm_enrollments;
DROP TABLE IF EXISTS norm_course_sections;
DROP TABLE IF EXISTS norm_courses;
DROP TABLE IF EXISTS norm_students;


-- Student details
CREATE TABLE norm_students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    department_name VARCHAR(100) NOT NULL
);


-- Course details
CREATE TABLE norm_courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_title VARCHAR(150) NOT NULL
);


-- Section details
CREATE TABLE norm_course_sections (
    section_id INT PRIMARY KEY,
    course_id INT NOT NULL,
    instructor_name VARCHAR(100) NOT NULL,
    semester_name VARCHAR(50) NOT NULL,

    FOREIGN KEY (course_id)
        REFERENCES norm_courses(course_id)
);


-- Student enrollment and result
CREATE TABLE norm_enrollments (
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    marks DECIMAL(5,2) DEFAULT NULL,

    PRIMARY KEY (student_id, section_id),

    FOREIGN KEY (student_id)
        REFERENCES norm_students(student_id),

    FOREIGN KEY (section_id)
        REFERENCES norm_course_sections(section_id),

    CHECK (marks IS NULL OR marks BETWEEN 0 AND 100)
);


-- Populate student records without duplication.
INSERT INTO norm_students (
    student_id,
    student_name,
    student_email,
    department_id,
    department_name
)
SELECT DISTINCT
    student_id,
    student_name,
    student_email,
    department_id,
    department_name
FROM norm_enrollment_flat;


-- Populate unique course records.
INSERT INTO norm_courses (
    course_id,
    course_code,
    course_title
)
SELECT DISTINCT
    course_id,
    course_code,
    course_title
FROM norm_enrollment_flat;


-- Populate unique section records.
INSERT INTO norm_course_sections (
    section_id,
    course_id,
    instructor_name,
    semester_name
)
SELECT DISTINCT
    section_id,
    course_id,
    instructor_name,
    semester_name
FROM norm_enrollment_flat;


-- Populate enrollment records.
INSERT INTO norm_enrollments (
    student_id,
    section_id,
    marks
)
SELECT
    student_id,
    section_id,
    marks
FROM norm_enrollment_flat;


-- =========================================================
-- PART 5: VERIFY THE 2NF DECOMPOSITION
-- =========================================================

SELECT * FROM norm_students;
SELECT * FROM norm_courses;
SELECT * FROM norm_course_sections;
SELECT * FROM norm_enrollments;


-- Reconstruct the original information using JOINs.
SELECT
    s.student_id,
    s.student_name,
    s.student_email,
    s.department_name,
    c.course_code,
    c.course_title,
    cs.section_id,
    cs.instructor_name,
    cs.semester_name,
    e.marks
FROM norm_enrollments AS e
JOIN norm_students AS s
    ON e.student_id = s.student_id
JOIN norm_course_sections AS cs
    ON e.section_id = cs.section_id
JOIN norm_courses AS c
    ON cs.course_id = c.course_id
ORDER BY s.student_id, cs.section_id;


-- =========================================================
-- PART 6: THIRD NORMAL FORM (3NF)
--
-- 3NF requires 2NF and no inappropriate transitive
-- dependency of non-key attributes on a candidate key.
--
-- In norm_students:
-- student_id -> department_id
-- department_id -> department_name
--
-- department_name should be stored in its own table.
-- =========================================================

DROP TABLE IF EXISTS norm_students_3nf;
DROP TABLE IF EXISTS norm_departments;


-- Department information
CREATE TABLE norm_departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);


-- Normalized student information
CREATE TABLE norm_students_3nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,

    FOREIGN KEY (department_id)
        REFERENCES norm_departments(department_id)
);


-- Insert unique departments.
INSERT INTO norm_departments (
    department_id,
    department_name
)
SELECT DISTINCT
    department_id,
    department_name
FROM norm_students;


-- Insert student records with department references.
INSERT INTO norm_students_3nf (
    student_id,
    student_name,
    student_email,
    department_id
)
SELECT
    student_id,
    student_name,
    student_email,
    department_id
FROM norm_students;


-- =========================================================
-- PART 7: VERIFY THE 3NF DESIGN
-- =========================================================

SELECT *
FROM norm_departments;


SELECT *
FROM norm_students_3nf;


-- Display student information with department names.
SELECT
    s.student_id,
    s.student_name,
    s.student_email,
    d.department_name
FROM norm_students_3nf AS s
JOIN norm_departments AS d
    ON s.department_id = d.department_id
ORDER BY s.student_id;


-- =========================================================
-- PART 8: DEMONSTRATE NORMALIZATION BENEFITS
-- =========================================================

-- Department names are stored once.
SELECT
    department_id,
    department_name
FROM norm_departments
ORDER BY department_id;


-- Each student has one student record.
SELECT
    student_id,
    student_name,
    student_email,
    department_id
FROM norm_students_3nf
ORDER BY student_id;


-- Each student-section pair has one enrollment record.
SELECT
    student_id,
    section_id,
    marks
FROM norm_enrollments
ORDER BY student_id, section_id;


-- =========================================================
-- End of 13_normalization.sql
-- =========================================================
