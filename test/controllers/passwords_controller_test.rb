# typed: strict
# frozen_string_literal: true

require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  extend T::Sig

  setup do
    @user = T.let(users(:darth_vader), User)
  end

  #
  # New
  #

  test 'should show the reset password form' do
    get reset_password_url

    assert_response :ok
  end

  #
  # Create
  #

  test 'create should fail given invalid params' do
    post passwords_url, params: {
      email: 'invalid@test.org'
    }

    assert_response :unprocessable_entity
  end

  test 'should create a new password reset request given valid params' do
    post passwords_url, params: {
      email: @user.email
    }

    assert_redirected_to root_path
  end

  #
  # Update
  #

  test 'update should fail given invalid params' do
    patch password_url, params: {
      reset_password_token: 'invalid',
      password: '1111'
    }

    assert_response :unprocessable_entity
  end

  test 'should update the password given valid params' do
    @user.send_reset_password_instructions!

    patch password_url, params: {
      reset_password_token: @user.reset_password_token,
      password: '1111'
    }

    assert_redirected_to root_path
  end
end
