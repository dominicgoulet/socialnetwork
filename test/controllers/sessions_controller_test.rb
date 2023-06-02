# typed: strict
# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  extend T::Sig

  setup do
    @user = T.let(users(:darth_vader), User)
  end

  #
  # New
  #

  test 'should show the sign in form' do
    get sign_in_url

    assert_response :ok
  end

  #
  # Create
  #

  test 'create should fail given invalid params' do
    post sessions_url

    assert_response :unprocessable_entity
  end

  test 'should create a new session given valid params' do
    post sessions_url, params: {
      email: @user.email,
      password: '0000'
    }

    assert_redirected_to root_path
  end

  #
  # Destroy
  #

  test 'should redirect to sign in if not signed in' do
    delete sign_out_url

    assert_redirected_to sign_in_path
  end

  test 'should delete current session if signed in' do
    sign_in!(@user)

    delete sign_out_url

    assert_redirected_to root_path
  end
end
