
-- =====================================================
-- Topic: Correlated Subqueries
-- File: 07_Correlated_Subqueries.sql
-- Database: retail_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Select the database
USE retail_db;

-- 2. Display all customers
SELECT * FROM customers;

-- 3. Display all orders
SELECT * FROM orders;

-- 4. Find orders greater than the average order
-- amount of the same customer
SELECT
    o.order_id,
    o.customer_id,
    o.order_amount
FROM orders AS o
WHERE o.order_amount > (
    SELECT AVG(o2.order_amount)
    FROM orders AS o2
    WHERE o2.customer_id = o.customer_id
);

-- 5. Find customers who have placed at least one order
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);

-- 6. Find customers who have not placed any orders
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);

-- 7. Find the highest-value order for each customer
SELECT
    o.order_id,
    o.customer_id,
    o.order_amount
FROM orders AS o
WHERE o.order_amount = (
    SELECT MAX(o2.order_amount)
    FROM orders AS o2
    WHERE o2.customer_id = o.customer_id
);

-- 8. Find customers whose total order amount
-- is greater than 3000
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
WHERE (
    SELECT SUM(o.order_amount)
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
) > 3000;

-- 9. Count orders for each customer using a
-- correlated subquery
SELECT
    c.customer_id,
    c.customer_name,
    (
        SELECT COUNT(*)
        FROM orders AS o
        WHERE o.customer_id = c.customer_id
    ) AS total_orders
FROM customers AS c;

-- 10. Find customers whose every order amount
-- is greater than 2000
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
      AND o.order_amount <= 2000
);
