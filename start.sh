#!/bin/bash

sudo rm -rf pg_data

docker build -t pg . && docker run -p 5432:5432 --rm \
  -e POSTGRES_HOST_AUTH_METHOD=trust \
  -v $(pwd)/pg_data:/logs \
  --name pg pg