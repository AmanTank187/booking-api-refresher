class Event < ApplicationRecord
  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true, comparison: { greater_than: :starts_at }
  validates :capacity, presence: true, comparison: { greater_than: 0 }
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :bookings

  after_create_commit :send_emails

  scope :high_capacity_event, -> { where("capacity > ?", 5) }

  def available_seats
    capacity - bookings_count
  end

  def booked_users
    bookings.joins(:user).pluck(:email)
  end

  def send_emails
    EventCreatedEmailJob.perform_later(self)
  end

  def bookings_count
    bookings.count
  end

  def has_ended?
    ends_at < Time.now ? true : false
  end
end
