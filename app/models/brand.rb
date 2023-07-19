# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id           :uuid             not null, primary key
#  display_name :string
#  slug         :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Brand < ApplicationRecord
  extend T::Sig

  # Associations
  has_many :user_actors, inverse_of: :actor
  has_many :user, through: :user_actors
end
