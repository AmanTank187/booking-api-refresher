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

  test "POST event successfully persists an event" do
    current_user = User.create(email: "aman@test.com")
    post api_v1_events_url, params: { event: { title: "Post testing", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 50 }, current_user_id: current_user.id }
    latest_event = Event.last
    assert_equal "Post testing", latest_event.title
  end

  test "POST event unsuccessfully returns error message" do
    current_user = User.create(email: "aman@test.com")
    post api_v1_events_url, params: { event: { starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 50 }, current_user_id: current_user.id }

    assert_equal 422, response.status
    json = JSON.parse(response.body)
    assert_equal({ "errors"=>[ "Title can't be blank" ] }, json)
  end

  test "POST to book event will book the event" do
    current_user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 20, creator: current_user)
    post api_v1_event_book_url(event.id), params: { current_user_id: current_user.id }


    assert_equal 204, response.status
    event.reload
    assert_equal 19, event.available_seats
    assert_equal [ "aman@test.com" ], event.booked_users
  end

  test "Booking event unsuccessfully when capacity is full" do
    current_user = User.create(email: "aman@test.com")
    user = User.create(email: "aman2@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1, creator: current_user)
    Booking.create(event: event, user: user)

    post api_v1_event_book_url(event.id), params: { current_user_id: current_user.id }


    assert_equal 422, response.status
    json = JSON.parse(response.body)
    assert_equal({ "errors"=>[ "event is full" ] }, json)
  end
end
