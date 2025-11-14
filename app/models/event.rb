class Event < ApplicationRecord
  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true, comparison: { greater_than: :starts_at }
  validates :capacity, presence: true, comparison: { greater_than: 0 }
end
