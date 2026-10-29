
-- =========================================================
-- Project: Student Management System
-- File: 09_advanced_queries.sql
-- DBMS: MySQL 8.0+ / Compatible MariaDB versions
-- Purpose: Advanced SQL and Real-World Problem Solving
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 111: Find the Top 3 Students by Average Marks
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    ROUND(AVG(e.marks), 2) AS average_marks,
    COUNT(e.marks) AS graded_courses
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
ORDER BY average_marks DESC, s.student_id
LIMIT 3;


-- =========================================================
-- Problem 112: Find the Top Performer in Each Course
-- Include all students tied for the highest marks.
-- =========================================================

WITH course_results AS (
    SELECT
        c.course_id,
        c.course_code,
        c.course_title,
        s.student_id,
        s.full_name,
        e.marks,
        RANK() OVER (
            PARTITION BY c.course_id
            ORDER BY e.marks DESC
        ) AS course_rank
    FROM enrollments AS e
    JOIN students AS s
        ON e.student_id = s.student_id
    JOIN course_sections AS cs
        ON e.section_id = cs.section_id
    JOIN courses AS c
        ON cs.course_id = c.course_id
    WHERE e.marks IS NOT NULL
)
SELECT
    course_code,
    course_title,
    student_id,
    full_name,
    marks
FROM course_results
WHERE course_rank = 1
ORDER BY course_code, student_id;


-- =========================================================
-- Problem 113: Find Students Performing Above Their
-- Department's Average Student Performance
-- =========================================================

WITH student_averages AS (
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
),
department_averages AS (
    SELECT
        department_id,
        AVG(average_marks) AS department_average
    FROM student_averages
    GROUP BY department_id
)
SELECT
    sa.student_id,
    sa.full_name,
    sa.department_name,
    ROUND(sa.average_marks, 2) AS average_marks,
    ROUND(da.department_average, 2) AS department_average
FROM student_averages AS sa
JOIN department_averages AS da
    ON sa.department_id = da.department_id
WHERE sa.average_marks > da.department_average
ORDER BY sa.department_name, average_marks DESC;


-- =========================================================
-- Problem 114: Find Students with Pending Results
-- Include course, semester and instructor information.
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    c.course_code,
    c.course_title,
    sem.semester_name,
    sem.academic_year,
    i.full_name AS instructor_name,
    e.enrollment_date
FROM enrollments AS e
JOIN students AS s
    ON e.student_id = s.student_id
JOIN course_sections AS cs
    ON e.section_id = cs.section_id
JOIN courses AS c
    ON cs.course_id = c.course_id
JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
JOIN instructors AS i
    ON cs.instructor_id = i.instructor_id
WHERE e.marks IS NULL
ORDER BY sem.academic_year, sem.semester_name, s.student_id;


-- =========================================================
-- Problem 115: Find Courses That Have Never Been Offered
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
)
ORDER BY c.course_code;


-- =========================================================
-- Problem 116: Find Sections That Are Full or Almost Full
-- Almost full means at least 80% occupied.
-- =========================================================

WITH section_counts AS (
    SELECT
        cs.section_id,
        c.course_code,
        c.course_title,
        cs.section_number,
        cs.capacity,
        COUNT(e.enrollment_id) AS enrolled_students
    FROM course_sections AS cs
    JOIN courses AS c
        ON cs.course_id = c.course_id
    LEFT JOIN enrollments AS e
        ON cs.section_id = e.section_id
    GROUP BY
        cs.section_id,
        c.course_code,
        c.course_title,
        cs.section_number,
        cs.capacity
)
SELECT
    section_id,
    course_code,
    course_title,
    section_number,
    capacity,
    enrolled_students,
    capacity - enrolled_students AS available_seats,
    ROUND(
        enrolled_students * 100.0 / capacity,
        2
    ) AS occupancy_percentage,
    CASE
        WHEN enrolled_students >= capacity THEN 'Full'
        ELSE 'Almost Full'
    END AS section_status
