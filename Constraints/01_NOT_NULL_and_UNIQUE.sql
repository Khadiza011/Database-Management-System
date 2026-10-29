
-- =====================================================
-- Topic: NOT NULL and UNIQUE Constraints
-- File: 01_NOT_NULL_and_UNIQUE.sql
-- Database: sales_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Create a new database
CREATE DATABASE IF NOT EXISTS sales_db;

-- 2. Select the database
USE sales_db;

-- 3. Create a customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20)
);

-- 4. Insert valid customer records
INSERT INTO customers
    (customer_id, customer_name, email, phone)
VALUES
    (1, 'Rahim Ahmed', 'rahim@example.com', '01711111111'),
    (2, 'Karim Hasan', 'karim@example.com', '01822222222'),
    (3, 'Nusrat Jahan', 'nusrat@example.com', '01933333333');

-- 5. Display all customers
SELECT * FROM customers;

-- 6. Insert a customer without an email
-- This is allowed because email is nullable
INSERT INTO customers
    (customer_id, customer_name, email, phone)
VALUES
    (4, 'Sadia Islam', NULL, '01644444444');

-- 7. Display all customers again
SELECT * FROM customers;

-- 8. Check the table structure
DESCRIBE customers;
