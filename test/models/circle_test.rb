# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: circles
#
#  id           :uuid             not null, primary key
#  actor_type   :string           not null
#  actor_id     :uuid             not null
#  display_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class CircleTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @circle = T.let(circles(:colleagues), Circle)
  end

  test 'factories' do
    assert @circle.valid?
  end

  context 'associations' do
    should belong_to(:actor)
    should have_many(:ties)
  end

  context 'validations' do
    should validate_presence_of(:display_name)
  end
end
