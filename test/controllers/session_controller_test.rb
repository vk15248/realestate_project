require 'test_helper'
include SessionHelper

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    post login_path, params: {session: {email: "", password: ""}}
    assert_not flash.empty?
  end

  test "login with valid information" do
    @user = users(:one)
    post login_path, params: {session: {email: @user.email, password: "test1test1"}}
    follow_redirect!
    assert_template 'users/show'
  end

  test "login with invalid password" do
    @user = users(:one)
    post login_path, params: {session: {email: @user.email, password: "test2test1"}}
    assert_not flash.empty?
  end

  test "logout" do
    @user = users(:one)
    post login_path, params: {session: {email: @user.email, password: "test1test1"}}
    assert_equal current_user, @user
    delete logout_path
    assert_nil current_user
  end
end
