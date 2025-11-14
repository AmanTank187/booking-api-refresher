require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "User should not save without an email" do
    user = User.new
    assert_not user.save
  end

  test "User should save with an email" do
    user = User.new(email: "aman@test.com")
    assert user.save
  end

  test "User should not save if an email is taken" do
    User.create(email: "aman@test.com")
    user = User.new(email: "aman@test.com")
    assert_not user.valid?
    assert_includes user.errors[:email], "email has already been taken"
  end
end
