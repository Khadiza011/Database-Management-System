
-- =========================================================
-- Project: Jules Rimet Trophy Investigation
-- File: 08_self_practice_solutions.sql
-- Database: jules_rimet_investigation
-- DBMS: MySQL 8.x
-- Purpose: PDF Self-Practice and Remaining Questions
-- =========================================================

USE jules_rimet_investigation;


-- =========================================================
-- PART 1: ANSWERS TO "ASK YOURSELF"
-- =========================================================

-- ---------------------------------------------------------
-- Question 1: Why use DECIMAL instead of TEXT for money?
--
-- Answer:
-- DECIMAL stores exact numeric values and supports arithmetic.
-- TEXT stores characters and is unsuitable for direct
-- numeric calculations and reliable monetary comparisons.
-- Example: official_value = 3000.00
-- ---------------------------------------------------------

SELECT
    trophy_name,
    official_value,
    insurance_value,
    insurance_value - official_value AS value_difference
FROM trophy;


-- ---------------------------------------------------------
-- Question 2: Does the person table name reflect context?
--
-- Answer:
-- Yes. "person" represents people related to the case.
-- It does not imply that every person is a suspect.
-- The role and notes describe each person's involvement.
-- ---------------------------------------------------------

SELECT
    full_name,
    role,
    notes
FROM person
ORDER BY full_name;


-- ---------------------------------------------------------
-- Question 3: DATE + TIME or TIMESTAMP?
--
-- Answer:
-- DATE and TIME are appropriate when date and time are
-- stored separately and event times are local historical
-- records. TIMESTAMP is useful for timestamped events,
-- especially when time-zone conversion is relevant.
-- Historical time-zone interpretation must be documented.
-- ---------------------------------------------------------

SELECT
    event_name,
    event_date,
    event_time
FROM investigation_event
ORDER BY event_date, event_time, event_id;


-- ---------------------------------------------------------
-- Question 4: What happens with an unregistered location_id?
--
-- Answer:
-- The foreign key rejects an INSERT or UPDATE that refers
-- to a location_id absent from the location table.
-- ---------------------------------------------------------

-- Example test (intentionally invalid; execute separately
-- only if you want to observe the foreign-key error):
--
-- UPDATE investigation_event
-- SET location_id = 999999
-- WHERE event_id = 1;


-- ---------------------------------------------------------
-- Question 5: What happens if a referenced location changes
-- or is deleted?
--
-- Answer:
-- The current schema uses ON UPDATE CASCADE and
-- ON DELETE RESTRICT for investigation_event.location_id.
-- Updating a location's primary key cascades the change.
-- Deleting a location referenced by an event is rejected.
--
-- For witness_statement.event_id, ON DELETE SET NULL means
-- deleting a referenced event sets the statement's event_id
-- to NULL instead of deleting the statement.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- Question 6: Why use LEFT JOIN instead of INNER JOIN?
--
-- Answer:
-- LEFT JOIN retains every person, including people who have
-- no witness statement. INNER JOIN would exclude those people.
-- ---------------------------------------------------------

SELECT
    p.full_name,
    p.role,
    ws.statement_id,
    ws.statement_text
FROM person AS p
LEFT JOIN witness_statement AS ws
    ON p.person_id = ws.person_id
ORDER BY p.full_name;


-- ---------------------------------------------------------
-- Question 7: Why use a view?
--
-- Answer:
-- A view saves a reusable SELECT definition. Investigators
-- can query the same report without rewriting its JOINs.
-- A regular view does not store a separate snapshot of data.
-- ---------------------------------------------------------


-- =========================================================
-- PART 2: PDF "YOUR TURN" — EVENT SUMMARY BY LOCATION
-- =========================================================

-- Problem 1: List locations and their recorded events.
-- Include locations with no events.

SELECT
    l.location_name,
    COUNT(e.event_id) AS total_events,
    GROUP_CONCAT(
        e.event_name
        ORDER BY e.event_date, e.event_time, e.event_id
        SEPARATOR '; '
    ) AS recorded_events
FROM location AS l
LEFT JOIN investigation_event AS e
    ON l.location_id = e.location_id
GROUP BY
    l.location_id,
    l.location_name
ORDER BY total_events DESC, l.location_name;


-- Problem 2: Find the location(s) with the maximum number
-- of recorded events. Include ties.

WITH location_counts AS (
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
)
SELECT
    location_name,
    total_events
FROM location_counts
WHERE total_events = (
    SELECT MAX(total_events)
    FROM location_counts
);


-- =========================================================
-- PART 3: PDF "YOUR TURN" — WITNESS STATEMENT ANALYSIS
-- =========================================================

-- Problem 3: Find the person with the highest number of
-- witness statements. Include ties.

WITH statement_counts AS (
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
)
SELECT
    person_id,
    full_name,
    total_statements
FROM statement_counts
WHERE total_statements = (
    SELECT MAX(total_statements)
    FROM statement_counts
);


-- Problem 4: Find the person(s) with the second-highest
-- DISTINCT witness statement count.

WITH statement_counts AS (
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
),
ranked_people AS (
    SELECT
        person_id,
        full_name,
        total_statements,
        DENSE_RANK() OVER (
            ORDER BY total_statements DESC
        ) AS statement_rank
    FROM statement_counts
)
SELECT
    person_id,
    full_name,
    total_statements
