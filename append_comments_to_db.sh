#!/bin/bash
set -e

psql -U postgres -d sakila -c "CREATE TABLE IF NOT EXISTS comment (id SERIAL PRIMARY KEY, customer_id int, body VARCHAR(100), CONSTRAINT comment_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer (customer_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT)"

customer_count=599

for i in {1..20}
do
  customer_id=$(echo $((1 + ${RANDOM} % ${customer_count})))
  body=$(head /dev/urandom | LC_ALL=C tr -dc A-Za-z0-9 | head -c 10)
  echo "Inserting comment: ${customer_id}, ${body}"
  psql -U postgres -d sakila -c "INSERT INTO comment (customer_id, body) VALUES(${customer_id}, '${body}')"
done
