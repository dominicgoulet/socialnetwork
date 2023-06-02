# typed: strict
# frozen_string_literal: true

class SessionsController < ApplicationController
  extend T::Sig

  before_action :authenticate_user!, only: %i[destroy]

  sig { void }
  def new; end

  sig { void }
  def create
    response = AuthenticateUser.call(
      email: session_params.email,
      password: session_params.password,
      remote_ip: request.remote_ip
    )

    if response.success?
      sign_in_and_redirect!(T.must(response.user))
    else
      flash.now.alert = response.messages
      render :new, status: :unprocessable_entity
    end
  end

  sig { void }
  def destroy
    sign_out_and_redirect!
  end

  private

  #
  # SessionParams
  #

  class SessionParams < T::Struct
    const :email, String
    const :password, String
  end

  sig { returns(SessionParams) }
  def session_params
    TypedParams[SessionParams].new.extract!(params)
  end
end
