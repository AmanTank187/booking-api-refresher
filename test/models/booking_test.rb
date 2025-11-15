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
    booking = Booking.new(event: event, user: user)
    assert_not booking.save
  end

  test "Booking is not valid if event capacity is exceeded" do
    user = User.create(email: "aman@test.com")
    user2 = User.create(email: "aman2@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1, creator: user)
    Booking.create(event: event, user: user)
    booking = Booking.new(event: event, user: user2)
    assert_not booking.save
    assert_equal [ "event is full" ], booking.errors.full_messages
  end

  test "Booking is valid if event capacity has not been exceeded" do
    user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now, ends_at: Time.now + 1.hour, capacity: 1, creator: user)
    booking = Booking.new(event: event, user: user)
    assert booking.save
    assert_equal 1, event.bookings.length
  end

  test "Booking is not valid if event has ended" do
    user = User.create(email: "aman@test.com")
    event = Event.create(title: "New Event", starts_at: Time.now - 2.hour, ends_at: Time.now - 1.hour, capacity: 1, creator: user)
    booking = Booking.new(event: event, user: user)
    assert_not booking.save
    assert_equal [ "event has ended" ], booking.errors.full_messages
  end
end
