# typed: strict
# frozen_string_literal: true

require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  extend T::Sig

  setup do
    @user = T.let(users(:david_prowse), User)
  end

  #
  # New
  #

  test 'should show the registration form' do
    get sign_up_url

    assert_response :ok
  end

  #
  # Create
  #

  test 'create should fail given invalid params' do
    post registrations_url, params: {
      user: {
        email: @user.email,
        password: '0000'
      }
    }

    assert_response :unprocessable_entity
  end

  test 'should create a new user given valid params' do
    post registrations_url, params: {
      user: {
        email: 'anakin@skywalker.org',
        password: '0000'
      }
    }

    assert_redirected_to root_path
  end

  #
  # Show
  #

  test 'should show the profile' do
    sign_in!(@user)

    get profile_url

    assert_response :ok
  end

  #
  # Edit
  #

  test 'should show the edit registration form' do
    sign_in!(@user)

    get edit_profile_url

    assert_response :ok
  end

  #
  # Update
  #

  test 'update should fail given invalid params' do
    sign_in!(@user)

    patch profile_url, params: {
      user: {}
    }

    assert_response :unprocessable_entity
  end

  test 'should update the user given valid params' do
    sign_in!(@user)

    patch profile_url, params: {
      user: {
        name: 'Luke Skywalker'
      }
    }

    assert_redirected_to profile_path
  end

  #
  # Confirm
  #

  #
  # Accept Invitation
  #

  #
  # Cancel Email Change
  #
end
