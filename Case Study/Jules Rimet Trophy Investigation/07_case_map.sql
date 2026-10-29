
-- =========================================================
-- Project: Jules Rimet Trophy Investigation
-- File: 07_case_map.sql
-- Database: jules_rimet_investigation
-- DBMS: MySQL 8.x
-- Purpose: Precomputed Case Map and Investigation Updates
-- =========================================================

USE jules_rimet_investigation;


-- =========================================================
-- Problem 1: Create the precomputed case map
-- PDF Mission-13
-- =========================================================

DROP TABLE IF EXISTS mv_case_map;

CREATE TABLE mv_case_map AS
SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id;


-- =========================================================
-- Problem 2: Display the case map
-- =========================================================

SELECT *
FROM mv_case_map
ORDER BY event_date, event_time, event_id;


-- =========================================================
-- Problem 3: Update Frank Hudson's witness statement
--
-- The sample statement initially mentions the telephone area.
-- Update it to reflect the revised statement in the exercise.
-- =========================================================

UPDATE witness_statement AS ws
JOIN person AS p
    ON ws.person_id = p.person_id
SET ws.statement_text =
    'Revised statement: the suspicious man was seen near the reception area, not the telephone area.'
WHERE p.full_name = 'Frank Hudson'
  AND ws.statement_id = 1;


-- Verify the revised witness statement.
SELECT
    p.full_name,
    ws.statement_date,
    ws.statement_text
FROM witness_statement AS ws
JOIN person AS p
    ON ws.person_id = p.person_id
WHERE p.full_name = 'Frank Hudson';


-- =========================================================
-- Problem 4: Update the location of the ransom contact
-- The exercise identifies Battersea Park as the location.
-- =========================================================

UPDATE investigation_event
SET location_id = (
    SELECT location_id
    FROM location
    WHERE location_name = 'Battersea Park'
)
WHERE event_name = 'Ransom Contact';


-- Verify the source event after the update.
SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    l.location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
WHERE e.event_name = 'Ransom Contact';


-- =========================================================
-- Problem 5: Check the case map before refreshing
--
-- The case map is a snapshot table.
-- It does not automatically reflect source-table changes.
-- =========================================================

SELECT *
FROM mv_case_map
WHERE event_name = 'Ransom Contact';


-- =========================================================
-- Problem 6: Refresh the precomputed case map
--
-- Rebuild the snapshot using the latest source records.
-- =========================================================

DELETE FROM mv_case_map;

INSERT INTO mv_case_map (
    event_id,
    event_name,
    event_date,
    event_time,
    location_name,
    description
)
SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id;


-- =========================================================
-- Problem 7: Verify the refreshed case map
-- =========================================================

SELECT *
FROM mv_case_map
ORDER BY event_date, event_time, event_id;


-- =========================================================
-- Problem 8: Compare the case map with the source data
-- =========================================================

SELECT
    e.event_id,
    e.event_name,
    l.location_name AS source_location,
    m.location_name AS case_map_location
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
LEFT JOIN mv_case_map AS m
    ON e.event_id = m.event_id
ORDER BY e.event_id;


-- =========================================================
-- End of 07_case_map.sql
-- =========================================================
