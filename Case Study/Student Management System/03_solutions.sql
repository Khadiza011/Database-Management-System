
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


-- =========================================================
-- Project: Student Management System
-- Part 3: Aggregate Functions, GROUP BY and HAVING
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 31: Count total students
-- =========================================================

SELECT
    COUNT(*) AS total_students
FROM students;


-- =========================================================
-- Problem 32: Count students in each department
-- =========================================================

SELECT
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM departments AS d
LEFT JOIN students AS s
    ON d.department_id = s.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY total_students DESC;


-- =========================================================
-- Problem 33: Calculate average marks for each course
-- Ignore NULL marks.
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    ROUND(AVG(e.marks), 2) AS average_marks
FROM courses AS c
INNER JOIN course_sections AS cs
    ON c.course_id = cs.course_id
INNER JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_title
ORDER BY average_marks DESC;


-- =========================================================
-- Problem 34: Find the highest and lowest marks in each course
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    MAX(e.marks) AS highest_marks,
    MIN(e.marks) AS lowest_marks
FROM courses AS c
INNER JOIN course_sections AS cs
    ON c.course_id = cs.course_id
INNER JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_title
ORDER BY c.course_code;


-- =========================================================
-- Problem 35: Calculate average marks for each student
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    ROUND(AVG(e.marks), 2) AS average_marks,
    COUNT(e.marks) AS graded_courses
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
ORDER BY average_marks DESC;


-- =========================================================
-- Problem 36: Calculate total enrollment per course
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    COUNT(e.enrollment_id) AS total_enrollments
FROM courses AS c
LEFT JOIN course_sections AS cs
    ON c.course_id = cs.course_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_title
ORDER BY total_enrollments DESC;


-- =========================================================
-- Problem 37: Find courses with more than 2 enrollments
-- Concept: GROUP BY + HAVING
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    COUNT(e.enrollment_id) AS total_enrollments
FROM courses AS c
INNER JOIN course_sections AS cs
    ON c.course_id = cs.course_id
INNER JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_title
HAVING COUNT(e.enrollment_id) > 2
ORDER BY total_enrollments DESC;


-- =========================================================
-- Problem 38: Find students whose average marks exceed 80
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    ROUND(AVG(e.marks), 2) AS average_marks
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
HAVING AVG(e.marks) > 80
ORDER BY average_marks DESC;


-- =========================================================
-- Problem 39: Count students in each department
-- Return departments with at least 2 students.
-- =========================================================

SELECT
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM departments AS d
LEFT JOIN students AS s
    ON d.department_id = s.department_id
GROUP BY
    d.department_id,
    d.department_name
HAVING COUNT(s.student_id) >= 2
ORDER BY total_students DESC;


-- =========================================================
-- Problem 40: Calculate total graded marks per student
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    SUM(e.marks) AS total_marks,
    COUNT(e.marks) AS graded_courses
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
ORDER BY total_marks DESC;


-- =========================================================
-- Problem 41: Count completed and pending results
-- =========================================================

SELECT
    COUNT(*) AS total_enrollments,
    COUNT(marks) AS graded_enrollments,
    COUNT(*) - COUNT(marks) AS pending_results
FROM enrollments;


-- =========================================================
-- Problem 42: Find course sections with average marks >= 85
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    cs.section_number,
    ROUND(AVG(e.marks), 2) AS average_marks,
    COUNT(e.marks) AS graded_students
FROM course_sections AS cs
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
INNER JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_code,
    c.course_title,
    cs.section_number
HAVING AVG(e.marks) >= 85
ORDER BY average_marks DESC;


-- =========================================================
-- Problem 43: Find the course with the highest average marks
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    ROUND(AVG(e.marks), 2) AS average_marks
FROM courses AS c
INNER JOIN course_sections AS cs
    ON c.course_id = cs.course_id
INNER JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_title
ORDER BY average_marks DESC
LIMIT 1;


-- =========================================================
-- Problem 44: Calculate section occupancy percentage
-- =========================================================

SELECT
    cs.section_id,
    c.course_code,
    cs.section_number,
    cs.capacity,
    COUNT(e.enrollment_id) AS enrolled_students,
    ROUND(
        COUNT(e.enrollment_id) * 100.0 / cs.capacity,
        2
    ) AS occupancy_percentage
FROM course_sections AS cs
INNER JOIN courses AS c
    ON cs.course_id = c.course_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_code,
    cs.section_number,
    cs.capacity
ORDER BY occupancy_percentage DESC;


-- =========================================================
-- Problem 45: Find students with at least 2 graded courses
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    COUNT(e.marks) AS graded_courses,
    ROUND(AVG(e.marks), 2) AS average_marks
