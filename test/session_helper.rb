# typed: strict
# frozen_string_literal: true

module ActiveSupport
  class TestCase
    extend T::Sig

    sig { params(user: User).void }
    def sign_in!(user)
      post sessions_url, params: { email: user.email, password: '0000' }
      # session[:user_id] = user.id
    end
  end
end
