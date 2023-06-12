# typed: strict
# frozen_string_literal: true

require 'test_helper'

class OmniauthControllerTest < ActionDispatch::IntegrationTest
  extend T::Sig

  setup do
    OmniAuth.config.test_mode = true

    %i[google_oauth2].each do |provider|
      OmniAuth.config.mock_auth[provider] = nil
    end
  end

  #
  # Create
  #

  test 'should handle proper google_oauth2 auth' do
    get omniauth_callback_url('google_oauth2'),
        env: { 'omniauth.auth' => OmniAuth::AuthHash.new(auth_hash(:google_oauth2)) }

    assert_redirected_to root_path
  end

  test 'should handle invalid auth' do
    get omniauth_callback_url('google_oauth2'),
        env: { 'omniauth.auth' => OmniAuth::AuthHash.new(auth_hash(:invalid)) }

    assert_redirected_to root_path
  end

  #
  # Failure
  #

  test 'should render a failure json when there is an error' do
    get omniauth_failure_url, params: {
      message: :no_authorization,
      strategy: :google_oauth2
    }, as: :turbo_stream

    assert_response :ok
  end

  sig { params(provider: Symbol).returns(T::Hash[T.untyped, T.untyped]) }
  def auth_hash(provider)
    {}.merge(
      google_oauth2_auth_hash,
      invalid_auth_hash
    )[provider]
  end

  sig { returns(T::Hash[T.untyped, T.untyped]) }
  def google_oauth2_auth_hash
    {
      google_oauth2: {
        provider: 'google_oauth2',
        uid: '100000000000000000000',
        info: {
          email: 'joe@bloggs.com'
        }
      }
    }
  end

  sig { returns(T::Hash[T.untyped, T.untyped]) }
  def invalid_auth_hash
    {
      invalid: {
        provider: 'google_oauth2',
        uid: '1234567'
      }
    }
  end
end
