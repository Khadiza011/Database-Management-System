
-- =====================================================
-- Topic: INNER JOIN
-- File: 01_INNER_JOIN.sql
-- Database: retail_db
-- DBMS: MySQL / MariaDB
-- =====================================================

-- 1. Create a new database
CREATE DATABASE IF NOT EXISTS retail_db;

-- 2. Select the database
USE retail_db;

-- 3. Create the customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
) ENGINE = InnoDB;

-- 4. Create the orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_amount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE = InnoDB;

-- 5. Insert sample customers
INSERT INTO customers (customer_id, customer_name, city)
VALUES
    (1, 'Rahim Ahmed', 'Dhaka'),
    (2, 'Karim Hasan', 'Chattogram'),
    (3, 'Nusrat Jahan', 'Sylhet'),
    (4, 'Sadia Islam', 'Dhaka')
ON DUPLICATE KEY UPDATE
    customer_name = VALUES(customer_name),
    city = VALUES(city);

-- 6. Insert sample orders
INSERT INTO orders (order_id, customer_id, order_amount)
VALUES
    (101, 1, 2500.00),
    (102, 2, 1800.00),
    (103, 1, 3200.00),
    (104, 3, 4500.00)
ON DUPLICATE KEY UPDATE
    customer_id = VALUES(customer_id),
    order_amount = VALUES(order_amount);

-- 7. Display all customers
SELECT * FROM customers;

-- 8. Display all orders
SELECT * FROM orders;

-- 9. Perform INNER JOIN
SELECT
    customers.customer_id,
    customers.customer_name,
    orders.order_id,
    orders.order_amount
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id;

-- 10. Perform INNER JOIN using table aliases
SELECT
    c.customer_name,
    o.order_id,
    o.order_amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- 11. Find orders belonging to customers in Dhaka
SELECT
    c.customer_name,
    c.city,
    o.order_id,
    o.order_amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE c.city = 'Dhaka';

-- 12. Display orders from highest to lowest amount
SELECT
    c.customer_name,
    o.order_id,
    o.order_amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY o.order_amount DESC;
