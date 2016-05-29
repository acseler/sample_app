require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase

  test 'should redirect create when logged in' do
    assert_no_difference 'Relationship.count' do
      post :create
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when logged in' do
    assert_no_difference 'Relationship.count' do
      post :destroy, id: relationships(:one)
    end
    assert_redirected_to login_url
  end


end
