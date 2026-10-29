
-- =========================================================
-- Project: Student Management System
-- File: 15_final_review.sql
-- DBMS: MySQL / MariaDB
-- Purpose: Final Database Review and Consistency Checks
-- =========================================================

USE student_management_db;


-- =========================================================
-- Review 1: List all database tables and views
-- =========================================================

SHOW FULL TABLES;


-- =========================================================
-- Review 2: Inspect the main table structures
-- =========================================================

DESCRIBE students;
DESCRIBE departments;
DESCRIBE instructors;
DESCRIBE courses;
DESCRIBE semesters;
DESCRIBE course_sections;
DESCRIBE enrollments;


-- =========================================================
-- Review 3: Inspect primary and secondary indexes
-- =========================================================

SHOW INDEX FROM students;
SHOW INDEX FROM courses;
SHOW INDEX FROM course_sections;
SHOW INDEX FROM enrollments;


-- =========================================================
-- Review 4: Inspect existing views
-- =========================================================

SHOW FULL TABLES
WHERE Table_type = 'VIEW';


-- =========================================================
-- Review 5: Inspect triggers
-- =========================================================

SHOW TRIGGERS;


-- =========================================================
-- Review 6: Inspect stored procedures
-- =========================================================

SHOW PROCEDURE STATUS
WHERE Db = 'student_management_db';


-- =========================================================
-- Review 7: Check the number of records in main tables
-- =========================================================

SELECT 'students' AS table_name, COUNT(*) AS total_records
FROM students

UNION ALL

SELECT 'departments', COUNT(*)
FROM departments

UNION ALL

SELECT 'instructors', COUNT(*)
FROM instructors

UNION ALL

SELECT 'courses', COUNT(*)
FROM courses

UNION ALL

SELECT 'semesters', COUNT(*)
FROM semesters

UNION ALL

SELECT 'course_sections', COUNT(*)
FROM course_sections

UNION ALL

SELECT 'enrollments', COUNT(*)
FROM enrollments;


-- =========================================================
-- Review 8: Detect duplicate student-section enrollments
-- Expected result: No rows.
-- =========================================================

SELECT
    student_id,
    section_id,
    COUNT(*) AS duplicate_count
FROM enrollments
GROUP BY student_id, section_id
HAVING COUNT(*) > 1;


-- =========================================================
-- Review 9: Detect invalid marks
-- Expected result: No rows if marks must be between 0 and 100.
-- =========================================================

SELECT
    enrollment_id,
    student_id,
    marks
FROM enrollments
WHERE marks < 0
   OR marks > 100;


-- =========================================================
-- Review 10: Check for orphan student references
-- Expected result: No rows.
-- =========================================================

SELECT
    e.enrollment_id,
    e.student_id
FROM enrollments AS e
LEFT JOIN students AS s
    ON e.student_id = s.student_id
WHERE s.student_id IS NULL;


-- =========================================================
-- Review 11: Check for orphan section references
-- Expected result: No rows.
-- =========================================================

SELECT
    e.enrollment_id,
    e.section_id
FROM enrollments AS e
LEFT JOIN course_sections AS cs
    ON e.section_id = cs.section_id
WHERE cs.section_id IS NULL;


-- =========================================================
-- Review 12: Check section capacity
-- Expected result: No rows if no section exceeds capacity.
-- =========================================================

SELECT
    cs.section_id,
    cs.capacity,
    COUNT(e.enrollment_id) AS enrolled_students
FROM course_sections AS cs
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    cs.capacity
HAVING COUNT(e.enrollment_id) > cs.capacity;


-- =========================================================
-- Review 13: Summarize result completion
-- =========================================================

SELECT
    COUNT(*) AS total_enrollments,
    COUNT(marks) AS graded_enrollments,
    SUM(
        CASE
            WHEN marks IS NULL THEN 1
            ELSE 0
        END
    ) AS pending_results,
    ROUND(AVG(marks), 2) AS average_marks,
    MAX(marks) AS highest_marks,
    MIN(marks) AS lowest_marks
FROM enrollments;


-- =========================================================
-- Review 14: Inspect the partition demonstration table
-- =========================================================

SHOW CREATE TABLE enrollments_partition_demo;

SELECT COUNT(*) AS partition_demo_records
FROM enrollments_partition_demo;


-- =========================================================
-- Review 15: Inspect the summary table
-- =========================================================

DESCRIBE course_semester_summary;

SELECT *
FROM course_semester_summary
ORDER BY course_code, semester_name;


-- =========================================================
-- Review 16: Check the query execution plan
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
-- Review 17: Inspect database security privileges
-- Run as an authorized database administrator.
-- =========================================================

SHOW GRANTS;


-- =========================================================
-- End of 15_final_review.sql
-- =========================================================
