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

  # Associations
  has_many :memberships
  has_many :actors, through: :ties
end
