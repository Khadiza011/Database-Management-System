
-- =========================================================
-- Project: Jules Rimet Trophy Investigation
-- File: 04_joins_and_witnesses.sql
-- Database: jules_rimet_investigation
-- DBMS: MySQL 8.x
-- Purpose: JOINs and Witness Statement Analysis
-- =========================================================

USE jules_rimet_investigation;


-- =========================================================
-- Problem 1: Display all people involved in the investigation
-- =========================================================

SELECT
    person_id,
    full_name,
    role,
    notes
FROM person
ORDER BY full_name;


-- =========================================================
-- Problem 2: Display witness statements with witness names
-- INNER JOIN returns statements with matching people.
-- =========================================================

SELECT
    ws.statement_id,
    p.full_name AS witness_name,
    p.role,
    ws.statement_date,
    ws.statement_text
FROM witness_statement AS ws
INNER JOIN person AS p
    ON ws.person_id = p.person_id
ORDER BY ws.statement_date, ws.statement_id;


-- =========================================================
-- Problem 3: Connect witness statements to related events
-- =========================================================

SELECT
    ws.statement_id,
    p.full_name AS witness_name,
    e.event_name,
    e.event_date,
    ws.statement_date,
    ws.statement_text
FROM witness_statement AS ws
INNER JOIN person AS p
    ON ws.person_id = p.person_id
LEFT JOIN investigation_event AS e
    ON ws.event_id = e.event_id
ORDER BY ws.statement_id;


-- =========================================================
-- Problem 4: Display events with their locations
-- =========================================================

SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    l.city
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
ORDER BY e.event_date, e.event_time, e.event_id;


-- =========================================================
-- Problem 5: Find people who submitted witness statements
-- =========================================================

SELECT DISTINCT
    p.person_id,
    p.full_name,
    p.role
FROM person AS p
INNER JOIN witness_statement AS ws
    ON p.person_id = ws.person_id
ORDER BY p.full_name;


-- =========================================================
-- Problem 6: Find people without recorded statements
-- =========================================================

SELECT
    p.person_id,
    p.full_name,
    p.role
FROM person AS p
LEFT JOIN witness_statement AS ws
    ON p.person_id = ws.person_id
WHERE ws.statement_id IS NULL
ORDER BY p.full_name;


-- =========================================================
-- Problem 7: Display all events and any related statements
-- LEFT JOIN preserves events without witness statements.
-- =========================================================

SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    p.full_name AS person_name,
    ws.statement_text
FROM investigation_event AS e
LEFT JOIN witness_statement AS ws
    ON e.event_id = ws.event_id
LEFT JOIN person AS p
    ON ws.person_id = p.person_id
ORDER BY e.event_date, e.event_id;


-- =========================================================
-- Problem 8: Find statements related to 20 March 1966 events
-- =========================================================

SELECT
    p.full_name AS witness_name,
    e.event_name,
    e.event_date,
    ws.statement_text
FROM witness_statement AS ws
INNER JOIN person AS p
    ON ws.person_id = p.person_id
INNER JOIN investigation_event AS e
    ON ws.event_id = e.event_id
WHERE e.event_date = '1966-03-20'
ORDER BY p.full_name;


-- =========================================================
-- Problem 9: Count recorded statements per person
-- Includes people with zero recorded statements.
-- =========================================================

SELECT
    p.person_id,
    p.full_name,
    COUNT(ws.statement_id) AS total_statements
FROM person AS p
LEFT JOIN witness_statement AS ws
    ON p.person_id = ws.person_id
GROUP BY
    p.person_id,
    p.full_name
ORDER BY total_statements DESC, p.full_name;


-- =========================================================
-- Problem 10: Find all statements mentioning a suspicious man
-- =========================================================

SELECT
    ws.statement_id,
    p.full_name AS witness_name,
    ws.statement_date,
    ws.statement_text
FROM witness_statement AS ws
INNER JOIN person AS p
    ON ws.person_id = p.person_id
WHERE ws.statement_text LIKE '%suspicious man%'
   OR ws.statement_text LIKE '%strange man%'
ORDER BY ws.statement_date;


-- =========================================================
-- Problem 11: Display the complete investigation timeline
-- with location and related witness statements.
-- =========================================================

SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    p.full_name AS witness_name,
    ws.statement_text
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
LEFT JOIN witness_statement AS ws
    ON e.event_id = ws.event_id
LEFT JOIN person AS p
    ON ws.person_id = p.person_id
ORDER BY
    e.event_date,
    e.event_time,
    e.event_id;


-- =========================================================
-- End of 04_joins_and_witnesses.sql
-- =========================================================
