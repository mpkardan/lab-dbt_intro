# DBT Intro

The purpose of this lab is to explore the basics of DBT to see what it is.


## Database

I'll use the `sakila` sample DB in Postgres as provided [here](https://github.com/jOOQ/sakila).


## Notes

- The `schema.yaml` file is mainly for documentation
  - "everything is a SELECT": the model is the source of truth
    - ref: https://github.com/dbt-labs/dbt/issues/1438
  - eg: columns can be created that aren't in that file
  - Docs are generated off the `schema.yaml`
  - Need to create tests to validate anything that is needed
    - ref: https://github.com/dbt-labs/dbt/issues/1570
- Removed models aren't removed from the DB
- 1-to-1 relation of table/view <-> model file
  - ref: https://stackoverflow.com/questions/63070763/create-multiple-tables-in-bigquery-using-dbt-for-loop
  - can create a macro to simplify creating similar models
- packages
  - https://docs.getdbt.com/docs/building-a-dbt-project/package-management
  - install with `dbt deps`
  - package hub: https://hub.getdbt.com/
- Redshift
  - Native support for sortkey & distkey: https://docs.getdbt.com/reference/resource-configs/redshift-configs#using-sortkey-and-distkey
  - A bunch of admin utils in dbt-labs/redshift package: https://hub.getdbt.com/dbt-labs/redshift/latest/
- Generated SQL returned in `target/`
  - `target/compile/` holds the resolved models
    - `dbt compile` to get it without running
  - `target/run/` holds the SQL run against the dB
- Update process
  - Non-incremental
    ```sql
    BEGIN
    CREATE TABLE table__dbt_tmp AS (SELECT ...)
    ALTER TABLE table RENAME TO table__dbt_backup
    ALTER TABLE table__dbt_tmp RENAME TO table
    COMMIT
    DROP TABLE table__dbt_backup
    ```
  - Incremental
    ```sql
    CREATE TABLE table__dbt_tmp123 AS (SELECT ... WHERE ...)
    BEGIN
    {compare schemas}
    DELETE FROM table WHERE (unique_key) IN (SELECT unique_key FROM table__dbt_tmp123)
    INSERT INTO table (...) (SELECT ... FROM table__dbt_tmp123)
    COMMIT
    ```
    - NOTE: An added column won't get added until we run a `run --full-refresh`
