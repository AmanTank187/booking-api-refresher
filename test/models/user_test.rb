require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "User should not save without an email" do
    user = User.new
    assert_not user.save
  end
end
