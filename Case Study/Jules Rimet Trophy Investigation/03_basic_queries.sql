
-- =========================================================
-- Project: Jules Rimet Trophy Investigation
-- File: 03_basic_queries.sql
-- Database: jules_rimet_investigation
-- DBMS: MySQL 8.x
-- Purpose: Basic SQL Queries for the Investigation
-- =========================================================

USE jules_rimet_investigation;


-- =========================================================
-- Problem 1: Display all investigation events
-- =========================================================

SELECT *
FROM investigation_event;


-- =========================================================
-- Problem 2: Find events at Westminster Central Hall
-- =========================================================

SELECT
    e.event_name,
    e.event_date,
    e.event_time,
    e.description
FROM investigation_event AS e
JOIN location AS l
    ON e.location_id = l.location_id
WHERE l.location_name = 'Westminster Central Hall';


-- =========================================================
-- Problem 3: Find all events that happened in London
-- =========================================================

SELECT
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    l.city,
    e.description
FROM investigation_event AS e
JOIN location AS l
    ON e.location_id = l.location_id
WHERE l.city = 'London'
ORDER BY e.event_date, e.event_time;


-- =========================================================
-- Problem 4: Find events mentioning the trophy
-- =========================================================

SELECT
    event_name,
    event_date,
    event_time,
    description
FROM investigation_event
WHERE event_name LIKE '%Trophy%'
   OR description LIKE '%trophy%'
ORDER BY event_date, event_time;


-- =========================================================
-- Problem 5: Find events after 20 March 1966
-- =========================================================

SELECT
    event_name,
    event_date,
    event_time,
    description
FROM investigation_event
WHERE event_date > '1966-03-20'
ORDER BY event_date, event_time;


-- =========================================================
-- Problem 6: Display all events chronologically
-- =========================================================

SELECT
    event_name,
    event_date,
    event_time,
    location_id,
    description
FROM investigation_event
ORDER BY
    event_date ASC,
    event_time ASC,
    event_id ASC;


-- =========================================================
-- Problem 7: Display events with human-readable locations
-- =========================================================

SELECT
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    e.description
FROM investigation_event AS e
JOIN location AS l
    ON e.location_id = l.location_id
ORDER BY
    e.event_date ASC,
    e.event_time ASC;


-- =========================================================
-- Problem 8: Find events without a registered location
-- =========================================================

SELECT
    event_id,
    event_name,
    event_date,
    description
FROM investigation_event
WHERE location_id IS NULL;


-- =========================================================
-- Problem 9: Display every event, including events
-- without a registered location
-- =========================================================

SELECT
    e.event_name,
    e.event_date,
    e.event_time,
    COALESCE(l.location_name, 'Location not recorded')
        AS location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
ORDER BY
    e.event_date ASC,
    e.event_time ASC,
    e.event_id ASC;


-- =========================================================
-- Problem 10: Find events on 20 March 1966
-- =========================================================

SELECT
    event_name,
    event_date,
    event_time,
    description
FROM investigation_event
WHERE event_date = '1966-03-20'
ORDER BY event_time;


-- =========================================================
-- Problem 11: Find events containing the word "ransom"
-- =========================================================

SELECT
    event_name,
    event_date,
    event_time,
    description
FROM investigation_event
WHERE event_name LIKE '%ransom%'
   OR description LIKE '%ransom%'
ORDER BY event_date;


-- =========================================================
-- Problem 12: Display locations in London
-- =========================================================

SELECT
    location_name,
    city,
    description
FROM location
WHERE city = 'London'
ORDER BY location_name;


-- =========================================================
-- End of 03_basic_queries.sql
-- =========================================================
