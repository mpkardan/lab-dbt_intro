# DBT Intro

The purpose of this lab is to explore the basics of DBT to see what it is.


## Database

I'll use the `sakila` sample DB in Postgres as provided [here](https://github.com/jOOQ/sakila).


## Notes

- The `schema.yaml` file is mainly for documentation
  - "everything is a SELECT": the model is the source of truth
  - eg: columns can be created that aren't in that file
  - Docs are generated off the `schema.yaml`
  - Need to create tests to validate anything that is needed
- Removed models aren't removed from the DB

