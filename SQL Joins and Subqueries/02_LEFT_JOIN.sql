
-- =====================================================
-- Topic: LEFT JOIN
-- File: 02_LEFT_JOIN.sql
-- Database: retail_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE retail_db;

-- 2. Display all customers
SELECT * FROM customers;

-- 3. Display all orders
SELECT * FROM orders;

-- 4. Perform LEFT JOIN
-- All customers will appear, even without orders
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_amount
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- 5. Find customers who have no orders
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 6. Display customers and their orders from Dhaka
SELECT
    c.customer_name,
    c.city,
    o.order_id,
    o.order_amount
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE c.city = 'Dhaka';

-- 7. Display all customers and their order amounts
-- Customers without orders will have NULL order amounts
SELECT
    c.customer_name,
    o.order_amount
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_name ASC;

-- 8. Display all customers with a readable order status
SELECT
    c.customer_id,
    c.customer_name,
    CASE
        WHEN o.order_id IS NULL THEN 'No Orders'
        ELSE 'Has Orders'
    END AS order_status
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;
