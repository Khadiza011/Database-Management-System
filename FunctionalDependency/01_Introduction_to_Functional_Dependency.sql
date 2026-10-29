
-- =====================================================
-- Topic: Introduction to Functional Dependency
-- File: 01_Introduction_to_Functional_Dependency.sql
-- Database: fd_practice_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Create and select a new database
CREATE DATABASE IF NOT EXISTS fd_practice_db;
USE fd_practice_db;

-- 2. Create a students table
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    department VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

-- 3. Create a courses table
CREATE TABLE IF NOT EXISTS courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credit INT NOT NULL
) ENGINE = InnoDB;

-- 4. Create an enrollments table
CREATE TABLE IF NOT EXISTS enrollments (
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id)
        REFERENCES students(student_id),
    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
) ENGINE = InnoDB;

-- 5. Insert sample students
INSERT INTO students
    (student_id, student_name, email, department)
VALUES
    (101, 'Rahim Ahmed', 'rahim@example.com', 'CSE'),
    (102, 'Karim Hasan', 'karim@example.com', 'BBA'),
    (103, 'Nusrat Jahan', 'nusrat@example.com', 'CSE'),
    (104, 'Sadia Islam', 'sadia@example.com', 'EEE')
ON DUPLICATE KEY UPDATE
    student_name = VALUES(student_name),
    email = VALUES(email),
    department = VALUES(department);

-- 6. Insert sample courses
INSERT INTO courses
    (course_id, course_name, credit)
VALUES
    (201, 'Database Management Systems', 3),
    (202, 'Data Structures', 3),
    (203, 'Computer Networks', 3)
ON DUPLICATE KEY UPDATE
    course_name = VALUES(course_name),
    credit = VALUES(credit);

-- 7. Insert sample enrollments
INSERT INTO enrollments
    (student_id, course_id, grade)
VALUES
    (101, 201, 'A'),
    (101, 202, 'B'),
    (102, 201, 'A'),
    (103, 203, 'A'),
    (104, 202, 'B')
ON DUPLICATE KEY UPDATE
    grade = VALUES(grade);

-- 8. Display all students
SELECT * FROM students;

-- 9. Display all courses
SELECT * FROM courses;

-- 10. Display all enrollments
SELECT * FROM enrollments;

-- 11. Demonstrate student_id determines student_name
SELECT
    student_id,
    student_name
FROM students
ORDER BY student_id;

-- 12. Demonstrate course_id determines course_name
SELECT
    course_id,
    course_name
FROM courses
ORDER BY course_id;

-- 13. Demonstrate the composite key in enrollments
SELECT
    student_id,
    course_id,
    grade
FROM enrollments
ORDER BY student_id, course_id;

-- 14. Display enrollment details with student and course names
SELECT
    e.student_id,
    s.student_name,
    e.course_id,
    c.course_name,
    e.grade
FROM enrollments AS e
INNER JOIN students AS s
    ON e.student_id = s.student_id
INNER JOIN courses AS c
    ON e.course_id = c.course_id
ORDER BY e.student_id, e.course_id;
