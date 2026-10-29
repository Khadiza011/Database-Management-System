
-- =========================================================
-- Project: Jules Rimet Trophy Investigation
-- File: 02_sample_data.sql
-- Database: jules_rimet_investigation
-- DBMS: MySQL 8.x
-- Purpose: Insert historical investigation sample data
-- Source: DBMS Summer Workshop PDF
-- =========================================================

USE jules_rimet_investigation;


-- =========================================================
-- 1. Insert the Jules Rimet Trophy
-- =========================================================

INSERT INTO trophy (
    trophy_id,
    trophy_name,
    trophy_type,
    official_value,
    insurance_value,
    status
)
VALUES (
    1,
    'Jules Rimet Trophy',
    'FIFA World Cup Trophy',
    3000.00,
    30000.00,
    'STOLEN'
);


-- =========================================================
-- 2. Insert the people associated with the investigation
-- =========================================================

INSERT INTO person (
    person_id,
    full_name,
    role,
    notes
)
VALUES
(
    1,
    'Joe Mears',
    'Football Association Chairman',
    'Chairman of the Football Association'
),
(
    2,
    'Edward Betchley',
    'Ransom Intermediary',
    'Known as Jackson during ransom operation'
),
(
    3,
    'Charles Buggy',
    'Detective Inspector',
    'Flying Squad officer involved in ransom operation'
),
(
    4,
    'David Corbett',
    'Civilian',
    'Recovered the trophy after Pickles discovered it'
),
(
    5,
    'Pickles',
    'Dog',
    'Discovered the trophy under a hedge'
),
(
    6,
    'Frank Hudson',
    'Security Guard',
    'Worked at the exhibition'
),
(
    7,
    'Margaret Coombes',
    'Witness',
    'Churchgoer who reported seeing a suspicious man'
),
(
    8,
    'Harold Mayes',
    'Football Association Official',
    'Identified the recovered trophy'
);


-- =========================================================
-- 3. Insert investigation locations
-- =========================================================

INSERT INTO location (
    location_id,
    location_name,
    city,
    description
)
VALUES
(
    1,
    'Westminster Central Hall',
    'London',
    'Exhibition venue where the trophy was displayed'
),
(
    2,
    'Battersea Park',
    'London',
    'Location selected for ransom exchange'
),
(
    3,
    'Kennington Park Road',
    'London',
    'Location where the ransom suspect attempted to escape'
),
(
    4,
    'Beulah Hill',
    'London',
    'Area where Pickles discovered the package'
),
(
    5,
    'Cannon Row Police Station',
    'London',
    'Police station where Corbett handed over the recovered trophy'
),
(
    6,
    'Gipsy Hill Police Station',
    'London',
    'Police station where the recovered trophy was identified'
);


-- =========================================================
-- 4. Insert historical investigation events
--
-- Event IDs follow the order presented in the PDF.
-- Location IDs are matched to the location descriptions.
-- =========================================================

INSERT INTO investigation_event (
    event_id,
    event_name,
    event_date,
    event_time,
    location_id,
    description
)
VALUES
(
    1,
    'Exhibition Opens',
    '1966-03-19',
    NULL,
    1,
    'Stampex exhibition opens'
),
(
    2,
    'Trophy Handed to Police',
    '1966-03-27',
    NULL,
    5,
    'David Corbett hands trophy to police'
),
(
    3,
    'Trophy Discovered Missing',
    '1966-03-20',
    '12:10:00',
    1,
    'Display case found opened and trophy missing'
),
(
    4,
    'Routine Security Check',
    '1966-03-20',
    '11:00:00',
    1,
    'Trophy observed before the theft window'
),
(
    5,
    'Ransom Meeting',
    '1966-03-25',
    NULL,
    2,
    'Police operation involving alleged intermediary Jackson'
),
(
    6,
    'Suspect Escape Attempt',
    '1966-03-25',
    NULL,
    3,
    'Suspect attempts to escape from police operation'
),
(
    7,
    'Trophy Discovered',
    '1966-03-27',
    NULL,
    4,
    'Pickles discovers wrapped package'
),
(
    8,
    'Ransom Contact',
    '1966-03-21',
    NULL,
    NULL,
    'Anonymous contact and ransom demand'
);


-- =========================================================
-- 5. Insert witness statements
--
-- Person IDs and event ID follow the PDF examples.
-- Statements are sample investigation records, not
-- a claim that these are verbatim archival transcripts.
-- =========================================================

INSERT INTO witness_statement (
    statement_id,
    person_id,
    event_id,
    statement_date,
    statement_text
)
VALUES
(
    1,
    6,
    3,
    '1966-03-20',
    'Reported that a suspicious man had been seen near the public telephone area.'
),
(
    2,
    7,
    3,
    '1966-03-20',
    'Reported seeing a strange man in the Central Hall area.'
);


-- =========================================================
-- 6. Verify inserted data
-- =========================================================

SELECT * FROM trophy;

SELECT * FROM person
ORDER BY person_id;

SELECT * FROM location
ORDER BY location_id;

SELECT * FROM investigation_event
ORDER BY event_id;

SELECT * FROM witness_statement
ORDER BY statement_id;


-- =========================================================
-- End of 02_sample_data.sql
-- =========================================================
