# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: ties
#
#  id         :uuid             not null, primary key
#  circle_id  :uuid             not null
#  actor_type :string           not null
#  actor_id   :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tie < ApplicationRecord
  extend T::Sig

  # Associations
  belongs_to :circle
  belongs_to :actor, polymorphic: true
end
