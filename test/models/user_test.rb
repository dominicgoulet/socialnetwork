# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string
#  password_digest        :string
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  sign_in_count          :integer          default(0), not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  name                   :string
#  setup_completed_at     :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @user = T.let(users(:david_prowse), User)
  end

  test 'factories' do
    assert @user.valid?
  end

  context 'associations' do
    should have_many(:identities)
    should have_many(:user_actors)
    should have_many(:brands).through(:user_actors)
    should have_many(:people).through(:user_actors)
  end

  context 'validations' do
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email)
    should validate_presence_of(:password)
    should validate_length_of(:password).is_at_least(4).on(:create)
  end

  test 'invalid without email' do
    @user.email = ''

    refute @user.valid?
    assert_not_nil @user.errors[:email]
  end

  test 'invalid without password' do
    @user.password = nil

    refute @user.valid?
    assert_not_nil @user.errors[:password]
  end

  test '.can_update_password? updates password when a valid password is supplied' do
    assert @user.can_update_password?('0000')
    refute @user.can_update_password?('1111')
  end

  test '.avatar_url returns a valid URI' do
    assert URI.parse(@user.avatar_url)
  end

  test '.confirmed? returns wether the user is confirmed or not' do
    refute @user.confirmed?
    assert @user.confirm!
    assert @user.confirmed?

    assert @user.change_email!('darth.vader2@theempire.org')
    refute @user.confirmed?

    assert @user.confirm!
    assert @user.confirmed?
  end

  test '.send_new_user_instructions! returns true' do
    assert @user.send_new_user_instructions!
  end

  test '.change_email! fails with invalid email' do
    refute @user.change_email!('darth.vader')
    assert_nil @user.unconfirmed_email
  end

  test '.change_email! manages unconfirmed_email' do
    assert @user.change_email!('darth.vader2@theempire.org')
    assert_equal @user.unconfirmed_email, 'darth.vader2@theempire.org'

    assert @user.cancel_change_email!
    assert_nil @user.unconfirmed_email

    assert @user.change_email!('darth.vader2@theempire.org')
    assert @user.confirm!
    assert_equal @user.email, 'darth.vader2@theempire.org'
    assert_nil @user.unconfirmed_email
  end

  test '.send_reset_password_instructions! sets a new password reset token and returns true' do
    assert @user.send_reset_password_instructions!
    assert_not_nil @user.reset_password_token
  end

  test '.complete_setup! completes the setup process and returns true' do
    assert @user.complete_setup!
  end
end
