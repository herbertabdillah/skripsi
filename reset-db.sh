#!/bin/bash

cd ais
bin/spring stop || true
docker compose up -d postgres
docker compose stop app worker
docker compose run --rm  app bash -c "rails db:drop db:create db:migrate db:seed DISABLE_DATABASE_ENVIRONMENT_CHECK=1"