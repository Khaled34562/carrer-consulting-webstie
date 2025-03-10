# carrerproj_server

This is the starting point for your Serverpod server.

To generate the client-side code, only when changes are done on "model, endpoint" directories:

    serverpod generate

To update the database schema, create a migration:

    serverpod create-migration

To run your server, you first need to start Postgres and Redis. It's easiest to do with Docker.

    docker compose up --build --detach

You can start the Serverpod server, apply migration if any.

    dart bin/main.dart --apply-migrations

When you are finished, you can shut down Serverpod with `Ctrl-C`, then stop Postgres and Redis.

    docker compose stop
