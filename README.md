## POSTGRES USING DOCKER

- for creating a docker image and container

```bash

docker run -d --name postgres_sql_pg -e POSTGRES_PASSWORD=laxman -p 5433:5432 postgres:18

```
/// --------- xxxxxxxxxxxx ---------

- for setup the enviroment

```bash

docker exec -it postgres_sql_pg psql -U postgres

```
/// --------- xxxxxxxxxxxx ---------

- create database

```bash

$ CREATE DATABASE postgres_ql;

```
