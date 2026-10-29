
-- =========================================================
-- Project: Student Management System
-- File: solutions.sql
-- Part 1: Basic SQL
-- DBMS: MySQL / MariaDB
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 1: Display all students
-- =========================================================

SELECT *
FROM students;


-- =========================================================
-- Problem 2: Display student names and email addresses
-- =========================================================

SELECT
    full_name,
    email
FROM students;


-- =========================================================
-- Problem 3: Find students admitted in 2024
-- =========================================================

SELECT
    student_id,
    full_name,
    admission_date
FROM students
WHERE admission_date >= '2024-01-01'
  AND admission_date < '2025-01-01';


-- =========================================================
-- Problem 4: Find students from Department 1
-- =========================================================

SELECT
    student_id,
    full_name,
    department_id
FROM students
WHERE department_id = 1;


-- =========================================================
-- Problem 5: Display students alphabetically
-- =========================================================

SELECT
    student_id,
    full_name,
    email
FROM students
ORDER BY full_name ASC;


-- =========================================================
-- Problem 6: Find students admitted after 2023
-- =========================================================

SELECT
    student_id,
    full_name,
    admission_date
FROM students
WHERE admission_date > '2023-12-31'
ORDER BY admission_date;


-- =========================================================
-- Problem 7: Find students whose names start with 'A'
-- =========================================================

SELECT
    student_id,
    full_name
FROM students
WHERE full_name LIKE 'A%';


-- =========================================================
-- Problem 8: Find students whose names contain 'ah'
-- =========================================================

SELECT
    student_id,
    full_name
FROM students
WHERE full_name LIKE '%ah%';


-- =========================================================
-- Problem 9: Display unique department IDs in students
-- =========================================================

SELECT DISTINCT
    department_id
FROM students
ORDER BY department_id;


-- =========================================================
-- Problem 10: Display the five most recently admitted students
-- =========================================================

SELECT
    student_id,
    full_name,
    admission_date
FROM students
ORDER BY admission_date DESC, student_id DESC
LIMIT 5;


-- =========================================================
-- Problem 11: Count all registered students
-- =========================================================

SELECT
    COUNT(*) AS total_students
FROM students;


-- =========================================================
-- Problem 12: Find students born between 2003 and 2004
-- =========================================================

SELECT
    student_id,
    full_name,
    date_of_birth
FROM students
WHERE date_of_birth >= '2003-01-01'
  AND date_of_birth < '2005-01-01'
ORDER BY date_of_birth;


-- =========================================================
-- Problem 13: Find students without a date of birth
-- =========================================================

SELECT
    student_id,
    full_name
FROM students
WHERE date_of_birth IS NULL;


-- =========================================================
-- Problem 14: Display courses worth at least 3 credits
-- =========================================================

SELECT
    course_code,
    course_title,
    credit_hours
FROM courses
WHERE credit_hours >= 3.0
ORDER BY credit_hours DESC;


-- =========================================================
-- Problem 15: Find course sections with available capacity
-- =========================================================

SELECT
    section_id,
    course_id,
    section_number,
    capacity
FROM course_sections
WHERE capacity > 0
ORDER BY capacity DESC;


-- =========================================================
-- Project: Student Management System
-- Part 2: SQL JOINs
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 16: Display students with their department names
-- Concept: INNER JOIN
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    s.email,
    d.department_name
FROM students AS s
INNER JOIN departments AS d
    ON s.department_id = d.department_id
ORDER BY s.student_id;


-- =========================================================
-- Problem 17: Display all departments and their students
-- Include departments without students.
-- Concept: LEFT JOIN
-- =========================================================

SELECT
    d.department_id,
    d.department_name,
    s.student_id,
    s.full_name
FROM departments AS d
LEFT JOIN students AS s
    ON d.department_id = s.department_id
ORDER BY d.department_id, s.student_id;


-- =========================================================
-- Problem 18: Display instructors with department names
-- =========================================================

SELECT
    i.instructor_id,
    i.full_name AS instructor_name,
    i.email,
    d.department_name
FROM instructors AS i
INNER JOIN departments AS d
    ON i.department_id = d.department_id
ORDER BY i.instructor_id;


-- =========================================================
-- Problem 19: Display courses offered in each semester
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    cs.section_number,
    s.semester_name,
    s.academic_year
