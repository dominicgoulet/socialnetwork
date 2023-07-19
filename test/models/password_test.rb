# typed: strict
# frozen_string_literal: true

require 'test_helper'

class PasswordTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @user = T.let(users(:david_prowse), User)
  end

  # Class methods
  test '#reset_password_with_token! resets password with a valid token and password' do
    assert @user.send_reset_password_instructions!

    refute Password.reset_password_with_token!('invalidtoken', '1111')
    refute Password.reset_password_with_token!(users(:david_prowse).reset_password_token, '1')
    assert Password.reset_password_with_token!(users(:david_prowse).reset_password_token, '1111')
  end
end
