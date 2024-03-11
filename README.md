# Restaurant Reservation Manager

## Introduction
Restaurant Reservation Manager is a backend API based Rails application to create reservations at various restaurants.

## Technical Considerations
A brief overview of various considerations when drafting the project.

### Design Document
Find an initial technical design outline given requirements gathering notes [here](https://github.com/GregoryDuguies/restaurant-reservation-manager/blob/main/technical_design_document.md)

### Docker
I decided to rely on Docker for my local environment setup with Postgres because it would follow the convention of containerized deployments and further reliance on kubernetes in production. This should also minimize any issues managing different databases or versions of the same database.

### Grape APIs
I primarily decided to rely on Grape for the API endpoints to gain more familiarity with the structure and patterns. I understand because the Grape APIs are mounted as a Rack application on top of your Rails app, the behaviour is a bit more lightweight and performant, especially for behaviour that is just API driven. I also understand the documentation (with grape-swagger) and serialization (with grape-entity) provides extra support for API behaviour.


### Table Allocation
My table allocation approach is quite simple. I would prefer to be able to think of a more thorough solution, but in this approach, I think as long as the reservation and table allocation operations could guarantee to happen in a single transaction, this should work well enough.

I decided that once a reservation is possible to be made, then allocate the tables with any available tables that could fit the total guest count. If no available tables could fit the whole party, then start with the largest tables and allocate guests accordingly as table capacity decreases.

I realized I had to allocate availability off of the unallocated tables capacity as opposed to the guest reservations. This would solve issues where a table is partially taken, and you don't want to have multiple reservations sharing the same table.

It also made sense to create a join table between reservations and tables in order to know what table was allocated to a reservation. Any time overlaps would rely on the reservation start and end datetimes, and then the tables could easily be navigated through this join. This would allow a many to many relationship between tables and reservations.

As for changes I would try, it would be great to understand which tables in a restaurant could be reconfigured in order to better allocate a party to a larger than table capacity. Another easy win for allocating large reservations greater than the largest available table would be to start with a large table then find the next largest table with the remainder of guests. For example, if table a sat 10 and table b sat 8, I wouldn't want to allocate a reservation of 12 to table a and table b since that takes up 18 seats. I should try to take table a and a table with capacity of 2 instead.

## How to Setup:

Follow these steps to start a Postgres service with Docker and run a local server with the application and seed data.

### Docker:

To build and run a Docker service locally for postgres use the following yml file example.

```
services:

  db:
    image: postgres
    restart: always
    user: postgres
    environment:
      POSTGRES_PASSWORD: "${POSTGRES_PASSWORD}"
    ports:
      - "5433:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data
    expose:
      - 5432
    healthcheck:
      test: [ "CMD", "pg_isready" ]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  pgdata:

```

> [!IMPORTANT]
> Make sure to define the environment variables for your local postgres password and user
> ```
> export POSTGRES_USER="__THIS IS YOUR USERNAME__"
> export POSTGRES_PASSWORD="__THIS IS YOUR PASSWORD__"
>```

You can then create and start the service with the following

```
docker compose -f __YOUR_DOCKER_COMPOSE_.yml__ up
```

Alternatively you can call ```create``` instead of ```up``` to create the container then start the container with the corresponding pid.

```
docker __CONTAINER_PID__ run
```

In order to have your local machine be able to interact with the docker postgres service, you will need to have the correct Postgres utlities installed. For example on Mac OS you can use homebrew to add the utilities.

```
brew install libpq
```

> [!IMPORTANT]
> Follow the output instructions to export the PATH and FLAGS after brew install

### Database:
Once you have confirmed access to your local Postgres docker service, you can run the typical rake commands to setup the application db locally

```
bundle exec rake db:create   # create database
bundle exec rake db:migrate  # run migrations, add tables and columns
bundle exec rake db:seed     # seed example data
```
> [!IMPORTANT]
> Make sure to define the environment variables for your local postgres password and user
> ```
> export POSTGRES_USER="__THIS IS YOUR USERNAME__"
> export POSTGRES_PASSWORD="__THIS IS YOUR PASSWORD__"
>```

### Local Server
Run your local server with puma

```
bundle exec rails s -b 127.0.0.1
```

Now you should be able to test the API endpoints locally following these examples.

## Testing:
Here is some examples you can run to interact with your local server.

### Examples:

#### Curl
Post a new reservation. (Assumes restaurant ID can be selected from interface before creating a new reservation)

```
curl --data "restaurant_id=1&owner_name=Testing Test&owner_phone_number=1-000-888-9999&start_datetime=2024-03-30T19:00:00Z&total_guests=3" http://127.0.0.1:3000/reservations -H "Accept: application/json"
```

Get occupied tables. This should return the reservation created just above
```
curl -G http://127.0.0.1:3000/tables/occupied --data "restaurant_id=1&reservation_datetime=2024-03-30T19:00:00Z" -H "Accept: application/json"
```


#### Grape Routes
Here are the defined routes. You can view by running ```bundle exec rails grape:routes```

```
     POST  |  /reservations(.json)      |    |  Create a reservation.
      GET  |  /reservations(.json)      |    |  Return all reservations
      GET  |  /reservations/:id(.json)  |    |  Return a reservation
      GET  |  /restaurants(.json)       |    |  Return all restaurants
      GET  |  /restaurants/:id(.json)   |    |  Return a restaurant
      GET  |  /tables(.json)            |    |  Return all tables
      GET  |  /tables/occupied(.json)   |    |  Return a list of occupied tables given a past datetime
      GET  |  /tables/:id(.json)        |    |  Return a table
```

### Approach:
My testing approach primarily relied on request specs. I know that this behaviour has been recommended in lieu of controller specs. I tried to right specs for the primary use cases, when creating reservations and allocating tables.

As for the model specs, I wrote the fairly basic validations and association relying on ```shoulda-matchers```. I would definitely add more wholistic model specs for the various methods I defined, but time permitting I just denoted pending specs for those examples to be written in the future.
