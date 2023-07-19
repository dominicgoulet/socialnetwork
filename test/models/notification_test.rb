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
require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @notification = T.let(notifications(:one), Notification)
  end

  test 'factories' do
    assert @notification.valid?
  end

  context 'associations' do
    should belong_to(:actor)
    should belong_to(:activity)
  end
end
