
-- =====================================================
-- Topic: SQL Subqueries
-- File: 06_Subqueries.sql
-- Database: retail_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE retail_db;

-- 2. Display all customers
SELECT * FROM customers;

-- 3. Display all orders
SELECT * FROM orders;

-- 4. Find orders greater than the average order amount
SELECT *
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);

-- 5. Find customers who have placed at least one order
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

-- 6. Find customers who have not placed any orders
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

-- 7. Find customers who have placed an order
-- using EXISTS
SELECT *
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);

-- 8. Find the customer with the highest order amount
SELECT *
FROM orders
WHERE order_amount = (
    SELECT MAX(order_amount)
    FROM orders
);

-- 9. Find customers whose IDs match customers
-- who have placed an order worth more than 2000
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_amount > 2000
);

-- 10. Display orders above the average amount
-- with a calculated average for comparison
SELECT
    order_id,
    customer_id,
    order_amount,
    (SELECT AVG(order_amount) FROM orders) AS average_amount
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);

-- 11. Find the second-highest distinct order amount
SELECT MAX(order_amount) AS second_highest_amount
FROM orders
WHERE order_amount < (
    SELECT MAX(order_amount)
    FROM orders
);

-- 12. Find customers from cities containing
-- the city of a customer who placed an order
SELECT *
FROM customers
WHERE city IN (
    SELECT city
    FROM customers
    WHERE customer_id IN (
        SELECT customer_id
        FROM orders
    )
);