FROM students AS s
INNER JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
HAVING COUNT(e.marks) >= 2
ORDER BY average_marks DESC;



-- =========================================================
-- Project: Student Management System
-- Part 4: Subqueries and Nested Queries
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 46: Find students who scored above the overall
-- average marks across all graded enrollments.
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    c.course_code,
    e.marks
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
WHERE e.marks > (
    SELECT AVG(marks)
    FROM enrollments
)
ORDER BY e.marks DESC;


-- =========================================================
-- Problem 47: Find students who have marks above the
-- average marks of their own enrolled courses.
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    e.marks
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
WHERE e.marks > (
    SELECT AVG(e2.marks)
    FROM enrollments AS e2
    WHERE e2.student_id = e.student_id
)
ORDER BY s.student_id, e.marks DESC;


-- =========================================================
-- Problem 48: Find the student(s) with the highest marks
-- in the entire database.
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    c.course_code,
    e.marks
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
WHERE e.marks = (
    SELECT MAX(marks)
    FROM enrollments
)
ORDER BY s.student_id;


-- =========================================================
-- Problem 49: Find courses whose average marks are
-- greater than the overall average marks.
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    ROUND(AVG(e.marks), 2) AS average_marks
FROM courses AS c
JOIN course_sections AS cs
    ON c.course_id = cs.course_id
JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_title
HAVING AVG(e.marks) > (
    SELECT AVG(marks)
    FROM enrollments
)
ORDER BY average_marks DESC;


-- =========================================================
-- Problem 50: Find departments that have at least
-- one student.
-- Concept: IN + Subquery
-- =========================================================

SELECT
    department_id,
    department_name
FROM departments
WHERE department_id IN (
    SELECT DISTINCT department_id
    FROM students
)
ORDER BY department_name;


-- =========================================================
-- Problem 51: Find students who have not enrolled
-- in any course.
-- Concept: NOT EXISTS
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    s.email
FROM students AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments AS e
    WHERE e.student_id = s.student_id
);


-- =========================================================
-- Problem 52: Find courses that have never been offered.
-- Concept: NOT EXISTS
-- =========================================================

SELECT
    c.course_id,
    c.course_code,
    c.course_title
FROM courses AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM course_sections AS cs
    WHERE cs.course_id = c.course_id
);


-- =========================================================
-- Problem 53: Find students who have at least one
-- graded result of 90 or above.
-- Concept: EXISTS
-- =========================================================

SELECT
    s.student_id,
    s.full_name
FROM students AS s
WHERE EXISTS (
    SELECT 1
    FROM enrollments AS e
    WHERE e.student_id = s.student_id
      AND e.marks >= 90
)
ORDER BY s.student_id;


-- =========================================================
-- Problem 54: Find the highest scorer in each course.
-- Return all students tied for the highest marks.
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    s.student_id,
    s.full_name,
    e.marks
FROM enrollments AS e
JOIN students AS s
    ON e.student_id = s.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
WHERE e.marks = (
    SELECT MAX(e2.marks)
    FROM enrollments AS e2
    JOIN course_sections AS cs2
        ON e2.section_id = cs2.section_id
    WHERE cs2.course_id = c.course_id
)
ORDER BY c.course_code, s.student_id;


-- =========================================================
-- Problem 55: Find students who are enrolled in
-- the Database Management Systems course.
-- Concept: IN + multiple-table subquery
-- =========================================================

SELECT
    student_id,
    full_name,
    email
FROM students
WHERE student_id IN (
    SELECT e.student_id
    FROM enrollments AS e
    JOIN course_sections AS cs
        ON e.section_id = cs.section_id
    JOIN courses AS c
        ON cs.course_id = c.course_id
    WHERE c.course_code = 'CSE102'
)
ORDER BY student_id;


-- =========================================================
-- Problem 56: Find sections whose enrollment count
-- exceeds the average enrollment count across all sections.
-- =========================================================

SELECT
    cs.section_id,
    c.course_code,
    cs.section_number,
    COUNT(e.enrollment_id) AS enrolled_students
FROM course_sections AS cs
JOIN courses AS c
    ON cs.course_id = c.course_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_code,
    cs.section_number
HAVING COUNT(e.enrollment_id) > (
    SELECT AVG(section_enrollment)
    FROM (
        SELECT
            cs2.section_id,
            COUNT(e2.enrollment_id) AS section_enrollment
        FROM course_sections AS cs2
        LEFT JOIN enrollments AS e2
            ON cs2.section_id = e2.section_id
        GROUP BY cs2.section_id
    ) AS section_counts
)
ORDER BY enrolled_students DESC;


