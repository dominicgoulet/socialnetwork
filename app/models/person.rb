# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: people
#
#  id           :uuid             not null, primary key
#  display_name :string
#  slug         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Person < ApplicationRecord
  extend T::Sig

  # Associations
  has_many :user_actors, inverse_of: :actor
  has_many :user, through: :user_actors

  # Validations
  validates :display_name, presence: true
  validates :slug, presence: true, uniqueness: true
end
