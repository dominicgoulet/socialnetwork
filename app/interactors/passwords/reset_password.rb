# typed: strict
# frozen_string_literal: true

class ResetPassword
  extend T::Sig

  class ResetPasswordResponse < InteractorResponse
    extend T::Sig

    sig { returns(T.nilable(User)) }
    attr_accessor :user
  end

  sig { params(reset_password_token: String, password: String).returns(ResetPasswordResponse) }
  def self.call(reset_password_token:, password:)
    response = ResetPasswordResponse.new

    response.user = Password.reset_password_with_token!(reset_password_token, password)

    if response.user
      T.must(response.user).send_reset_password_instructions!
      response.success!
    else
      response.fail!
    end

    response
  end
end
