#!/bin/bash

cd ais
docker compose up -d postgres
docker compose stop app worker
RAILS_ENV=production rails db:drop db:create db:migrate db:seed DISABLE_DATABASE_ENVIRONMENT_CHECK=1
rails db:drop db:create db:migrate db:seed