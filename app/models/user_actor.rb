# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: user_actors
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  actor_type :string           not null
#  actor_id   :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserActor < ApplicationRecord
  extend T::Sig

  # Associations
  belongs_to :user
  belongs_to :actor, polymorphic: true
end
