require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
    assert_select 'title', 'About'
  end

  test "should get hello" do
    get :hello
    assert_response :success
    assert_select 'title', 'Hello'
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select 'title', 'Help'
  end

end
