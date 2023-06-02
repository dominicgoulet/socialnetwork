# typed: strict
# frozen_string_literal: true

module ActionDispatch
  class IntegrationTest
    extend T::Sig

    sig { returns(T.nilable(ApplicationController)) }
    def controller
      @controller ||= T.let(nil, T.nilable(ApplicationController))
    end

    sig { params(user: User).void }
    def sign_in!(user)
      post sessions_url, params: { email: user.email, password: '0000' }
    end
  end
end
