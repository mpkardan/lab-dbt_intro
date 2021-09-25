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
