
-- =====================================================
-- Topic: Introduction to SQL and Database Creation
-- File: 01_Introduction_and_Database_Creation.sql
-- Database: MySQL
-- =====================================================

-- 1. Display all available databases
SHOW DATABASES;

-- 2. Create a new database
CREATE DATABASE university_db;

-- 3. Select the database
USE university_db;

-- 4. Create a students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT,
    department VARCHAR(50)
);

-- 5. Display all tables in the selected database
SHOW TABLES;

-- 6. Display the structure of the students table
DESCRIBE students;
