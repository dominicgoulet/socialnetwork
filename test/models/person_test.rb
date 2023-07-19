# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: people
#
#  id           :uuid             not null, primary key
#  display_name :string
#  slug         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @person = T.let(people(:darth_vader), Person)
  end

  test 'valid person' do
    assert @person.valid?
  end
end
