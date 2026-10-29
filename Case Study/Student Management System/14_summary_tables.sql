
-- =========================================================
-- Project: Student Management System
-- File: 13_summary_tables.sql
-- DBMS: MySQL / MariaDB
-- Purpose: Summary Tables and Materialized View Alternative
-- =========================================================

USE student_management_db;


-- =========================================================
-- Problem 123: Create an academic performance summary table
--
-- One row represents one course in one semester.
-- Results are aggregated across all sections of that course.
-- =========================================================

CREATE TABLE IF NOT EXISTS course_semester_summary (
    course_id INT NOT NULL,
    semester_id INT NOT NULL,
    course_code VARCHAR(20) NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    semester_name VARCHAR(50) NOT NULL,
    academic_year VARCHAR(20) NOT NULL,
    total_enrollments INT NOT NULL DEFAULT 0,
    graded_enrollments INT NOT NULL DEFAULT 0,
    average_marks DECIMAL(7,2) DEFAULT NULL,
    highest_marks DECIMAL(5,2) DEFAULT NULL,
    lowest_marks DECIMAL(5,2) DEFAULT NULL,
    refreshed_at TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (course_id, semester_id),

    CHECK (total_enrollments >= 0),
    CHECK (graded_enrollments >= 0),
    CHECK (graded_enrollments <= total_enrollments)
)
ENGINE = InnoDB;


-- =========================================================
-- Problem 124: Create a procedure to refresh the summary
--
-- DELETE + INSERT are used instead of TRUNCATE so that
-- the refresh can be rolled back on transactional tables.
-- =========================================================

DROP PROCEDURE IF EXISTS sp_refresh_course_semester_summary;

DELIMITER $$

CREATE PROCEDURE sp_refresh_course_semester_summary()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Remove the previous summary.
    DELETE FROM course_semester_summary;

    -- Rebuild the summary from the source tables.
    INSERT INTO course_semester_summary (
        course_id,
        semester_id,
        course_code,
        course_title,
        semester_name,
        academic_year,
        total_enrollments,
        graded_enrollments,
        average_marks,
        highest_marks,
        lowest_marks,
        refreshed_at
    )
    SELECT
        c.course_id,
        sem.semester_id,
        c.course_code,
        c.course_title,
        sem.semester_name,
        CAST(sem.academic_year AS CHAR),
        COUNT(e.enrollment_id),
        COUNT(e.marks),
        ROUND(AVG(e.marks), 2),
        MAX(e.marks),
        MIN(e.marks),
        CURRENT_TIMESTAMP
    FROM course_sections AS cs
    JOIN courses AS c
        ON cs.course_id = c.course_id
    JOIN semesters AS sem
        ON cs.semester_id = sem.semester_id
    LEFT JOIN enrollments AS e
        ON cs.section_id = e.section_id
    GROUP BY
        c.course_id,
        sem.semester_id,
        c.course_code,
        c.course_title,
        sem.semester_name,
        sem.academic_year;

    COMMIT;
END$$

DELIMITER ;


-- =========================================================
-- Problem 125: Populate or refresh the summary table
-- Run this after inserting or updating source data.
-- =========================================================

CALL sp_refresh_course_semester_summary();


-- =========================================================
-- Problem 126: Display all course-semester summaries
-- =========================================================

SELECT
    course_code,
    course_title,
    semester_name,
    academic_year,
    total_enrollments,
    graded_enrollments,
    average_marks,
    highest_marks,
    lowest_marks,
    refreshed_at
FROM course_semester_summary
ORDER BY
    academic_year,
    semester_name,
    course_code;


-- =========================================================
-- Problem 127: Find courses with the highest average marks
-- =========================================================

SELECT
    course_code,
    course_title,
    semester_name,
    academic_year,
    average_marks
FROM course_semester_summary
WHERE average_marks IS NOT NULL
ORDER BY average_marks DESC
LIMIT 5;


-- =========================================================
-- Problem 128: Find courses with pending results
-- =========================================================

SELECT
    course_code,
    course_title,
    semester_name,
    academic_year,
    total_enrollments,
    graded_enrollments,
    total_enrollments - graded_enrollments
        AS pending_results
FROM course_semester_summary
WHERE total_enrollments > graded_enrollments
ORDER BY pending_results DESC, course_code;


-- =========================================================
-- Problem 129: Compare summary results with source data
-- =========================================================

SELECT
    c.course_code,
    sem.semester_name,
    COUNT(e.enrollment_id) AS source_enrollments,
    COUNT(e.marks) AS source_graded_enrollments,
    ROUND(AVG(e.marks), 2) AS source_average_marks,
    summary.total_enrollments,
    summary.graded_enrollments,
    summary.average_marks
FROM course_sections AS cs
JOIN courses AS c
    ON cs.course_id = c.course_id
JOIN semesters AS sem
    ON cs.semester_id = sem.semester_id
LEFT JOIN enrollments AS e
    ON cs.section_id = e.section_id
JOIN course_semester_summary AS summary
    ON summary.course_id = c.course_id
   AND summary.semester_id = sem.semester_id
GROUP BY
    c.course_id,
    c.course_code,
    sem.semester_id,
    sem.semester_name,
    summary.total_enrollments,
    summary.graded_enrollments,
    summary.average_marks
ORDER BY c.course_code, sem.semester_name;


-- =========================================================
-- Problem 130: Inspect the summary table's index
-- =========================================================

SHOW INDEX FROM course_semester_summary;


-- =========================================================
-- Problem 131: Analyze a summary-table query
-- =========================================================

EXPLAIN
SELECT
    course_code,
    course_title,
    average_marks
FROM course_semester_summary
WHERE semester_id = 403
ORDER BY average_marks DESC;


-- =========================================================
-- Problem 132: Check the summary table's structure
-- =========================================================

DESCRIBE course_semester_summary;


-- =========================================================
-- End of 13_summary_tables.sql
-- =========================================================
