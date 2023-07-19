# typed: strict
# frozen_string_literal: true

require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  extend T::Sig

  # Class methods
  test '#create_with_random_password returns a new valid User instance' do
    assert Registration.create_with_random_password('emperor@theempire.org').valid?
  end

  test '#find_or_create_with_random_password returns the found user if email is found' do
    assert Registration.find_or_create_with_random_password(users(:david_prowse).email) == users(:david_prowse)
  end

  test '#find_or_create_with_random_password returns a new valid User instance when email is not found' do
    assert Registration.find_or_create_with_random_password('emperor@theempire.org').valid?
  end

  test '#find_or_create_from_omniauth returns a new valid User instance given valid auth infos' do
    auth_hash = OmniAuth::AuthHash.new({
                                         provider: 'google_oauth2',
                                         uid: '100000000000000000000',
                                         info: {
                                           email: 'stormtrooper@theempire.org'
                                         }
                                       })

    assert Registration.find_or_create_from_omniauth(auth_hash)
  end
end
