# typed: strict
# frozen_string_literal: true

# == Schema Information
#
# Table name: audiences
#
#  id          :uuid             not null, primary key
#  activity_id :uuid             not null
#  actor_type  :string           not null
#  actor_id    :uuid             not null
#  privacy     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class AudienceTest < ActiveSupport::TestCase
  extend T::Sig

  setup do
    @audience = T.let(audiences(:one), Audience)
  end

  test 'factories' do
    assert @audience.valid?
  end

  context 'associations' do
    should belong_to(:actor)
    should belong_to(:activity)
  end

  context 'validations' do
    should validate_presence_of(:privacy)
    should validate_inclusion_of(:privacy).in_array(Audience::ALLOWED_PRIVACIES)
  end
end
