
-- =========================================================
-- Project: Student Management System
-- File: views.sql
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- Purpose: Create reusable database views
-- =========================================================

USE student_management_db;


-- =========================================================
-- View 1: Student Details
-- Problem: Display students with their department names.
-- =========================================================

CREATE OR REPLACE VIEW vw_student_details AS
SELECT
    s.student_id,
    s.full_name,
    s.email,
    s.date_of_birth,
    s.admission_date,
    d.department_id,
    d.department_name
FROM students AS s
INNER JOIN departments AS d
    ON s.department_id = d.department_id;


-- Test View 1
SELECT *
FROM vw_student_details;


-- =========================================================
-- View 2: Instructor Details
-- Problem: Display instructor information with departments.
-- =========================================================

CREATE OR REPLACE VIEW vw_instructor_details AS
SELECT
    i.instructor_id,
    i.full_name AS instructor_name,
    i.email,
    d.department_name
FROM instructors AS i
INNER JOIN departments AS d
    ON i.department_id = d.department_id;


-- Test View 2
SELECT *
FROM vw_instructor_details;


-- =========================================================
-- View 3: Course Section Details
-- Problem: Display courses, sections, semesters and instructors.
-- =========================================================

CREATE OR REPLACE VIEW vw_course_section_details AS
SELECT
    cs.section_id,
    c.course_code,
    c.course_title,
    c.credit_hours,
    cs.section_number,
    cs.capacity,
    sem.semester_name,
    sem.academic_year,
    i.instructor_id,
    i.full_name AS instructor_name
FROM course_sections AS cs
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
INNER JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
INNER JOIN instructors AS i
    ON cs.instructor_id = i.instructor_id;


-- Test View 3
SELECT *
FROM vw_course_section_details;


-- =========================================================
-- View 4: Enrollment Details
-- Problem: Generate a detailed student enrollment report.
-- =========================================================

CREATE OR REPLACE VIEW vw_enrollment_details AS
SELECT
    e.enrollment_id,
    s.student_id,
    s.full_name AS student_name,
    d.department_name,
    c.course_code,
    c.course_title,
    c.credit_hours,
    cs.section_number,
    sem.semester_name,
    sem.academic_year,
    e.enrollment_date,
    e.marks,
    e.grade
FROM enrollments AS e
INNER JOIN students AS s
    ON e.student_id = s.student_id
INNER JOIN departments AS d
    ON s.department_id = d.department_id
INNER JOIN course_sections AS cs
    ON e.section_id = cs.section_id
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
INNER JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id;


-- Test View 4
SELECT *
FROM vw_enrollment_details;


-- =========================================================
-- View 5: Student Academic Summary
-- Problem: Calculate each student's average marks and
-- count graded courses.
-- Students without enrollments are also included.
-- =========================================================

CREATE OR REPLACE VIEW vw_student_academic_summary AS
SELECT
    s.student_id,
    s.full_name AS student_name,
    d.department_name,
    COUNT(e.enrollment_id) AS total_enrollments,
    COUNT(e.marks) AS graded_courses,
    ROUND(AVG(e.marks), 2) AS average_marks
FROM students AS s
INNER JOIN departments AS d
    ON s.department_id = d.department_id
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name,
    d.department_name;


-- Test View 5
SELECT *
FROM vw_student_academic_summary
ORDER BY average_marks DESC;


-- =========================================================
-- View 6: Pending Results
-- Problem: Identify enrollments whose marks are not yet available.
-- =========================================================

CREATE OR REPLACE VIEW vw_pending_results AS
SELECT
    e.enrollment_id,
    s.student_id,
    s.full_name AS student_name,
    c.course_code,
    c.course_title,
    sem.semester_name,
    sem.academic_year,
    e.enrollment_date
FROM enrollments AS e
INNER JOIN students AS s
    ON e.student_id = s.student_id
INNER JOIN course_sections AS cs
    ON e.section_id = cs.section_id
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
INNER JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
WHERE e.marks IS NULL;


-- Test View 6
SELECT *
FROM vw_pending_results;


-- =========================================================
-- View 7: Section Enrollment Summary
-- Problem: Show enrolled students and remaining seats.
-- =========================================================

CREATE OR REPLACE VIEW vw_section_enrollment_summary AS
SELECT
    cs.section_id,
    c.course_code,
    c.course_title,
    cs.section_number,
    sem.semester_name,
    sem.academic_year,
    cs.capacity,
    COUNT(e.enrollment_id) AS enrolled_students,
    cs.capacity - COUNT(e.enrollment_id) AS available_seats
FROM course_sections AS cs
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
INNER JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_code,
    c.course_title,
    cs.section_number,
    sem.semester_name,
    sem.academic_year,
    cs.capacity;


-- Test View 7
SELECT *
FROM vw_section_enrollment_summary
ORDER BY section_id;


-- =========================================================
-- View 8: Course Performance Summary
-- Problem: Compare average, highest and lowest marks per course.
-- =========================================================

CREATE OR REPLACE VIEW vw_course_performance AS
SELECT
    c.course_id,
    c.course_code,
    c.course_title,
    COUNT(e.marks) AS graded_students,
    ROUND(AVG(e.marks), 2) AS average_marks,
    MAX(e.marks) AS highest_marks,
    MIN(e.marks) AS lowest_marks
FROM courses AS c
LEFT JOIN course_sections AS cs
    ON c.course_id = cs.course_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_title;


-- Test View 8
SELECT *
FROM vw_course_performance
ORDER BY average_marks DESC;


-- =========================================================
-- Verify Created Views
-- =========================================================

SHOW FULL TABLES
WHERE Table_type = 'VIEW';
