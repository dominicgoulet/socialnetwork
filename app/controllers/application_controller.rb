# typed: strict
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  extend T::Sig

  sig { returns(T.nilable(User)) }
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  sig { void }
  def initialize
    @current_user = T.let(nil, T.nilable(User))
    super
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'Record not found.' }, status: :not_found
  end

  rescue_from ActionController::BadRequest do
    render json: { error: 'Invalid parameters.' }, status: :unprocessable_entity
  end

  rescue_from ActionController::ParameterMissing do
    render json: { error: 'Missing parameters.' }, status: :unprocessable_entity
  end

  sig { returns(T::Boolean) }
  def signed_in?
    current_user.present?
  end
  helper_method :signed_in?

  sig { params(user: User).void }
  def sign_in!(user)
    session[:user_id] = user.id
  end

  sig { params(user: User).void }
  def sign_in_and_redirect!(user)
    sign_in!(user)
    redirect_to root_path
  end

  sig { void }
  def sign_out!
    session[:user_id] = nil
  end

  sig { void }
  def sign_out_and_redirect!
    sign_out!
    redirect_to root_path
  end

  sig { void }
  def authenticate_user!
    redirect_to sign_in_path unless signed_in?
  end

  sig { void }
  def render_flash!
    respond_to do |format|
      format.turbo_stream do
        render partial: 'partials/flash'
      end
    end
  end
end
