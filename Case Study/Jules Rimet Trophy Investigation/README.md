# Jules Rimet Trophy Investigation

A practical database investigation project based on the 1966 Jules Rimet World Cup Trophy theft scenario, developed using **MySQL 8.x**.

This case study demonstrates how relational database design and SQL queries can be used to organize investigation records, connect people with events, analyze witness statements, reconstruct timelines, and maintain a precomputed case map.

The project follows the missions and exercises provided in the DBMS Lab Workshop .

## Project Objectives

- Design a relational database for an investigation scenario.
- Store information about the trophy, people, locations, events, and witness statements.
- Establish relationships using primary keys and foreign keys.
- Retrieve investigation records using SQL queries and joins.
- Analyze evidence records using aggregate functions.
- Identify people without recorded witness statements.
- Build reusable views for investigation reports.
- Create a precomputed case map for timeline analysis.
- Update investigation records and refresh the case map.
- Practice real-world database problem-solving.

## Technologies Used

- **Database:** MySQL 8.x
- **Query Language:** SQL
- **Database Tool:** phpMyAdmin or MySQL Workbench
- **Documentation:** Markdown
- **Case Study Source:** DBMS Summer Workshop PDF

## Database Schema

The database is named `jules_rimet_investigation`.

It contains five main tables:

| Table | Purpose |
|---|---|
| `trophy` | Stores information about the trophy under investigation. |
| `person` | Stores people associated with the investigation. |
| `location` | Stores investigation-related locations. |
| `investigation_event` | Stores events, dates, times, locations, and descriptions. |
| `witness_statement` | Stores statements associated with people and investigation events. |

### Relationships

- A location can be associated with multiple investigation events.
- A person can provide multiple witness statements.
- An event can be associated with multiple witness statements.
- A witness statement can optionally reference an event.
- An investigation event can have an unknown or unrecorded location.

## SQL Files and Their Purposes

| File | Description |
|---|---|
| `01_schema.sql` | Creates the database and its five relational tables. |
| `02_sample_data.sql` | Inserts sample people, locations, events, trophy details, and witness statements. |
| `03_basic_queries.sql` | Demonstrates filtering, sorting, pattern matching, and basic investigation queries. |
| `04_joins_and_witnesses.sql` | Connects people, witness statements, events, and locations using JOINs. |
| `05_aggregate_queries.sql` | Uses COUNT, GROUP BY, HAVING, subqueries, and ranking to analyze records. |
| `06_views.sql` | Creates reusable investigation views and timeline reports. |
| `07_case_map.sql` | Creates a precomputed case map and demonstrates updating and refreshing investigation records. |
| `08_self_practice_solutions.sql` | Solves the remaining PDF self-practice questions, conceptual database questions, witness leaderboard, chronological analysis, and case-map verification. |


## Investigation Questions Explored

This project uses SQL to explore questions such as:

- Which events occurred at Westminster Central Hall?
- Which events are associated with each location?
- Who has recorded witness statements?
- Which people have never provided a recorded statement?
- Which person has the greatest number of witness statements?
- Which location has the most recorded events?
- What is the chronological order of the documented events?
- What was the last documented event before the trophy was discovered missing?
- What is the first documented event after the trophy was discovered missing?
- How does updating an event's location affect the case map?

The results depend on the records present in the sample database and should not be treated as independent proof of historical facts.

## How to Run the Project

Execute the SQL files in the following order:

1. `01_schema.sql` — Create the database and tables.
2. `02_sample_data.sql` — Insert the sample records.
3. `03_basic_queries.sql` — Run basic investigation queries.
4. `04_joins_and_witnesses.sql` — Analyze people and witness statements.
5. `05_aggregate_queries.sql` — Generate aggregate reports.
6. `06_views.sql` — Create and query investigation views.
7. `07_case_map.sql` — Create and refresh the precomputed case map.

### Execution Notes

- Run the schema before inserting sample data.
- Run the sample-data script only once on a fresh database unless the existing records have been cleared.
- Execute the remaining scripts after their required tables and records exist.
- The case-map script updates sample investigation records and rebuilds its snapshot.
- Review SQL statements before executing scripts that modify existing records.

## Important Notes

- This is an educational SQL case study based on the supplied workshop scenario, not an official police database.
- Sample witness statements are illustrative records and should not be interpreted as verified verbatim historical testimony.
- Historical events and demonstration records should be distinguished when interpreting query results.
- `mv_case_map` is a manually refreshed summary table, not a native materialized view.
- The project uses MySQL 8.x features, including window functions such as DENSE_RANK().
- Database results reflect the inserted sample data and may differ from other historical accounts.

## Learning Outcomes

By completing this case study, learners can practice:

- Designing relational databases.
- Writing SQL queries for investigation scenarios.
- Connecting related records using JOINs.
- Analyzing data with aggregate functions.
- Working with subqueries and window functions.
- Creating reusable views.
- Reconstructing chronological timelines.
- Updating records while maintaining referential integrity.
- Building and refreshing precomputed reports.
- Applying SQL to structured, real-world problem scenarios.

## Project Status

The initial SQL implementation covers database creation, sample data, basic queries, joins, witness analysis, aggregation, views, and a precomputed case map.

Further improvements may include additional investigation records, stronger data validation, more detailed relationships, and automated summary refresh mechanisms.
