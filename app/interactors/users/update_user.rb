# typed: strict
# frozen_string_literal: true

class UpdateUser
  extend T::Sig

  class ChangeEmailError < StandardError; end

  class UpdateUserResponse < InteractorResponse
    extend T::Sig

    sig { returns(T.nilable(User)) }
    attr_accessor :user
  end

  sig { params(user: User, params: UserParams).returns(UpdateUserResponse) }
  def self.call(user:, params:)
    response = UpdateUserResponse.new

    # Maybe make that a standalone interactor?
    user.change_email!(params.email) if params.email

    if user.update(update_attributes(user, params))
      response.user = user
      response.success!
    else
      response.fail!
    end

    response
  end

  sig { params(user: User, params: UserParams).returns(T::Hash[Symbol, String]) }
  def self.update_attributes(user, params)
    {
      first_name: params.first_name,
      last_name: params.last_name
    }.merge(
      should_update_password?(user, params) ? { password: params.password } : {}
    )
  end

  sig { params(user: User, params: UserParams).returns(T::Boolean) }
  def self.should_update_password?(user, params)
    return false unless params.password.present?

    user.can_update_password?(T.must(params.current_password))
  end
end
