
-- =========================================================
-- Project: Jules Rimet Trophy Investigation
-- File: 06_views.sql
-- Database: jules_rimet_investigation
-- DBMS: MySQL 8.x
-- Purpose: Investigation Views and Reusable Reports
-- =========================================================

USE jules_rimet_investigation;


-- =========================================================
-- Problem 1: Create the Case File View
-- PDF Mission-12
--
-- Combines witness statements, events, and locations.
-- =========================================================

CREATE OR REPLACE VIEW v_case_file AS
SELECT
    ws.statement_id,
    ws.statement_date,
    p.full_name AS witness_name,
    p.role AS witness_role,
    ws.statement_text,
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    e.description AS event_description
FROM witness_statement AS ws
JOIN person AS p
    ON ws.person_id = p.person_id
JOIN investigation_event AS e
    ON ws.event_id = e.event_id
JOIN location AS l
    ON e.location_id = l.location_id;


-- =========================================================
-- Problem 2: Display the complete case file
-- =========================================================

SELECT *
FROM v_case_file
ORDER BY statement_date, statement_id;


-- =========================================================
-- Problem 3: Create an Investigation Timeline View
--
-- LEFT JOIN keeps events even when their location
-- has not been recorded.
-- =========================================================

CREATE OR REPLACE VIEW v_investigation_timeline AS
SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    e.event_time,
    COALESCE(
        l.location_name,
        'Location not recorded'
    ) AS location_name,
    l.city,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id;


-- =========================================================
-- Problem 4: Display the investigation timeline
-- =========================================================

SELECT *
FROM v_investigation_timeline
ORDER BY event_date, event_time, event_id;


-- =========================================================
-- Problem 5: Find statements from a particular witness
-- =========================================================

SELECT
    witness_name,
    statement_date,
    statement_text,
    event_name,
    location_name
FROM v_case_file
WHERE witness_name = 'Frank Hudson';


-- =========================================================
-- Problem 6: Find statements related to the theft discovery
-- =========================================================

SELECT
    witness_name,
    statement_date,
    statement_text,
    event_name,
    event_date
FROM v_case_file
WHERE event_name = 'Trophy Discovered Missing';


-- =========================================================
-- Problem 7: Count statements by witness using the view
-- =========================================================

SELECT
    witness_name,
    COUNT(*) AS total_statements
FROM v_case_file
GROUP BY witness_name
ORDER BY total_statements DESC, witness_name;


-- =========================================================
-- Problem 8: Count events by location using the timeline view
-- =========================================================

SELECT
    location_name,
    COUNT(*) AS total_events
FROM v_investigation_timeline
GROUP BY location_name
ORDER BY total_events DESC, location_name;


-- =========================================================
-- Problem 9: Inspect the created views
-- =========================================================

SHOW FULL TABLES
WHERE Table_type = 'VIEW';


-- =========================================================
-- Problem 10: Inspect the view definitions
-- =========================================================

SHOW CREATE VIEW v_case_file;

SHOW CREATE VIEW v_investigation_timeline;


-- =========================================================
-- End of 06_views.sql
-- =========================================================
