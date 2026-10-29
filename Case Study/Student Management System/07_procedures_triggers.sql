
-- =========================================================
-- Project: Student Management System
-- File: procedures_triggers.sql
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- Purpose: Triggers, auditing and stored procedures
-- =========================================================

USE student_management_db;


-- =========================================================
-- PART A: RESULT VALIDATION AND AUTOMATIC GRADING
-- Illustrative grading scale for this project.
-- Replace it with the university's official policy if known.
-- =========================================================

DELIMITER $$

-- ---------------------------------------------------------
-- Trigger 1: Automatically assign grade before inserting
-- an enrollment or result.
-- ---------------------------------------------------------

CREATE TRIGGER trg_enrollments_before_insert
BEFORE INSERT ON enrollments
FOR EACH ROW
BEGIN
    IF NEW.marks IS NULL THEN
        SET NEW.grade = NULL;

    ELSEIF NEW.marks >= 90 THEN
        SET NEW.grade = 'A+';

    ELSEIF NEW.marks >= 85 THEN
        SET NEW.grade = 'A';

    ELSEIF NEW.marks >= 80 THEN
        SET NEW.grade = 'A-';

    ELSEIF NEW.marks >= 75 THEN
        SET NEW.grade = 'B+';

    ELSEIF NEW.marks >= 70 THEN
        SET NEW.grade = 'B';

    ELSEIF NEW.marks >= 65 THEN
        SET NEW.grade = 'B-';

    ELSEIF NEW.marks >= 60 THEN
        SET NEW.grade = 'C+';

    ELSEIF NEW.marks >= 55 THEN
        SET NEW.grade = 'C';

    ELSEIF NEW.marks >= 50 THEN
        SET NEW.grade = 'C-';

    ELSEIF NEW.marks >= 45 THEN
        SET NEW.grade = 'D';

    ELSE
        SET NEW.grade = 'F';
    END IF;
END$$


-- ---------------------------------------------------------
-- Trigger 2: Automatically recalculate grade when marks
-- are inserted or updated.
-- ---------------------------------------------------------

CREATE TRIGGER trg_enrollments_before_update
BEFORE UPDATE ON enrollments
FOR EACH ROW
BEGIN
    IF NEW.marks IS NULL THEN
        SET NEW.grade = NULL;

    ELSEIF NEW.marks >= 90 THEN
        SET NEW.grade = 'A+';

    ELSEIF NEW.marks >= 85 THEN
        SET NEW.grade = 'A';

    ELSEIF NEW.marks >= 80 THEN
        SET NEW.grade = 'A-';

    ELSEIF NEW.marks >= 75 THEN
        SET NEW.grade = 'B+';

    ELSEIF NEW.marks >= 70 THEN
        SET NEW.grade = 'B';

    ELSEIF NEW.marks >= 65 THEN
        SET NEW.grade = 'B-';

    ELSEIF NEW.marks >= 60 THEN
        SET NEW.grade = 'C+';

    ELSEIF NEW.marks >= 55 THEN
        SET NEW.grade = 'C';

    ELSEIF NEW.marks >= 50 THEN
        SET NEW.grade = 'C-';

    ELSEIF NEW.marks >= 45 THEN
        SET NEW.grade = 'D';

    ELSE
        SET NEW.grade = 'F';
    END IF;
END$$

DELIMITER ;


-- =========================================================
-- PART B: AUDIT LOG
-- Store the previous and updated marks when they change.
-- =========================================================

CREATE TABLE IF NOT EXISTS enrollment_audit (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    old_marks DECIMAL(5,2),
    new_marks DECIMAL(5,2),
    old_grade VARCHAR(2),
    new_grade VARCHAR(2),
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    action_type VARCHAR(20) NOT NULL
);


DELIMITER $$

-- ---------------------------------------------------------
-- Trigger 3: Record changes to marks or grade.
-- ---------------------------------------------------------

CREATE TRIGGER trg_enrollments_after_update
AFTER UPDATE ON enrollments
FOR EACH ROW
BEGIN
    IF NOT (OLD.marks <=> NEW.marks)
       OR NOT (OLD.grade <=> NEW.grade) THEN

        INSERT INTO enrollment_audit (
            enrollment_id,
            old_marks,
            new_marks,
            old_grade,
            new_grade,
            action_type
        )
        VALUES (
            NEW.enrollment_id,
            OLD.marks,
            NEW.marks,
            OLD.grade,
            NEW.grade,
            'UPDATE'
        );

    END IF;
END$$

DELIMITER ;


-- =========================================================
-- PART C: STORED PROCEDURE
-- Enroll a student in a section safely.
-- Call this procedure outside an existing transaction.
-- =========================================================

DELIMITER $$

CREATE PROCEDURE sp_enroll_student(
    IN p_student_id INT,
    IN p_section_id INT
)
BEGIN
    DECLARE v_capacity INT DEFAULT NULL;
    DECLARE v_enrolled INT DEFAULT 0;
    DECLARE v_student_exists INT DEFAULT 0;
    DECLARE v_duplicate INT DEFAULT 0;

    -- Roll back if any SQL statement fails.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Verify that the student exists.
    SELECT COUNT(*)
    INTO v_student_exists
    FROM students
    WHERE student_id = p_student_id;

    IF v_student_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Student does not exist';
    END IF;

    -- Lock the section row while checking capacity.
    SELECT capacity
    INTO v_capacity
    FROM course_sections
    WHERE section_id = p_section_id
    FOR UPDATE;

    IF v_capacity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Course section does not exist';
    END IF;

    -- Prevent duplicate enrollment.
    SELECT COUNT(*)
    INTO v_duplicate
    FROM enrollments
    WHERE student_id = p_student_id
      AND section_id = p_section_id;

    IF v_duplicate > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Student is already enrolled';
    END IF;

    -- Check current section capacity.
    SELECT COUNT(*)
    INTO v_enrolled
    FROM enrollments
    WHERE section_id = p_section_id;

    IF v_enrolled >= v_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Course section is full';
    END IF;

    -- Create the enrollment.
    INSERT INTO enrollments (
        student_id,
        section_id,
        enrollment_date,
        marks,
        grade
    )
    VALUES (
        p_student_id,
        p_section_id,
        CURDATE(),
        NULL,
        NULL
    );

    COMMIT;

    SELECT
        'Enrollment successful' AS message,
        p_student_id AS student_id,
        p_section_id AS section_id;
END$$

DELIMITER ;


-- =========================================================
-- PART D: TEST QUERIES
-- =========================================================

-- 1. Inspect trigger definitions.
SHOW TRIGGERS;

-- 2. Inspect the stored procedure.
SHOW CREATE PROCEDURE sp_enroll_student;

-- 3. Check current enrollment results.
SELECT
    enrollment_id,
    student_id,
    section_id,
    marks,
    grade
FROM enrollments
ORDER BY enrollment_id;

-- 4. Inspect the audit history.
SELECT *
FROM enrollment_audit
ORDER BY audit_id;

-- 5. Test automatic grade calculation.
-- This intentionally changes enrollment 1.
-- Its grade will be recalculated and the change audited.
-- Run only when you want to test the trigger.

-- UPDATE enrollments
-- SET marks = 94.00
-- WHERE enrollment_id = 1;

-- 6. Test stored procedure.
-- Choose a student-section pair that is not already enrolled.
-- Example: student 1008 in section 501.
-- Run only once unless the enrollment is removed appropriately.

-- CALL sp_enroll_student(1008, 501);