FROM courses AS c
INNER JOIN course_sections AS cs
    ON c.course_id = cs.course_id
INNER JOIN semesters AS s
    ON cs.semester_id = s.semester_id
ORDER BY s.academic_year, s.semester_id, c.course_code;


-- =========================================================
-- Problem 20: Display course sections with instructor names
-- =========================================================

SELECT
    cs.section_id,
    c.course_code,
    c.course_title,
    cs.section_number,
    i.full_name AS instructor_name
FROM course_sections AS cs
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
INNER JOIN instructors AS i
    ON cs.instructor_id = i.instructor_id
ORDER BY cs.section_id;


-- =========================================================
-- Problem 21: Display student enrollment details
-- Include student, course, section and semester information.
-- =========================================================

SELECT
    e.enrollment_id,
    s.student_id,
    s.full_name AS student_name,
    c.course_code,
    c.course_title,
    cs.section_number,
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
ORDER BY s.student_id, sem.semester_id, c.course_code;


-- =========================================================
-- Problem 22: Find students who have not enrolled in any course
-- Concept: LEFT JOIN + IS NULL
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    s.email
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


-- =========================================================
-- Problem 23: Find courses that have never been offered
-- =========================================================

SELECT
    c.course_id,
    c.course_code,
    c.course_title
FROM courses AS c
LEFT JOIN course_sections AS cs
    ON c.course_id = cs.course_id
WHERE cs.section_id IS NULL;


-- =========================================================
-- Problem 24: Display students and their marks
-- Include students with no enrollment.
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    c.course_code,
    c.course_title,
    e.marks,
    e.grade
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
LEFT JOIN course_sections AS cs
    ON e.section_id = cs.section_id
LEFT JOIN courses AS c
    ON cs.course_id = c.course_id
ORDER BY s.student_id, c.course_code;


-- =========================================================
-- Problem 25: Display each student's department and courses
-- =========================================================

SELECT
    s.student_id,
    s.full_name AS student_name,
    d.department_name,
    c.course_code,
    c.course_title,
    e.marks,
    e.grade
FROM students AS s
INNER JOIN departments AS d
    ON s.department_id = d.department_id
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN course_sections AS cs
    ON e.section_id = cs.section_id
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
ORDER BY s.student_id, c.course_code;


-- =========================================================
-- Problem 26: Count students in each department
-- Include departments with zero students.
-- =========================================================

SELECT
    d.department_id,
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM departments AS d
LEFT JOIN students AS s
    ON d.department_id = s.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY total_students DESC, d.department_name;


-- =========================================================
-- Problem 27: Count students enrolled in each course section
-- Include sections with zero enrollments.
-- =========================================================

SELECT
    cs.section_id,
    c.course_code,
    c.course_title,
    cs.section_number,
    cs.capacity,
    COUNT(e.enrollment_id) AS enrolled_students
FROM course_sections AS cs
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_code,
    c.course_title,
    cs.section_number,
    cs.capacity
ORDER BY cs.section_id;


-- =========================================================
-- Problem 28: Find available seats in each section
-- =========================================================

SELECT
    cs.section_id,
    c.course_code,
    c.course_title,
    cs.section_number,
    cs.capacity,
    COUNT(e.enrollment_id) AS enrolled_students,
    cs.capacity - COUNT(e.enrollment_id) AS available_seats
FROM course_sections AS cs
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_code,
    c.course_title,
    cs.section_number,
    cs.capacity
ORDER BY cs.section_id;


-- =========================================================
-- Problem 29: Find students enrolled in CSE101
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    c.course_code,
    c.course_title,
    e.marks,
    e.grade
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
INNER JOIN course_sections AS cs
    ON e.section_id = cs.section_id
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
WHERE c.course_code = 'CSE101'
ORDER BY s.student_id;


-- =========================================================
-- Problem 30: Display course sections with semester and instructor
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    cs.section_number,
    sem.semester_name,
    sem.academic_year,
    i.full_name AS instructor_name
FROM course_sections AS cs
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
INNER JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
INNER JOIN instructors AS i
    ON cs.instructor_id = i.instructor_id
ORDER BY sem.academic_year, sem.semester_id, c.course_code;

