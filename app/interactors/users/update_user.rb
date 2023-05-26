# typed: strict
# frozen_string_literal: true

class UpdateUser
  extend T::Sig

  class UpdateUserResponse < InteractorResponse
    extend T::Sig

    sig { returns(T.nilable(User)) }
    attr_accessor :user
  end

  sig { params(user: User, params: UserParams).returns(UpdateUserResponse) }
  def self.call(user:, params:)
    response = UpdateUserResponse.new

    user.change_email!(params.email) if params.email
    user.update(update_attributes(user, params))

    if response.user
      T.must(response.user).send_new_user_instructions!
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
    user.can_update_password?(T.must(params.current_password)) && params.password.present?
  end
end
