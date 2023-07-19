# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: audiences
#
#  id          :uuid             not null, primary key
#  activity_id :uuid             not null
#  actor_type  :string           not null
#  actor_id    :uuid             not null
#  privacy     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Audience < ApplicationRecord
  extend T::Sig

  # Associations
  belongs_to :activity
  belongs_to :actor, polymorphic: true

  # Enumerations
  enum privacy: %i[public circles limited], _prefix: :is
end