-- =========================================================
-- Problem 57: Find students whose average marks are
-- above the overall average marks.
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    ROUND(AVG(e.marks), 2) AS average_marks
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
HAVING AVG(e.marks) > (
    SELECT AVG(marks)
    FROM enrollments
)
ORDER BY average_marks DESC;


-- =========================================================
-- Problem 58: Find departments with more students than
-- the average number of students per department.
-- Include departments with zero students in the average.
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
HAVING COUNT(s.student_id) > (
    SELECT AVG(department_student_count)
    FROM (
        SELECT
            d2.department_id,
            COUNT(s2.student_id) AS department_student_count
        FROM departments AS d2
        LEFT JOIN students AS s2
            ON d2.department_id = s2.department_id
        GROUP BY d2.department_id
    ) AS department_counts
)
ORDER BY total_students DESC;


-- =========================================================
-- Project: Student Management System
-- Part 5: CASE, Conditional Expressions and Date Functions
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 59: Classify students' marks into performance bands
-- Practice scale only; not an official university grading policy.
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    c.course_code,
    e.marks,
    CASE
        WHEN e.marks IS NULL THEN 'Result Pending'
        WHEN e.marks >= 90 THEN 'Excellent'
        WHEN e.marks >= 80 THEN 'Very Good'
        WHEN e.marks >= 70 THEN 'Good'
        WHEN e.marks >= 60 THEN 'Satisfactory'
        WHEN e.marks >= 40 THEN 'Pass'
        ELSE 'Fail'
    END AS performance_status
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
ORDER BY s.student_id, c.course_code;


-- =========================================================
-- Problem 60: Display result status for every enrollment
-- =========================================================

SELECT
    enrollment_id,
    student_id,
    section_id,
    marks,
    CASE
        WHEN marks IS NULL THEN 'Pending'
        WHEN marks >= 40 THEN 'Completed - Pass'
        ELSE 'Completed - Fail'
    END AS result_status
FROM enrollments
ORDER BY enrollment_id;


-- =========================================================
-- Problem 61: Count passed, failed and pending results
-- Uses 40 as an illustrative passing threshold.
-- =========================================================

SELECT
    COUNT(*) AS total_enrollments,
    SUM(CASE WHEN marks >= 40 THEN 1 ELSE 0 END)
        AS passed_results,
    SUM(CASE WHEN marks < 40 THEN 1 ELSE 0 END)
        AS failed_results,
    SUM(CASE WHEN marks IS NULL THEN 1 ELSE 0 END)
        AS pending_results
FROM enrollments;


-- =========================================================
-- Problem 62: Show each student's marks with a pass/fail label
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    c.course_code,
    e.marks,
    CASE
        WHEN e.marks IS NULL THEN 'Pending'
        WHEN e.marks >= 40 THEN 'Pass'
        ELSE 'Fail'
    END AS result
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
ORDER BY s.student_id, c.course_code;


-- =========================================================
-- Problem 63: Find students admitted in each calendar year
-- =========================================================

SELECT
    YEAR(admission_date) AS admission_year,
    COUNT(*) AS total_students
FROM students
GROUP BY YEAR(admission_date)
ORDER BY admission_year;


-- =========================================================
-- Problem 64: Display enrollment dates in a readable format
-- =========================================================

SELECT
    enrollment_id,
    student_id,
    DATE_FORMAT(enrollment_date, '%d %M %Y')
        AS formatted_enrollment_date
FROM enrollments
ORDER BY enrollment_date;


-- =========================================================
-- Problem 65: Calculate semester duration in days
-- DATEDIFF returns end_date minus start_date.
-- =========================================================

SELECT
    semester_id,
    semester_name,
    academic_year,
    start_date,
    end_date,
    DATEDIFF(end_date, start_date) AS duration_days
FROM semesters
ORDER BY start_date;


-- =========================================================
-- Problem 66: Find enrollments made in 2025
-- =========================================================

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
-- Problem 67: Find courses offered in Fall 2025
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    cs.section_number,
    sem.semester_name,
    sem.academic_year
FROM courses AS c
JOIN course_sections AS cs
    ON c.course_id = cs.course_id
JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
WHERE sem.semester_name = 'Fall'
  AND sem.academic_year = 2025
ORDER BY c.course_code;


-- =========================================================
-- Problem 68: Count enrollments by enrollment month
-- =========================================================

SELECT
    YEAR(enrollment_date) AS enrollment_year,
    MONTH(enrollment_date) AS enrollment_month,
    COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY
    YEAR(enrollment_date),
    MONTH(enrollment_date)
