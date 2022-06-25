# syntax=docker/dockerfile:1
FROM ruby:2.7.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /seedr_be_tech_test
COPY Gemfile /seedr_be_tech_test/Gemfile
COPY Gemfile.lock /seedr_be_tech_test/Gemfile.lock
RUN bundle install

COPY config/database.docker.yml config/database.yml
# Configure the main process to run when running the image
CMD ['rails', 'server', '-b', '0.0.0.0']
