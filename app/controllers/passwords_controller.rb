# typed: strict
# frozen_string_literal: true

class PasswordsController < ApplicationController
  extend T::Sig

  sig { void }
  def new; end

  sig { void }
  def create
    response = InitiatePasswordReset.call(email: reset_password_params.email)

    if response.success?
      redirect_to response.user
    else
      flash.now.alert = response.messages
      render :new, status: :unprocessable_entity
    end
  end

  sig { void }
  def edit; end

  sig { void }
  def update
    response = ResetPassword.call(
      reset_password_token: recover_password_params.reset_password_token,
      password: recover_password_params.password
    )

    if response.success?
      sign_in_and_redirect!(T.must(response.user))
    else
      flash.now.alert = response.messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  #
  # ResetPasswordParams
  #

  class ResetPasswordParams < T::Struct
    const :email, String
  end

  sig { returns(ResetPasswordParams) }
  def reset_password_params
    TypedParams[ResetPasswordParams].new.extract!(params)
  end

  #
  # RecoverPasswordParams
  #

  class RecoverPasswordParams < T::Struct
    const :reset_password_token, String
    const :password, String
  end

  sig { returns(RecoverPasswordParams) }
  def recover_password_params
    TypedParams[RecoverPasswordParams].new.extract!(params)
  end
end
