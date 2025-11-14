require "test_helper"

class BookingTest < ActiveSupport::TestCase
  test "Booking is not valid without a user" do
    user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1, creator: user)
    booking = Booking.new(event: event)
    assert_not booking.save
  end

  test "Booking is valid with event and user" do
    user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1, creator: user)
    booking = Booking.new(event: event, user: user)
    assert booking.save
  end

  test "Booking is not valid if a user is booking the same event" do
    user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1, creator: user)
    Booking.create(event: event, user: user)
    booking = Booking.create(event: event, user: user)
    assert_not booking.save
  end
end
