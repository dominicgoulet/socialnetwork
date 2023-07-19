# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id           :uuid             not null, primary key
#  display_name :string
#  privacy      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @group = T.let(groups(:board_of_directors), Group)
  end

  test 'valid group' do
    assert @group.valid?
  end
end
