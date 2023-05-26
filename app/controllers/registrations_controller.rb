# typed: strict
# frozen_string_literal: true

class RegistrationsController < ApplicationController
  extend T::Sig

  before_action :authenticate_user!, only: %i[show update cancel_email_change]

  sig { void }
  def new
    @user = User.new
  end

  sig { void }
  def show; end

  sig { void }
  def create
    response = SignupUser.call(params: user_params)

    if response.success?
      sign_in_and_redirect!(T.must(response.user))
    else
      @user = T.let(response.user, T.nilable(User))
      flash.now.alert = response.messages
      render :new, status: :unprocessable_entity
    end
  end

  sig { void }
  def update
    response = UpdateUser.call(user: T.must(current_user), params: user_params)

    if response.success?
      redirect_to response.user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  sig { void }
  def confirm
    response = ConfirmUser.call(confirmation_token: confirmations_params.confirmation_token)

    if response.success?
      sign_in_and_redirect!(T.must(response.user))
    else
      flash.now.alert = response.messages
      render :confirm, status: :unprocessable_entity
    end
  end

  sig { void }
  def accept_invitation
    response = ConfirmUser.call(confirmation_token: confirmations_params.confirmation_token)

    if response.success?
      sign_in_and_redirect!(T.must(response.user))
    else
      flash.now.alert = response.messages
      render :accept_invitation, status: :unprocessable_entity
    end
  end

  sig { void }
  def cancel_email_change
    response = CancelEmailChange.call(user: T.must(current_user))

    if response.success?
      redirect_to response.user
    else
      flash.now.alert = response.messages
      render :cancel_email_change, status: :unprocessable_entity
    end
  end

  private

  sig { returns(UserParams) }
  def user_params
    TypedParams[UserParams].new.extract!(params.fetch(:user))
  end

  #
  # ConfirmationParams
  #

  class ConfirmationParams < T::Struct
    const :confirmation_token, String
  end

  sig { returns(ConfirmationParams) }
  def confirmations_params
    TypedParams[ConfirmationParams].new.extract!(params)
  end
end
