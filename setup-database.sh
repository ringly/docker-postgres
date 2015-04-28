#!/bin/bash

TEST=`gosu postgres postgres --single <<- EOSQL
   SELECT 1 FROM pg_database WHERE datname='$DB_NAME';
EOSQL`

echo "******CREATING DOCKER DATABASE******"
if [[ $TEST == "1" ]]; then
    # database exists
    # $? is 0
    exit 0
else
# gosu postgres postgres --single <<- EOSQL
#    CREATE ROLE $DB_USER WITH LOGIN ENCRYPTED PASSWORD '${DB_PASS}' CREATEDB;
# EOSQL

gosu postgres postgres --single <<- EOSQL
   CREATE ROLE $DB_USER CREATEDB;
EOSQL

gosu postgres postgres --single <<- EOSQL
   CREATE DATABASE $DB_NAME WITH OWNER $DB_USER TEMPLATE template0 ENCODING 'UTF8';
EOSQL

gosu postgres postgres --single <<- EOSQL
   GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
EOSQL

gosu postgres postgres --single <<- EOSQL
    CREATE USER $DB_READONLY_USER;
    GRANT CONNECT ON DATABASE ringly to $DB_READONLY_USER;
    GRANT USAGE ON SCHEMA public to $DB_READONLY_USER;
    GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO $DB_READONLY_USER;
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO $DB_READONLY_USER;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO $DB_READONLY_USER;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON SEQUENCES TO $DB_READONLY_USER;
EOSQL
fi

echo ""
echo "******DOCKER DATABASE CREATED******"
