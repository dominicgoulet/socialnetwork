# typed: strict
# frozen_string_literal: true

class CancelEmailChange
  extend T::Sig

  class CancelEmailChangeResponse < InteractorResponse
    extend T::Sig

    sig { returns(T.nilable(User)) }
    attr_accessor :user
  end

  sig { params(user: User).returns(CancelEmailChangeResponse) }
  def self.call(user:)
    response = CancelEmailChangeResponse.new

    response.user = user

    if T.must(response.user).cancel_change_email!
      response.success!
    else
      response.fail!
      response.messages << 'This confirmation token is invalid.'
    end

    response
  end
end
