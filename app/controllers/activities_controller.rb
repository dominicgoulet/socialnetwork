# typed: strict
# frozen_string_literal: true

class ActivitiesController < ApplicationController
  extend T::Sig

  before_action :authenticate_user!, only: %i[destroy]

  sig { void }
  def index
    @activities = T.let(Activity.all.order(created_at: :desc), T.untyped) # Activity::ActiveRecord_Relation
  end
end
