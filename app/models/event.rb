class Event < ApplicationRecord
  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true, comparison: { greater_than: :starts_at }
  validates :capacity, presence: true, comparison: { greater_than: 0 }
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :bookings

  def available_seats
    capacity - bookings.length
  end

  def booked_users
    # Possible n+1 queries, can be optimised
    bookings.map { |booking| booking.user.email }
  end
end
