#!/usr/bin/env bash
# exit on error
set -o errexit

export RAILS_ENV=production
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
bundle exec rails db:seed
