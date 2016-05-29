require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Player', email: 'player@mail.ru',
                    password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be presence' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'email should be presence' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.name = 'a' * 256
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "Address #{valid_address.inspect}"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "Address #{invalid_address.inspect}"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(:remember, '')
  end

  test 'associated microposts should be destroyed' do
    @user.save
    @user.microposts.create!(content: 'Lol')
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test 'should follow and unfollow a user' do
    alex = users(:alex)
    kolya = users(:kolya)
    assert_not alex.following?(kolya)
    alex.follow(kolya)
    assert alex.following?(kolya)
    assert kolya.followers.include?(alex)
    alex.unfollow(kolya)
    assert_not alex.following?(kolya)
  end

  # test 'feed should have the right posts' do
  #   alex = users(:alex)
  #   vasya = users(:vasya)
  #   kolya = users(:vova)
  #   kolya.microposts.each do |post_following|
  #     assert kolya.feed.include?(post_following)
  #   end
  #   alex.microposts.each do |post_self|
  #     assert alex.feed.include?(post_self)
  #   end
  #   vasya.microposts.each do |post_unfollowed|
  #     assert_not vasya.feed.include?(post_unfollowed)
  #   end
  # end
end
