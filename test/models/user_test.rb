require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(username: "Test", email: "test@test.test", password: "testtest")
  end

  test "user_is_valid" do
    assert @user.valid?
  end

  test "user_name_not_valid" do
    @user.username=""
    assert_not@user.valid?
  end

  test "user_name_too_long" do
    @user.username="a"*200
    assert_not@user.valid?
  end

  test "email_too_long" do
    @user.email="a"*300
    assert_not@user.valid?
  end

  test "email_empty" do
    @user.email=nil
    assert_not@user.valid?
  end

  test "password_empty" do
    @user.password_digest=nil
    assert_not@user.valid?
  end
end
