
-- =========================================================
-- Project: Student Management System
-- File: 12_testing.sql
-- DBMS: MySQL / MariaDB
-- Purpose: Database Testing and Validation
-- =========================================================

USE student_management_db;


-- =========================================================
-- Test 1: Verify all main tables exist
-- =========================================================

SHOW TABLES;


-- =========================================================
-- Test 2: Check student records
-- =========================================================

SELECT
    COUNT(*) AS total_students
FROM students;

SELECT *
FROM students
ORDER BY student_id
LIMIT 10;


-- =========================================================
-- Test 3: Check department records
-- =========================================================

SELECT
    COUNT(*) AS total_departments
FROM departments;

SELECT *
FROM departments
ORDER BY department_id;


-- =========================================================
-- Test 4: Check course records
-- =========================================================

SELECT
    COUNT(*) AS total_courses
FROM courses;

SELECT
    course_id,
    course_code,
    course_title,
    credit_hours
FROM courses
ORDER BY course_code;


-- =========================================================
-- Test 5: Check enrollment records
-- =========================================================

SELECT
    COUNT(*) AS total_enrollments,
    COUNT(marks) AS graded_enrollments,
    SUM(
        CASE WHEN marks IS NULL THEN 1 ELSE 0 END
    ) AS pending_results
FROM enrollments;


-- =========================================================
-- Test 6: Find duplicate student-course-section enrollments
-- Expected result: No rows, if duplicate prevention is enforced.
-- =========================================================

SELECT
    student_id,
    section_id,
    COUNT(*) AS duplicate_count
FROM enrollments
GROUP BY student_id, section_id
HAVING COUNT(*) > 1;


-- =========================================================
-- Test 7: Check invalid marks
-- Expected result: No rows if marks are restricted to 0-100.
-- =========================================================

SELECT
    enrollment_id,
    student_id,
    marks
FROM enrollments
WHERE marks < 0
   OR marks > 100;


-- =========================================================
-- Test 8: Find enrollments with missing student records
-- Expected result: No rows if foreign keys are enforced.
-- =========================================================

SELECT
    e.enrollment_id,
    e.student_id
FROM enrollments AS e
LEFT JOIN students AS s
    ON e.student_id = s.student_id
WHERE s.student_id IS NULL;


-- =========================================================
-- Test 9: Find enrollments with missing course sections
-- Expected result: No rows if foreign keys are enforced.
-- =========================================================

SELECT
    e.enrollment_id,
    e.section_id
FROM enrollments AS e
LEFT JOIN course_sections AS cs
    ON e.section_id = cs.section_id
WHERE cs.section_id IS NULL;


-- =========================================================
-- Test 10: Verify view definitions
-- =========================================================

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT * FROM vw_student_details LIMIT 10;
SELECT * FROM vw_instructor_details LIMIT 10;
SELECT * FROM vw_course_section_details LIMIT 10;
SELECT * FROM vw_enrollment_details LIMIT 10;
SELECT * FROM vw_student_academic_summary LIMIT 10;
SELECT * FROM vw_pending_results LIMIT 10;
SELECT * FROM vw_section_enrollment_summary LIMIT 10;
SELECT * FROM vw_course_performance LIMIT 10;


-- =========================================================
-- Test 11: Verify indexes
-- =========================================================

SHOW INDEX FROM students;
SHOW INDEX FROM enrollments;
SHOW INDEX FROM course_sections;
SHOW INDEX FROM courses;


-- =========================================================
-- Test 12: Verify triggers
-- =========================================================

SHOW TRIGGERS;


-- =========================================================
-- Test 13: Verify stored procedures
-- =========================================================

SHOW PROCEDURE STATUS
WHERE Db = 'student_management_db';


-- =========================================================
-- Test 14: Inspect enrollment audit history
-- =========================================================

SELECT *
FROM enrollment_audit
ORDER BY audit_id DESC
LIMIT 20;


-- =========================================================
-- Test 15: Verify partitioned demo table
-- =========================================================

SHOW CREATE TABLE enrollments_partition_demo;

SELECT
    COUNT(*) AS total_partition_demo_records
FROM enrollments_partition_demo;


-- =========================================================
-- Test 16: Test query execution plan
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
-- Test 17: Check section capacity
-- =========================================================

SELECT
    cs.section_id,
    c.course_code,
    cs.capacity,
    COUNT(e.enrollment_id) AS enrolled_students,
    cs.capacity - COUNT(e.enrollment_id) AS available_seats
FROM course_sections AS cs
JOIN courses AS c
    ON cs.course_id = c.course_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_code,
    cs.capacity
ORDER BY cs.section_id;


-- =========================================================
-- Test 18: Generate a student academic summary
-- =========================================================

SELECT
    student_id,
    student_name,
    total_enrollments,
    graded_courses,
    average_marks
FROM vw_student_academic_summary
ORDER BY average_marks DESC;


-- =========================================================
-- Test 19: Check result-grade consistency
-- Uses the illustrative grading scale from the trigger.
-- Adjust if the university's official scale differs.
-- =========================================================

SELECT
    enrollment_id,
    marks,
    grade
FROM enrollments
WHERE
    (marks IS NULL AND grade IS NOT NULL)
    OR
    (marks IS NOT NULL AND (
        grade IS NULL
        OR (marks >= 90 AND grade <> 'A+')
        OR (marks >= 85 AND marks < 90 AND grade <> 'A')
        OR (marks >= 80 AND marks < 85 AND grade <> 'A-')
        OR (marks >= 75 AND marks < 80 AND grade <> 'B+')
        OR (marks >= 70 AND marks < 75 AND grade <> 'B')
        OR (marks >= 65 AND marks < 70 AND grade <> 'B-')
        OR (marks >= 60 AND marks < 65 AND grade <> 'C+')
        OR (marks >= 55 AND marks < 60 AND grade <> 'C')
        OR (marks >= 50 AND marks < 55 AND grade <> 'C-')
        OR (marks >= 45 AND marks < 50 AND grade <> 'D')
        OR (marks < 45 AND grade <> 'F')
    ));


-- =========================================================
-- End of 12_testing.sql
-- =========================================================
