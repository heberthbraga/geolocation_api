![Ruby](https://github.com/ryanwi/rails7-on-docker/workflows/Ruby/badge.svg)

# Simple Geolocation Restful API on Docker demo application

This API demonstrates a simple geolocation system built with Rails 7 and PostgreSQL. The goal of the application is 
to store geolocation data in the database based on IP address. The API is able to add, delete and provide geolocation data
for a given service provider. There is a default service provider https://ipstack.com/. 

## Tech Features

* Rails 7
* Ruby 3.1
* Dockerfile and Docker Compose configuration
* PostgreSQL database
* Rspec tests coverage
* BDD coverage with Cucumber

## Initial Setup and Running the API on local env

```
make build-local
```

## Running the API on local env

```
make start-local
```

## Stopping the API on local env

```
make stop-local
```

## Dropping the API on local env

```
make drop-volumes
```

## Preparing the Test env

```
make test-prepare
```

## Running specs

```
make rspec
```

## Running Cucumber

```
make cucumber
```