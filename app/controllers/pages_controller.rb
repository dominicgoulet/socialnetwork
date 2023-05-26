# typed: strict
# frozen_string_literal: true

class PagesController < ApplicationController
  extend T::Sig

  sig { void }
  def index
    redirect_to sign_in_path unless signed_in?
  end
end
