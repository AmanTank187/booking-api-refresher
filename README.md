# README

Requirements
1. Models

Implement the following models and associations:

User

email (required, unique)

Event

title (required)

starts_at (required)

ends_at (required & must be after starts_at)

capacity (required, integer > 0)

Associations:

belongs to User (as creator)

has many bookings

Booking

belongs to User

belongs to Event

Validations:

Prevent double-booking the same event by the same user

Prevent booking if the event is full

Prevent booking if the event has already ended

2. Endpoints

Build a JSON API with these endpoints:

POST /events

Creates an event.

GET /events/:id

Returns event details including:

number of remaining seats

array of user emails who booked

POST /events/:id/book

Creates a booking for the current user.

Assume authentication is mocked (e.g., current_user = User.first is acceptable).

3. Background Job

When an event is created, enqueue a background job that sends a mock “Event Created” email to the creator.

Implement this using ActiveJob with either sidekiq or async adapter.

The job can simply log a message.

4. Unit Tests

Write RSpec tests for:

Booking model validation rules

Booking creation endpoint (success + failure cases)

Bonus (optional)

If time allows:

Add pagination to the GET /events list endpoint.

Add a location field and geocode it (using geocoder gem).

Add authentication with devise.
