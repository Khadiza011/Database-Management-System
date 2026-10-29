
-- =========================================================
-- Project: Student Management System
-- File: schema.sql
-- DBMS: MySQL / MariaDB
-- Purpose: Create and configure the database schema
-- =========================================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS student_management_db;

USE student_management_db;


-- =========================================================
-- 2. Create Departments Table
-- =========================================================

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    office_location VARCHAR(100)
);


-- =========================================================
-- 3. Create Students Table
-- =========================================================

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    date_of_birth DATE,
    admission_date DATE NOT NULL,

    CONSTRAINT fk_students_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- =========================================================
-- 4. Create Instructors Table
-- =========================================================

CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,

    CONSTRAINT fk_instructors_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- =========================================================
-- 5. Create Courses Table
-- =========================================================

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_title VARCHAR(150) NOT NULL,
    credit_hours DECIMAL(3,1) NOT NULL,

    CONSTRAINT chk_course_credit
        CHECK (credit_hours > 0)
);


-- =========================================================
-- 6. Create Semesters Table
-- =========================================================

CREATE TABLE semesters (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    semester_name VARCHAR(30) NOT NULL,
    academic_year SMALLINT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    CONSTRAINT uq_semester
        UNIQUE (semester_name, academic_year),

    CONSTRAINT chk_semester_dates
        CHECK (end_date >= start_date)
);


-- =========================================================
-- 7. Create Course Sections Table
-- =========================================================

CREATE TABLE course_sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    semester_id INT NOT NULL,
    instructor_id INT NOT NULL,
    section_number VARCHAR(10) NOT NULL,
    capacity INT NOT NULL DEFAULT 40,

    CONSTRAINT uq_course_section
        UNIQUE (course_id, semester_id, section_number),

    CONSTRAINT chk_section_capacity
        CHECK (capacity > 0),

    CONSTRAINT fk_sections_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_sections_semester
        FOREIGN KEY (semester_id)
        REFERENCES semesters(semester_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_sections_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES instructors(instructor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- =========================================================
-- 8. Create Enrollments Table
-- =========================================================

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    marks DECIMAL(5,2) DEFAULT NULL,
    grade VARCHAR(2) DEFAULT NULL,

    CONSTRAINT uq_student_section
        UNIQUE (student_id, section_id),

    CONSTRAINT chk_enrollment_marks
        CHECK (marks IS NULL OR (marks >= 0 AND marks <= 100)),

    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_enrollments_section
        FOREIGN KEY (section_id)
        REFERENCES course_sections(section_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- =========================================================
-- 9. Verify Created Tables
-- =========================================================

SHOW TABLES;

-- Inspect table structures
DESCRIBE departments;
DESCRIBE students;
DESCRIBE instructors;
DESCRIBE courses;
DESCRIBE semesters;
DESCRIBE course_sections;
DESCRIBE enrollments;
