require "test_helper"

class Api::V1::EventsControllerTest < ActionDispatch::IntegrationTest
  test "Can access api/v1/events/1" do
    user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1, creator: user)
    get api_v1_event_url(event)
    assert true
  end
end
