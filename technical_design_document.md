# **Technical Design Document**

## Core Requirements:

- Add Reservations
  - Need uniqueness constraint on res per restaurant, table, and start_datetime?

- Manage table allocations based on size of reservation and restaurant capacity
  - Need Service Object? To create a reservation for a given time, restaurant, and capacity

- At-Least 3 entities - Reservation, Table, Restaurant

## Nice-to-Haves:

- JWT token authentication

## Assumptions:

- Multi-Tenant - multiple restaurants...
- Every table will have a different capacity, restaurant has a collective table capacity
- Reservations only last for 2 hours? No check-ins after start datetime?
- Restaurant capacity can be determined by reservations - no walk-ins allowed

## Scale:

- N/A

## Constraints:

- JSON responses
- POST /reservations route
- GET /tables/occupied route - list occupied tables from past time, show reservation ID and size of party
- Use RSpec
- Include seed data

## Metrics:

- N/A

## Use Cases:

- Be able to create new reservations (do we handle updates/changes?)

	- Start process to allocate tables?
	- Make sure Restaurant doesn't reach capacity given other reservations at time?

- Be able to see a list of tables that are occupied from a past time

## Scope:

- Tables can't be rearranged to create larger capacity?
- Won't add API key authorization when sending requests
- Won't add graphql client to allow for graphql queries
