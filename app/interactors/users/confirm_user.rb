# typed: strict
# frozen_string_literal: true

class ConfirmUser
  extend T::Sig

  class ConfirmUserResponse < InteractorResponse
    extend T::Sig

    sig { returns(T.nilable(User)) }
    attr_accessor :user
  end

  sig { params(confirmation_token: String).returns(ConfirmUserResponse) }
  def self.call(confirmation_token:)
    response = ConfirmUserResponse.new

    response.user = User.find_by(confirmation_token:)

    if response.user
      T.must(response.user).confirm!
      response.success!
    else
      response.fail!
      response.messages << 'This confirmation token is invalid.'
    end

    response
  end
end
