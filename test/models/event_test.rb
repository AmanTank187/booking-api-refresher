require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "Event does not save without title" do
    event = Event.new()
    assert_not event.save
  end

  test "Event saves with title" do
    event = Event.new(title: "New Event")
    assert event.save
  end
end
