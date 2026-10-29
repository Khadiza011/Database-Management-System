
-- =========================================================
-- Project: Student Management System
-- File: indexes.sql
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- Purpose: Indexing and Query Performance Optimization
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 83: Create an index on student admission dates
-- Use case: Find students admitted during a specific period.
-- =========================================================

CREATE INDEX idx_students_admission_date
ON students(admission_date);


-- Test Query
SELECT
    student_id,
    full_name,
    admission_date
FROM students
WHERE admission_date >= '2024-01-01'
  AND admission_date < '2025-01-01';


-- =========================================================
-- Problem 84: Create an index on enrollment dates
-- Use case: Retrieve enrollments within a date range.
-- =========================================================

CREATE INDEX idx_enrollments_enrollment_date
ON enrollments(enrollment_date);


-- Test Query
SELECT
    enrollment_id,
    student_id,
    section_id,
    enrollment_date
FROM enrollments
WHERE enrollment_date >= '2025-01-01'
  AND enrollment_date < '2026-01-01'
ORDER BY enrollment_date;


-- =========================================================
-- Problem 85: Create a composite index for semester reports
-- Use case: Find course sections offered in a semester.
-- =========================================================

CREATE INDEX idx_sections_semester_course
ON course_sections(semester_id, course_id);


-- Test Query
SELECT
    section_id,
    course_id,
    semester_id,
    section_number
FROM course_sections
WHERE semester_id = 403;


-- =========================================================
-- Problem 86: Create an index for course title searches
-- Use case: Search courses by their title.
-- =========================================================

CREATE INDEX idx_courses_title
ON courses(course_title);


-- Test Query
SELECT
    course_code,
    course_title
FROM courses
WHERE course_title = 'Database Management Systems';


-- =========================================================
-- Problem 87: Create a composite index for marks analysis
-- Use case: Retrieve graded results for a section,
-- ordered by marks.
-- =========================================================

CREATE INDEX idx_enrollments_section_marks
ON enrollments(section_id, marks);


-- Test Query
SELECT
    student_id,
    marks
FROM enrollments
WHERE section_id = 501
  AND marks IS NOT NULL
ORDER BY marks DESC;


-- =========================================================
-- Problem 88: Inspect existing indexes
-- =========================================================

SHOW INDEX FROM students;
SHOW INDEX FROM enrollments;
SHOW INDEX FROM course_sections;
SHOW INDEX FROM courses;


-- =========================================================
-- Problem 89: Analyze a student search query
-- EXPLAIN shows the query execution plan.
-- =========================================================

EXPLAIN
SELECT
    student_id,
    full_name,
    admission_date
FROM students
WHERE admission_date >= '2024-01-01'
  AND admission_date < '2025-01-01';


-- =========================================================
-- Problem 90: Analyze an enrollment report query
-- =========================================================

EXPLAIN
SELECT
    student_id,
    marks
FROM enrollments
WHERE section_id = 501
  AND marks IS NOT NULL
ORDER BY marks DESC;


-- =========================================================
-- Problem 91: Analyze a course lookup query
-- =========================================================

EXPLAIN
SELECT
    course_id,
    course_code,
    course_title
FROM courses
WHERE course_title = 'Database Management Systems';


-- =========================================================
-- Problem 92: Compare index choices using EXPLAIN
-- =========================================================

EXPLAIN
SELECT
    section_id,
    course_id,
    semester_id,
    section_number
FROM course_sections
WHERE semester_id = 403
  AND course_id = 302;


-- =========================================================
-- Problem 93: Display table sizes and row estimates
-- =========================================================

SELECT
    TABLE_NAME,
    TABLE_ROWS,
    DATA_LENGTH,
    INDEX_LENGTH
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'student_management_db'
ORDER BY TABLE_NAME;
