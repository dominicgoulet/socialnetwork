# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id           :uuid             not null, primary key
#  display_name :string
#  privacy      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Group < ApplicationRecord
  extend T::Sig

  ALLOWED_PRIVACIES = T.let(%w[public private secret].freeze, T::Array[String])

  # Associations
  has_many :memberships

  # Validations
  validates :display_name, presence: true
  validates :privacy, presence: true, inclusion: { in: ALLOWED_PRIVACIES }
end
