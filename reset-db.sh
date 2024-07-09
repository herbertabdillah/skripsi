#!/bin/bash

cd ais
bin/spring stop || true
docker compose up -d postgres
docker compose stop app worker
# DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:drop db:create db:migrate
rails db:drop db:create db:migrate db:seed