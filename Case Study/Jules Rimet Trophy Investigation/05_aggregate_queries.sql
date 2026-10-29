
-- =========================================================
-- Project: Jules Rimet Trophy Investigation
-- File: 05_aggregate_queries.sql
-- Database: jules_rimet_investigation
-- DBMS: MySQL 8.x
-- Purpose: Aggregate Queries and Investigation Analysis
-- =========================================================

USE jules_rimet_investigation;


-- =========================================================
-- Problem 1: Count witness statements for each person
-- PDF Mission-11
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
-- Problem 2: Find the person with the most statements
-- =========================================================

SELECT
    p.full_name,
    COUNT(ws.statement_id) AS total_statements
FROM person AS p
JOIN witness_statement AS ws
    ON p.person_id = ws.person_id
GROUP BY
    p.person_id,
    p.full_name
ORDER BY total_statements DESC, p.full_name
LIMIT 1;


-- =========================================================
-- Problem 3: Rank people by number of witness statements
-- DENSE_RANK preserves ties in the ranking.
-- =========================================================

SELECT
    ranked.full_name,
    ranked.total_statements,
    ranked.statement_rank
FROM (
    SELECT
        p.full_name,
        COUNT(ws.statement_id) AS total_statements,
        DENSE_RANK() OVER (
            ORDER BY COUNT(ws.statement_id) DESC
        ) AS statement_rank
    FROM person AS p
    JOIN witness_statement AS ws
        ON p.person_id = ws.person_id
    GROUP BY
        p.person_id,
        p.full_name
) AS ranked
WHERE ranked.statement_rank = 2;


-- =========================================================
-- Problem 4: Count events at each location
-- Include locations with zero recorded events.
-- =========================================================

SELECT
    l.location_id,
    l.location_name,
    COUNT(e.event_id) AS total_events
FROM location AS l
LEFT JOIN investigation_event AS e
    ON l.location_id = e.location_id
GROUP BY
    l.location_id,
    l.location_name
ORDER BY total_events DESC, l.location_name;


-- =========================================================
-- Problem 5: Find the location with the most events
-- =========================================================

SELECT
    l.location_name,
    COUNT(e.event_id) AS total_events
FROM location AS l
LEFT JOIN investigation_event AS e
    ON l.location_id = e.location_id
GROUP BY
    l.location_id,
    l.location_name
ORDER BY total_events DESC, l.location_name
LIMIT 1;


-- =========================================================
-- Problem 6: Count events by date
-- =========================================================

SELECT
    event_date,
    COUNT(*) AS total_events
FROM investigation_event
GROUP BY event_date
ORDER BY event_date;


-- =========================================================
-- Problem 7: Find dates with multiple recorded events
-- =========================================================

SELECT
    event_date,
    COUNT(*) AS total_events
FROM investigation_event
GROUP BY event_date
HAVING COUNT(*) > 1
ORDER BY event_date;


-- =========================================================
-- Problem 8: Summarize witness statements by role
-- =========================================================

SELECT
    p.role,
    COUNT(ws.statement_id) AS total_statements
FROM person AS p
LEFT JOIN witness_statement AS ws
    ON p.person_id = ws.person_id
GROUP BY p.role
ORDER BY total_statements DESC, p.role;


-- =========================================================
-- Problem 9: Produce the chronological investigation timeline
-- Include events without a recorded location.
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
    e.event_date,
    e.event_time,
    e.event_id;


-- =========================================================
-- Problem 10: Find the last documented event before the
-- trophy was discovered missing.
-- =========================================================

SELECT
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
WHERE
    e.event_date < (
        SELECT event_date
        FROM investigation_event
        WHERE event_name = 'Trophy Discovered Missing'
        LIMIT 1
    )
    OR (
        e.event_date = (
            SELECT event_date
            FROM investigation_event
            WHERE event_name = 'Trophy Discovered Missing'
            LIMIT 1
        )
        AND e.event_time < (
            SELECT event_time
            FROM investigation_event
            WHERE event_name = 'Trophy Discovered Missing'
            LIMIT 1
        )
    )
ORDER BY
    e.event_date DESC,
    e.event_time DESC,
    e.event_id DESC
LIMIT 1;


-- =========================================================
-- Problem 11: Find the first documented event after the
-- trophy was discovered missing.
-- =========================================================

SELECT
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
WHERE
    e.event_date > (
        SELECT event_date
        FROM investigation_event
        WHERE event_name = 'Trophy Discovered Missing'
        LIMIT 1
    )
    OR (
        e.event_date = (
            SELECT event_date
            FROM investigation_event
            WHERE event_name = 'Trophy Discovered Missing'
            LIMIT 1
        )
        AND e.event_time > (
            SELECT event_time
            FROM investigation_event
            WHERE event_name = 'Trophy Discovered Missing'
            LIMIT 1
        )
    )
ORDER BY
    e.event_date,
    e.event_time,
    e.event_id
LIMIT 1;


-- =========================================================
-- Problem 12: Count events with and without locations
-- =========================================================

SELECT
    COUNT(*) AS total_events,
    SUM(
        CASE
            WHEN location_id IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS events_with_location,
    SUM(
        CASE
            WHEN location_id IS NULL THEN 1
            ELSE 0
        END
    ) AS events_without_location
FROM investigation_event;


-- =========================================================
-- End of 05_aggregate_queries.sql
-- =========================================================
