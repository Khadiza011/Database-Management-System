
-- =====================================================
-- Topic: RIGHT JOIN
-- File: 03_RIGHT_JOIN.sql
-- Database: retail_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE retail_db;

-- 2. Display all customers
SELECT * FROM customers;

-- 3. Display all orders
SELECT * FROM orders;

-- 4. Perform RIGHT JOIN
-- All orders will appear, even if no matching customer exists
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_amount
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- 5. Display orders with customer names
SELECT
    o.order_id,
    o.order_amount,
    c.customer_name
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- 6. Find orders without a matching customer
SELECT
    o.order_id,
    o.customer_id,
    o.order_amount
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

-- 7. Display orders with amounts greater than 2000
SELECT
    o.order_id,
    o.order_amount,
    c.customer_name
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_amount > 2000;

-- 8. Sort all orders by amount
SELECT
    o.order_id,
    o.order_amount,
    c.customer_name
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY o.order_amount DESC;
