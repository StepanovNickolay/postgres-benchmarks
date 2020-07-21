#!/bin/bash

total=1000000

psql -U postgres -h localhost -d postgres -c "
  INSERT INTO tasks (name)
  SELECT (ARRAY['Foo','Bar','Poo'])[floor(random()*3)+1]
  FROM generate_series(1, ${total}) as id
"

query1="
  SELECT COUNT(DISTINCT name)
  FROM tasks
"
echo "${query1}"
psql -U postgres -h localhost -d postgres -c "EXPLAIN ANALYZE ${query1}"

query2="
  WITH agg AS (
    SELECT DISTINCT name
    FROM tasks
    GROUP BY name
  )
  SELECT COUNT(*)
  FROM agg
"
echo "${query2}"
psql -U postgres -h localhost -d postgres -c "EXPLAIN ANALYZE ${query2}"
