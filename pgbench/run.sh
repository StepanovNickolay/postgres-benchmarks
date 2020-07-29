#!/bin/bash

docker exec -it pg pgbench -U postgres -i -s 100
docker exec -it pg pgbench -U postgres -c 99 -T 120 -j 2 -P 10
docker exec -it pg echo "SELECT count(DISTINCT id) FROM tasks;" | pgbench -t 50 -P 1 -f -


