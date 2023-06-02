# typed: strict
# frozen_string_literal: true

class OmniauthController < ApplicationController
  extend T::Sig

  sig { void }
  def create
    user = Registration.find_or_create_from_omniauth(request.env['omniauth.auth'])
    # return unless user.persisted?

    sign_in_and_redirect!(user)
  end

  sig { void }
  def failure
    flash.now.notice = params[:message]
    render_flash!
  end
end
