require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "Event does not save without title" do
    event = Event.new(starts_at: Time.now(), ends_at: Time.now(), capacity: 1)
    assert_not event.save
  end

  test "Event does not save without starts_at date" do
    event = Event.new(title: "New Event", ends_at: Time.now(), capacity: 1)
    assert_not event.save
  end

  test "Event does not save without ends_at date" do
    event = Event.new(title: "New Event", starts_at: Time.now(), capacity: 1)
    assert_not event.save
  end

  test "Event does not save without capacity " do
    event = Event.new(title: "New Event", starts_at: Time.now(), ends_at: Time.now())
    assert_not event.save
  end

  test "Event saves with title starts_at time, ends_at time" do
    event = Event.new(title: "New Event", starts_at: Time.now(), ends_at: Time.now(), capacity: 1)
    assert event.save
  end
end
