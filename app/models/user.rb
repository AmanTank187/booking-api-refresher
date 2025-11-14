class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { message: "email has already been taken" }
end
