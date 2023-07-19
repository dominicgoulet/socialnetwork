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

  ALLOWED_PRIVACIES = T.let(%w[public circles limited].freeze, T::Array[String])

  # Associations
  belongs_to :actor, polymorphic: true
  belongs_to :activity

  # Validations
  validates :privacy, presence: true, inclusion: { in: ALLOWED_PRIVACIES }
end
