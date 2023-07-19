# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :uuid             not null, primary key
#  actor_type :string           not null
#  actor_id   :uuid             not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
  extend T::Sig

  # Associations
  belongs_to :actor, polymorphic: true

  # Validations
  validates :content, presence: true
end
