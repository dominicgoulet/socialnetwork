# typed: strict
# frozen_string_literal: true

class AuthenticateUser
  extend T::Sig

  class AuthenticateUserResponse < InteractorResponse
    extend T::Sig

    sig { returns(T.nilable(User)) }
    attr_accessor :user
  end

  sig { params(email: String, password: String, remote_ip: String).returns(AuthenticateUserResponse) }
  def self.call(email:, password:, remote_ip:)
    response = AuthenticateUserResponse.new

    user = Session.authenticate_with_email_and_password(
      email,
      password,
      remote_ip
    )

    if user
      response.user = user
      response.success!
    else
      response.fail!
      response.messages << 'Invalid email/password combination.'
    end

    response
  end
end
