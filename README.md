### IQDBS

This project has been archived. It is no longer used by Danbooru. It has been
replaced by a rewritten version of IQDB that speaks HTTP directly. See
https://github.com/danbooru/iqdb.

### Old README

iqdbs is a service for running IQDB. It listens on Amazon SQS for update 
requests to download and process images, and also has a simple web frontend
for query requests.

iqdbs runs a separate daemon process to handle SQS messages, and a Unicorn+
Sinatra frontend for handling HTTP reqests.

You can deploy using Capistrano. It's recommended you fork this project and
modify the following files:

  config/deploy/production.rb
  .env

A sample .env file called .env-SAMPLE is included in the project. The .env
file itself is symlinked during deployment so you should create a version on
the server at /var/www/iqdbs/shared/.env.
