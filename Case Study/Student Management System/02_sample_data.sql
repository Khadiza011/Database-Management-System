
-- =========================================================
-- Project: Student Management System
-- File: sample_data.sql
-- Database: student_management_db
-- DBMS: MySQL / MariaDB
-- Purpose: Insert realistic sample data
-- =========================================================

USE student_management_db;

START TRANSACTION;

-- =========================================================
-- 1. Departments
-- =========================================================

INSERT INTO departments
    (department_id, department_name, office_location)
VALUES
    (1, 'Computer Science and Engineering', 'Building A'),
    (2, 'Electrical and Electronic Engineering', 'Building B'),
    (3, 'Business Administration', 'Building C'),
    (4, 'English', 'Building D');


-- =========================================================
-- 2. Students
-- =========================================================

INSERT INTO students
    (student_id, department_id, full_name, email,
     date_of_birth, admission_date)
VALUES
    (1001, 1, 'Rahim Ahmed', 'rahim@example.com',
     '2004-02-15', '2023-01-10'),

    (1002, 1, 'Karim Hasan', 'karim@example.com',
     '2003-08-20', '2023-01-10'),

    (1003, 2, 'Nusrat Jahan', 'nusrat@example.com',
     '2004-05-12', '2023-01-12'),

    (1004, 3, 'Sadia Islam', 'sadia@example.com',
     '2003-11-25', '2023-01-15'),

    (1005, 1, 'Tanvir Hossain', 'tanvir@example.com',
     '2004-07-08', '2024-01-10'),

    (1006, 4, 'Ayesha Rahman', 'ayesha@example.com',
     '2003-04-18', '2024-01-12'),

    (1007, 2, 'Fahim Chowdhury', 'fahim@example.com',
     '2004-09-03', '2024-01-15'),

    (1008, 3, 'Maliha Akter', 'maliha@example.com',
     '2003-12-14', '2024-01-15');


-- =========================================================
-- 3. Instructors
-- =========================================================

INSERT INTO instructors
    (instructor_id, department_id, full_name, email)
VALUES
    (201, 1, 'Dr. Anis Rahman', 'anis@example.com'),
    (202, 1, 'Ms. Farzana Islam', 'farzana@example.com'),
    (203, 2, 'Dr. Mahmud Hasan', 'mahmud@example.com'),
    (204, 3, 'Mr. Kamal Hossain', 'kamal@example.com'),
    (205, 4, 'Ms. Samira Akter', 'samira@example.com');


-- =========================================================
-- 4. Courses
-- =========================================================

INSERT INTO courses
    (course_id, course_code, course_title, credit_hours)
VALUES
    (301, 'CSE101', 'Introduction to Programming', 3.0),
    (302, 'CSE102', 'Database Management Systems', 3.0),
    (303, 'CSE103', 'Data Structures', 3.0),
    (304, 'EEE101', 'Basic Electrical Engineering', 3.0),
    (305, 'BBA101', 'Principles of Management', 3.0),
    (306, 'ENG101', 'English Communication', 2.0);


-- =========================================================
-- 5. Semesters
-- =========================================================

INSERT INTO semesters
    (semester_id, semester_name, academic_year,
     start_date, end_date)
VALUES
    (401, 'Spring', 2025, '2025-01-10', '2025-05-15'),
    (402, 'Summer', 2025, '2025-06-01', '2025-09-15'),
    (403, 'Fall',   2025, '2025-10-01', '2026-01-15');


-- =========================================================
-- 6. Course Sections
-- =========================================================

INSERT INTO course_sections
    (section_id, course_id, semester_id, instructor_id,
     section_number, capacity)
VALUES
    (501, 301, 401, 201, 'A', 40),
    (502, 302, 401, 202, 'A', 35),
    (503, 303, 402, 201, 'A', 40),
    (504, 304, 401, 203, 'A', 35),
    (505, 305, 402, 204, 'A', 40),
    (506, 306, 403, 205, 'A', 30),
    (507, 302, 403, 202, 'A', 35),
    (508, 301, 402, 201, 'B', 40);


-- =========================================================
-- 7. Enrollments
-- Marks and grades are initially NULL for pending results.
-- =========================================================

INSERT INTO enrollments
    (enrollment_id, student_id, section_id,
     enrollment_date, marks, grade)
VALUES
    (1, 1001, 501, '2025-01-12', 88.00, 'A'),
    (2, 1001, 502, '2025-01-12', 92.00, 'A+'),
    (3, 1002, 501, '2025-01-13', 76.00, 'B+'),
    (4, 1002, 502, '2025-01-13', 81.00, 'A-'),
    (5, 1003, 504, '2025-01-14', 85.00, 'A'),
    (6, 1003, 501, '2025-01-14', 90.00, 'A+'),
    (7, 1004, 505, '2025-06-05', 79.00, 'B+'),
    (8, 1005, 503, '2025-06-03', 94.00, 'A+'),
    (9, 1005, 508, '2025-06-03', 87.00, 'A'),
    (10, 1006, 506, '2025-10-05', 91.00, 'A+'),
    (11, 1007, 504, '2025-01-15', 68.00, 'B-'),
    (12, 1008, 505, '2025-06-06', 86.00, 'A'),
    (13, 1001, 507, '2025-10-05', NULL, NULL),
    (14, 1002, 507, '2025-10-06', NULL, NULL);

COMMIT;


-- =========================================================
-- 8. Verify Inserted Data
-- =========================================================

SELECT * FROM departments;
SELECT * FROM students;
SELECT * FROM instructors;
SELECT * FROM courses;
SELECT * FROM semesters;
SELECT * FROM course_sections;
SELECT * FROM enrollments;
