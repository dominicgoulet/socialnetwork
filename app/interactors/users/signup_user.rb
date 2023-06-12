# typed: strict
# frozen_string_literal: true

class SignupUser
  extend T::Sig

  class SignupUserResponse < InteractorResponse
    extend T::Sig

    sig { returns(T.nilable(User)) }
    attr_accessor :user
  end

  sig { params(params: UserParams).returns(SignupUserResponse) }
  def self.call(params:)
    response = SignupUserResponse.new

    response.user = User.create(
      {
        email: params.email,
        first_name: params.first_name,
        last_name: params.last_name,
        password: params.password
      }
    )

    if T.must(response.user).persisted?
      T.must(response.user).send_new_user_instructions!
      response.success!
    else
      response.fail!
      response.messages << 'Invalid email/password combination.'
    end

    response
  end
end
