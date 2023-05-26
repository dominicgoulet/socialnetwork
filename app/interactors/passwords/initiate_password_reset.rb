# typed: strict
# frozen_string_literal: true

class InitiatePasswordReset
  extend T::Sig

  class InitiatePasswordResetResponse < InteractorResponse
    extend T::Sig

    sig { returns(T.nilable(User)) }
    attr_accessor :user
  end

  sig { params(email: String).returns(InitiatePasswordResetResponse) }
  def self.call(email:)
    response = InitiatePasswordResetResponse.new

    response.user = User.find_by(email:)

    if response.user
      T.must(response.user).send_reset_password_instructions!
      response.success!
    else
      response.fail!
      response.messages << 'This email could not be found.'
    end

    response
  end
end
