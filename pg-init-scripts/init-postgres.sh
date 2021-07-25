#!/usr/bin/env bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d "$POSTGRES_DB"  <<-EOSQL
     create schema if not exists $SCHEMA;
     create table $SCHEMA.movie (
        id serial primary key,
        imdbid int not null,
        tmdbid int not null
     );
     create table $SCHEMA.user_movie_reviews (
        id serial primary key,
        movie_id int references movie(id), 
        rating float not null,
        timestamp timestamp not null
     );
EOSQL
