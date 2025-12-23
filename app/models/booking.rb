class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user, uniqueness: { scope: :event }
  validate :check_event_capacity
  validate :check_event_is_on_going
  delegate :bookings_count, :has_ended?, :capacity, to: :event, prefix: true

  def check_event_capacity
    if event_bookings_count >= event_capacity
      errors.add(:base, "event is full")
    end
  end

  def check_event_is_on_going
    if event_has_ended?
       errors.add(:base, "event has ended")
    end
  end
end