FROM ranked_people
WHERE statement_rank = 2;


-- =========================================================
-- PART 4: LAB 01 MINI CASE — CHRONOLOGICAL TIMELINE
-- =========================================================

-- Problem 5: Produce a readable chronological event report.
-- LEFT JOIN retains events without a recorded location.

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
    e.event_time IS NULL,
    e.event_time,
    e.event_id;


-- Problem 6: Find the last documented event before the
-- trophy was discovered missing.

SELECT
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
WHERE (
    e.event_date,
    COALESCE(e.event_time, '00:00:00'),
    e.event_id
) < (
    SELECT
        event_date,
        COALESCE(event_time, '00:00:00'),
        event_id
    FROM investigation_event
    WHERE event_name = 'Trophy Discovered Missing'
    ORDER BY event_id
    LIMIT 1
)
ORDER BY
    e.event_date DESC,
    e.event_time IS NULL,
    e.event_time DESC,
    e.event_id DESC
LIMIT 1;


-- Problem 7: Find the first documented event after the
-- trophy was discovered missing.

SELECT
    e.event_name,
    e.event_date,
    e.event_time,
    l.location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
WHERE (
    e.event_date,
    COALESCE(e.event_time, '00:00:00'),
    e.event_id
) > (
    SELECT
        event_date,
        COALESCE(event_time, '00:00:00'),
        event_id
    FROM investigation_event
    WHERE event_name = 'Trophy Discovered Missing'
    ORDER BY event_id
    LIMIT 1
)
ORDER BY
    e.event_date,
    e.event_time IS NULL,
    e.event_time,
    e.event_id
LIMIT 1;


-- =========================================================
-- PART 5: PDF "DO IT YOURSELF" — WITNESS LEADERBOARD
-- =========================================================

-- Problem 8: Rank people by number of witness statements.
-- People without statements are excluded from this leaderboard.

SELECT
    p.full_name,
    COUNT(ws.statement_id) AS total_statements,
    DENSE_RANK() OVER (
        ORDER BY COUNT(ws.statement_id) DESC
    ) AS witness_rank
FROM person AS p
JOIN witness_statement AS ws
    ON p.person_id = ws.person_id
GROUP BY
    p.person_id,
    p.full_name
ORDER BY witness_rank, p.full_name;


-- =========================================================
-- PART 6: PDF MISSION-13 — UPDATE THE WITNESS STATEMENT
-- =========================================================

-- Problem 9: Frank Hudson's statement changes from the
-- telephone area to the reception area.
--
-- The update is limited to statement_id = 1, the sample
-- statement assigned to Frank Hudson in this project.

UPDATE witness_statement AS ws
JOIN person AS p
    ON ws.person_id = p.person_id
SET ws.statement_text =
    'Revised statement: the suspicious man was seen near the reception area, not the telephone area.'
WHERE p.full_name = 'Frank Hudson'
  AND ws.statement_id = 1;


-- Verify the revised statement.

SELECT
    p.full_name,
    ws.statement_date,
    ws.statement_text
FROM witness_statement AS ws
JOIN person AS p
    ON ws.person_id = p.person_id
WHERE p.full_name = 'Frank Hudson';


-- =========================================================
-- PART 7: PDF MISSION-13 — UPDATE THE RANSOM CONTACT
-- =========================================================

-- Problem 10: Set the Ransom Contact location to Battersea Park.
-- The subquery obtains the location ID by name.

UPDATE investigation_event
SET location_id = (
    SELECT location_id
    FROM location
    WHERE location_name = 'Battersea Park'
)
WHERE event_name = 'Ransom Contact';


-- Verify the updated source record.

SELECT
    e.event_name,
    e.event_date,
    l.location_name,
    e.description
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
WHERE e.event_name = 'Ransom Contact';


-- =========================================================
-- PART 8: REFRESH AND VERIFY THE CASE MAP
-- =========================================================

-- Problem 11: Refresh the existing precomputed case map.
-- This assumes mv_case_map was created by 07_case_map.sql.

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


-- Problem 12: Review the updated case map.

SELECT *
FROM mv_case_map
ORDER BY
    event_date,
    event_time IS NULL,
    event_time,
    event_id;


-- Problem 13: Compare the source event with its case-map entry.

SELECT
    e.event_id,
    e.event_name,
    l.location_name AS source_location,
    m.location_name AS case_map_location,
    CASE
        WHEN l.location_name <=> m.location_name
            THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS location_check
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
LEFT JOIN mv_case_map AS m
    ON e.event_id = m.event_id
ORDER BY e.event_id;


-- =========================================================
-- PART 9: FINAL VERIFICATION
-- =========================================================

-- Verify all witness statements.

SELECT
    ws.statement_id,
    p.full_name,
    e.event_name,
    ws.statement_date,
    ws.statement_text
FROM witness_statement AS ws
JOIN person AS p
    ON ws.person_id = p.person_id
LEFT JOIN investigation_event AS e
    ON ws.event_id = e.event_id
ORDER BY ws.statement_id;


-- Verify all event and location relationships.

SELECT
    e.event_id,
    e.event_name,
    e.event_date,
    l.location_name
FROM investigation_event AS e
LEFT JOIN location AS l
    ON e.location_id = l.location_id
ORDER BY e.event_date, e.event_id;


-- =========================================================
-- End of 08_self_practice_solutions.sql
-- =========================================================
