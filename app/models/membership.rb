# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: memberships
#
#  id         :uuid             not null, primary key
#  group_id   :uuid             not null
#  actor_type :string           not null
#  actor_id   :uuid             not null
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Membership < ApplicationRecord
  extend T::Sig

  # Associations
  belongs_to :group
  belongs_to :actor, polymorphic: true
end
