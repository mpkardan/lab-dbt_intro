#!/bin/bash
set -e

cd ~/git/external
[ -d sakila ] || git clone https://github.com/jOOQ/sakila.git
cd sakila/postgres-sakila-db

pgrep postgres > /dev/null || pg_ctl -D /usr/local/var/postgres start

psql -d postgres -c "DROP DATABASE IF EXISTS sakila"
psql -d postgres -c "DROP USER IF EXISTS postgres"
psql -d postgres -c "CREATE USER postgres WITH SUPERUSER"
psql -d postgres -c "CREATE DATABASE sakila WITH OWNER postgres"
psql -U mark -d sakila -c "ALTER SCHEMA public OWNER TO postgres"
psql -U mark -d sakila -c "ALTER LANGUAGE plpgsql OWNER TO postgres"
psql -U postgres -d sakila -f postgres-sakila-schema.sql
psql -U postgres -d sakila -f postgres-sakila-insert-data.sql
