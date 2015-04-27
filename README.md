
Docker Postgres
===============

A docker image of postgres:9.3 but with permissions for remote connections,
mostly so readonly connections can connect too!

Use the docker name:

    ringly/postgres

In addition, now sets up database according to environment variables:

    DB_NAME ringly
    DB_USER postgres
    DB_PASS

To use:

    docker run -d -e DB_NAME=ringly -e DB_USER=postgres -e DB_PASS= ringly/postgres

**TODO** - read only docs
