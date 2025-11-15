require "test_helper"

class Api::V1::EventsControllerTest < ActionDispatch::IntegrationTest
  test "Get events endpoint returns event details, number of seats available and emails of users who have booked the event" do
    user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 20, creator: user)
    Booking.create(event: event, user: user)
    get api_v1_event_url(event)
    json = JSON.parse(response.body)
    assert_equal 200, response.status
    assert_equal event.id, json["id"]
    assert_equal "New Event", json["title"]
    assert_equal 20, json["capacity"]
    assert_equal 19, json["available_seats"]
    assert_equal [ "aman@test.com" ], json["booked_users"]
  end

  test "Get events endpoint returns multiple users who have booked the event" do
    user = User.create(email: "aman@test.com")
    user2 = User.create(email: "bob@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 20, creator: user)
    Booking.create(event: event, user: user)
    Booking.create(event: event, user: user2)
    # Add testing factories, creating users and events are tedious
    get api_v1_event_url(event)
    json = JSON.parse(response.body)

    assert_equal [ "aman@test.com", "bob@test.com" ], json["booked_users"]
  end
end