FROM section_counts
WHERE enrolled_students * 100.0 / capacity >= 80
ORDER BY occupancy_percentage DESC;


-- =========================================================
-- Problem 117: Compare Course Performance Across Semesters
-- =========================================================

SELECT
    c.course_code,
    c.course_title,
    sem.semester_name,
    sem.academic_year,
    COUNT(e.marks) AS graded_students,
    ROUND(AVG(e.marks), 2) AS average_marks,
    MAX(e.marks) AS highest_marks,
    MIN(e.marks) AS lowest_marks
FROM courses AS c
JOIN course_sections AS cs
    ON c.course_id = cs.course_id
JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
GROUP BY
    c.course_id,
    c.course_code,
    c.course_title,
    sem.semester_id,
    sem.semester_name,
    sem.academic_year
ORDER BY
    c.course_code,
    sem.academic_year,
    sem.start_date;


-- =========================================================
-- Problem 118: Find Students Enrolled in Every Offered Course
-- A course counts as offered if at least one section exists.
-- =========================================================

SELECT
    s.student_id,
    s.full_name
FROM students AS s
WHERE EXISTS (
    SELECT 1
    FROM course_sections
)
AND NOT EXISTS (
    SELECT 1
    FROM courses AS c
    WHERE EXISTS (
        SELECT 1
        FROM course_sections AS cs
        WHERE cs.course_id = c.course_id
    )
    AND NOT EXISTS (
        SELECT 1
        FROM enrollments AS e
        JOIN course_sections AS cs2
            ON e.section_id = cs2.section_id
        WHERE e.student_id = s.student_id
          AND cs2.course_id = c.course_id
    )
)
ORDER BY s.student_id;


-- =========================================================
-- Problem 119: Calculate Enrollment and Result Statistics
-- =========================================================

SELECT
    COUNT(*) AS total_enrollments,
    COUNT(marks) AS graded_enrollments,
    SUM(CASE WHEN marks IS NULL THEN 1 ELSE 0 END)
        AS pending_results,
    ROUND(AVG(marks), 2) AS overall_average_marks,
    MAX(marks) AS highest_marks,
    MIN(marks) AS lowest_marks
FROM enrollments;


-- =========================================================
-- Problem 120: Find Students with Consistently High Results
-- Require at least 2 graded courses and every graded mark >= 80.
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    COUNT(e.marks) AS graded_courses,
    ROUND(AVG(e.marks), 2) AS average_marks,
    MIN(e.marks) AS lowest_marks
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
HAVING COUNT(e.marks) >= 2
   AND MIN(e.marks) >= 80
ORDER BY average_marks DESC, s.student_id;


-- =========================================================
-- Problem 121: Identify Students Who Have Never Received
-- a Graded Result
-- =========================================================

SELECT
    s.student_id,
    s.full_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM students AS s
LEFT JOIN enrollments AS e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.full_name
HAVING COUNT(e.enrollment_id) > 0
   AND COUNT(e.marks) = 0
ORDER BY s.student_id;


-- =========================================================
-- Problem 122: Find the Average Marks Difference Between
-- Each Student and the Overall Average
-- =========================================================

WITH overall_average AS (
    SELECT AVG(marks) AS average_marks
    FROM enrollments
)
SELECT
    s.student_id,
    s.full_name,
    ROUND(AVG(e.marks), 2) AS student_average,
    ROUND(oa.average_marks, 2) AS overall_average,
    ROUND(AVG(e.marks) - oa.average_marks, 2)
        AS difference_from_overall
FROM students AS s
JOIN enrollments AS e
    ON s.student_id = e.student_id
CROSS JOIN overall_average AS oa
GROUP BY
    s.student_id,
    s.full_name,
    oa.average_marks
ORDER BY difference_from_overall DESC;


-- =========================================================
-- End of 09_advanced_queries.sql
-- =========================================================
