# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: circles
#
#  id           :uuid             not null, primary key
#  actor_type   :string           not null
#  actor_id     :uuid             not null
#  display_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Circle < ApplicationRecord
  extend T::Sig

  # Associations
  belongs_to :actor, polymorphic: true
  has_many :ties

  # Validations
  validates :display_name, presence: true
end
