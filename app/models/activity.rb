# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id          :uuid             not null, primary key
#  actor_type  :string           not null
#  actor_id    :uuid             not null
#  object_type :string           not null
#  object_id   :uuid             not null
#  verb        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Activity < ApplicationRecord
  extend T::Sig

  ALLOWED_VERBS = T.let(%w[post share].freeze, T::Array[String])

  # Associations
  belongs_to :actor, polymorphic: true
  belongs_to :object, polymorphic: true

  # Validations
  validates :verb, presence: true, inclusion: { in: ALLOWED_VERBS }
end
