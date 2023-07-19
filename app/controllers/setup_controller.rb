# typed: strict
# frozen_string_literal: true

class SetupController < ApplicationController
  extend T::Sig

  sig { void }
  def welcome; end

  sig { void }
  def complete
    return unless request.patch?

    T.must(current_user).complete_setup!
    redirect_to root_path
  end
end
