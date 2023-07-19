# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id           :uuid             not null, primary key
#  display_name :string
#  slug         :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @brand = T.let(brands(:the_empire), Brand)
  end

  test 'factories' do
    assert @brand.valid?
  end

  context 'associations' do
    should have_many(:user_actors)
    should have_many(:user)
  end

  context 'validations' do
    should validate_presence_of(:display_name)
    should validate_presence_of(:slug)
    should validate_uniqueness_of(:slug)
  end
end
