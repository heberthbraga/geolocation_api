#!/bin/bash
set -e

cd /app

echo "bundle install..."
bundle check || bundle install --jobs 4

if [ $RAILS_ENV != 'production' ]; then
  echo "crating db..."
  bin/rails db:create
  
  echo "running migrations..."
  bundle exec bin/rails db:migrate

  echo "running seeds..."
  bundle exec bin/rails db:seed
fi

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

bundle exec rails server -b 0.0.0.0
tail -f /dev/null