#!/bin/bash

SECONDS=0

./reset.sh
./up.sh

echo "====== reset network done in $SECONDS"

cd ais
docker compose run --rm  app bash -c "RAILS_ENV=test rails db:create db:migrate"
docker compose run --rm  app bash -c "rspec spec/integration/integration_spec.rb"


echo "====== done in $SECONDS"