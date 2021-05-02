#!/bin/bash

echo "Starting Sidekiq"
bin/sidekiq -C config/sidekiq.yml -r ./sidekiq.rb -vv