ORDER BY enrollment_year, enrollment_month;


-- =========================================================
-- Problem 69: Display semester status relative to today
-- =========================================================

SELECT
    semester_id,
    semester_name,
    academic_year,
    start_date,
    end_date,
    CASE
        WHEN CURDATE() < start_date THEN 'Upcoming'
        WHEN CURDATE() > end_date THEN 'Completed'
        ELSE 'In Progress'
    END AS semester_status
FROM semesters
ORDER BY start_date;


-- =========================================================
-- Problem 70: Show student age in completed years
-- =========================================================

SELECT
    student_id,
    full_name,
    date_of_birth,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())
        AS age_years
FROM students
WHERE date_of_birth IS NOT NULL
ORDER BY age_years DESC;


-- =========================================================
-- Problem 71: Count enrollments with and without marks
-- =========================================================

SELECT
    COUNT(*) AS total_enrollments,
    SUM(CASE WHEN marks IS NOT NULL THEN 1 ELSE 0 END)
        AS results_available,
    SUM(CASE WHEN marks IS NULL THEN 1 ELSE 0 END)
        AS results_pending
FROM enrollments;


-- =========================================================
-- Problem 72: Show a student's course load and result status
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    COUNT(e.enrollment_id) AS total_enrollments,
    COUNT(e.marks) AS graded_courses,
    SUM(CASE WHEN e.marks IS NULL THEN 1 ELSE 0 END)
        AS pending_results
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
ORDER BY s.student_id;


-- =========================================================
-- Project: Student Management System
-- Part 6: Window Functions and Ranking
-- Database: student_management_db
-- DBMS: MySQL 8.0+ / MariaDB versions supporting window functions
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 73: Rank students by their average marks
-- RANK() assigns the same rank to tied students.
-- =========================================================

SELECT
    student_id,
    full_name,
    average_marks,
    RANK() OVER (
        ORDER BY average_marks DESC
    ) AS student_rank
FROM (
    SELECT
        s.student_id,
        s.full_name,
        AVG(e.marks) AS average_marks
    FROM students AS s
    JOIN enrollments AS e
        ON s.student_id = e.student_id
    GROUP BY
        s.student_id,
        s.full_name
) AS student_averages
ORDER BY student_rank, student_id;


-- =========================================================
-- Problem 74: Rank students within each department
-- =========================================================

SELECT
    student_id,
    full_name,
    department_name,
    average_marks,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY average_marks DESC
    ) AS department_rank
FROM (
    SELECT
        s.student_id,
        s.full_name,
        d.department_id,
        d.department_name,
        AVG(e.marks) AS average_marks
    FROM students AS s
    JOIN departments AS d
        ON s.department_id = d.department_id
    JOIN enrollments AS e
        ON s.student_id = e.student_id
    GROUP BY
        s.student_id,
        s.full_name,
        d.department_id,
        d.department_name
) AS department_averages
ORDER BY department_name, department_rank, student_id;


-- =========================================================
-- Problem 75: Find the top 2 students in each department
-- Ties are included when their RANK() is within the top 2.
-- =========================================================

SELECT
    student_id,
    full_name,
    department_name,
    average_marks,
    department_rank
FROM (
    SELECT
        student_id,
        full_name,
        department_name,
        average_marks,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY average_marks DESC
        ) AS department_rank
    FROM (
        SELECT
            s.student_id,
            s.full_name,
            d.department_id,
            d.department_name,
            AVG(e.marks) AS average_marks
        FROM students AS s
        JOIN departments AS d
            ON s.department_id = d.department_id
        JOIN enrollments AS e
            ON s.student_id = e.student_id
        GROUP BY
            s.student_id,
            s.full_name,
            d.department_id,
            d.department_name
    ) AS student_averages
) AS ranked_students
WHERE department_rank <= 2
ORDER BY department_name, department_rank, student_id;


-- =========================================================
-- Problem 76: Compare RANK(), DENSE_RANK(), and ROW_NUMBER()
-- =========================================================

SELECT
    student_id,
    full_name,
    average_marks,
    RANK() OVER (
        ORDER BY average_marks DESC
    ) AS rank_position,
    DENSE_RANK() OVER (
        ORDER BY average_marks DESC
    ) AS dense_rank_position,
    ROW_NUMBER() OVER (
        ORDER BY average_marks DESC, student_id
    ) AS row_number_position
FROM (
    SELECT
        s.student_id,
        s.full_name,
        AVG(e.marks) AS average_marks
    FROM students AS s
    JOIN enrollments AS e
        ON s.student_id = e.student_id
    GROUP BY
        s.student_id,
        s.full_name
) AS student_averages
ORDER BY row_number_position;


