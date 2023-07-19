# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id          :uuid             not null, primary key
#  actor_type  :string           not null
#  actor_id    :uuid             not null
#  object_type :string           not null
#  object_id   :uuid             not null
#  verb        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @activity = T.let(activities(:one), Activity)
  end

  test 'factories' do
    assert @activity.valid?
  end

  context 'associations' do
    should belong_to(:actor)
    should belong_to(:object)
  end

  context 'validations' do
    should validate_presence_of(:verb)
    should validate_inclusion_of(:verb).in_array(Activity::ALLOWED_VERBS)
  end
end
