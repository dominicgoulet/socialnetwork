# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id          :uuid             not null, primary key
#  actor_type  :string           not null
#  actor_id    :uuid             not null
#  activity_id :uuid             not null
#  read_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Notification < ApplicationRecord
  extend T::Sig

  # Associations
  belongs_to :actor, polymorphic: true
  belongs_to :activity
end
