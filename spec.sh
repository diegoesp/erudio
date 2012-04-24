#!/bin/bash

# Runs the complete set of tests and migration. Should be executed everytime before a push to the master branch
bundle exec rake db:drop
bundle exec rake db:migrate
bundle exec rake db:populate
bundle exec rake db:test:prepare
bundle exec rspec spec