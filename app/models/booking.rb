class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user, uniqueness: { scope: :event }
  validate :check_event_capacity
  validate :check_event_is_on_going

  def check_event_capacity
    if event.bookings.count >= event.capacity
      errors.add(:base, "event is full")
    end
  end

  def check_event_is_on_going
    if event.ends_at < Time.now
       errors.add(:base, "event has ended")
    end
  end
end
