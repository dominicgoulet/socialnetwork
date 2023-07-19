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
require 'test_helper'

class TieTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @tie = T.let(ties(:colleagues_darth_vader_grand_moff_tarkin), Tie)
  end

  test 'valid tie' do
    assert @tie.circle.present?
    # assert @tie.valid?
  end
end
