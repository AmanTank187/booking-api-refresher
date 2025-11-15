require "test_helper"

class Api::V1::EventsControllerTest < ActionDispatch::IntegrationTest
  test "Get events endpoint returns the number of seats available" do
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
  end
end
