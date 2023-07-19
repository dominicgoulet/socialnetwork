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

  test 'valid circle' do
    assert @circle.valid?
  end
end
