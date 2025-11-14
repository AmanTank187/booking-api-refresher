require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "Event is not valid without title" do
    event = Event.new(starts_at: Time.now, ends_at: Time.now, capacity: 1)
    assert_not event.save
  end

  test "Event is not valid without starts_at date" do
    event = Event.new(title: "New Event", ends_at: Time.now, capacity: 1)
    assert_not event.save
  end

  test "Event is not valid ends_at date" do
    event = Event.new(title: "New Event", starts_at: Time.now, capacity: 1)
    assert_not event.save
  end

  test "Event is not valid without capacity " do
    event = Event.new(title: "New Event", starts_at: Time.now, ends_at: Time.now)
    assert_not event.save
  end

  test "Event is valid with title starts_at time, ends_at time" do
    event = Event.new(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1)
    assert event.save
  end

  test "Event is not valid if ends at date is before the starts at date" do
    event = Event.new(title: "New Event", starts_at: Time.now, ends_at: Time.now - (1.hour), capacity: 1)
    assert_not event.save
  end
end
