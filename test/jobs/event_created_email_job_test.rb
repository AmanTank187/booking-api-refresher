require "test_helper"

class EventCreatedEmailJobTest < ActiveJob::TestCase
  test "An email should be sent to the creator" do
    current_user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1, creator: current_user)
    job = EventCreatedEmailJob.perform_now(event)
    assert_equal "Email has been sent to #{event.creator.email} as #{event.title} is now created", job
  end
end
