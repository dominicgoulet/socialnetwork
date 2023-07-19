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
require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @membership = T.let(memberships(:darth_vader_board_of_directors), Membership)
  end

  test 'valid membership' do
    assert @membership.valid?
  end
end