-- =========================================================
-- Problem 77: Show each student's marks and the average
-- marks for the same course section.
-- =========================================================

SELECT
    c.course_code,
    cs.section_number,
    s.student_id,
    s.full_name,
    e.marks,
    ROUND(
        AVG(e.marks) OVER (
            PARTITION BY cs.section_id
        ),
        2
    ) AS section_average
FROM enrollments AS e
JOIN students AS s
    ON e.student_id = s.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
ORDER BY cs.section_id, e.marks DESC;


-- =========================================================
-- Problem 78: Calculate each student's percentage
-- contribution to total graded marks in their section.
-- =========================================================

SELECT
    c.course_code,
    cs.section_number,
    s.student_id,
    s.full_name,
    e.marks,
    ROUND(
        100.0 * e.marks /
        NULLIF(
            SUM(e.marks) OVER (
                PARTITION BY cs.section_id
            ),
            0
        ),
        2
    ) AS percentage_of_section_marks
FROM enrollments AS e
JOIN students AS s
    ON e.student_id = s.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
WHERE e.marks IS NOT NULL
ORDER BY cs.section_id, e.marks DESC;


-- =========================================================
-- Problem 79: Show previous and next marks within a section
-- LAG() and LEAD() follow marks-descending order.
-- =========================================================

SELECT
    c.course_code,
    cs.section_number,
    s.student_id,
    s.full_name,
    e.marks,
    LAG(e.marks) OVER (
        PARTITION BY cs.section_id
        ORDER BY e.marks DESC, s.student_id
    ) AS previous_marks,
    LEAD(e.marks) OVER (
        PARTITION BY cs.section_id
        ORDER BY e.marks DESC, s.student_id
    ) AS next_marks
FROM enrollments AS e
JOIN students AS s
    ON e.student_id = s.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
WHERE e.marks IS NOT NULL
ORDER BY cs.section_id, e.marks DESC, s.student_id;


-- =========================================================
-- Problem 80: Calculate cumulative enrollment count
-- within each semester by enrollment date.
-- =========================================================

SELECT
    sem.semester_name,
    sem.academic_year,
    e.enrollment_date,
    e.enrollment_id,
    COUNT(*) OVER (
        PARTITION BY sem.semester_id
        ORDER BY e.enrollment_date, e.enrollment_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_enrollments
FROM enrollments AS e
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
ORDER BY
    sem.semester_id,
    e.enrollment_date,
    e.enrollment_id;


-- =========================================================
-- Problem 81: Find the highest-scoring student in each section
-- ROW_NUMBER() returns exactly one student per section.
-- Ties are resolved by the lower student_id.
-- =========================================================

SELECT
    section_id,
    course_code,
    section_number,
    student_id,
    full_name,
    marks
FROM (
    SELECT
        cs.section_id,
        c.course_code,
        cs.section_number,
        s.student_id,
        s.full_name,
        e.marks,
        ROW_NUMBER() OVER (
            PARTITION BY cs.section_id
            ORDER BY e.marks DESC, s.student_id
        ) AS section_position
    FROM enrollments AS e
    JOIN students AS s
        ON e.student_id = s.student_id
    JOIN course_sections AS cs
        ON e.section_id = cs.section_id
    JOIN courses AS c
        ON cs.course_id = c.course_id
    WHERE e.marks IS NOT NULL
) AS ranked_section_students
WHERE section_position = 1
ORDER BY section_id;


-- =========================================================
-- Problem 82: Compare each student's average marks with
-- their department's average student performance.
-- =========================================================

SELECT
    student_id,
    full_name,
    department_name,
    average_marks,
    ROUND(department_average, 2) AS department_average,
    ROUND(
        average_marks - department_average,
        2
    ) AS difference_from_department_average
FROM (
    SELECT
        student_id,
        full_name,
        department_id,
        department_name,
        average_marks,
        AVG(average_marks) OVER (
            PARTITION BY department_id
        ) AS department_average
    FROM (
        SELECT
            s.student_id,
            s.full_name,
            d.department_id,
            d.department_name,
            AVG(e.marks) AS average_marks
        FROM students AS s
        JOIN departments AS d
            ON s.department_id = d.department_id
        JOIN enrollments AS e
            ON s.student_id = e.student_id
        GROUP BY
            s.student_id,
            s.full_name,
            d.department_id,
            d.department_name
    ) AS student_averages
) AS department_comparison
ORDER BY
    department_name,
    average_marks DESC;
